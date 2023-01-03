import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:iptv/core/api_service/auth_service.dart';
import 'package:iptv/core/api_service/channel_service.dart';
import 'package:iptv/core/api_service/dvr_service.dart';
import 'package:iptv/core/api_service/settings_service.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/helpers/json_decode_service.dart';
import 'package:iptv/core/helpers/json_serializable_worker_pool_converter.dart';
import 'package:iptv/core/mqtt_helper.dart';
import 'package:iptv/core/repositories/authentication_repository.dart';
import 'package:logging/logging.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:squadron/squadron.dart';

void initSquadron(String id) {
  Squadron.setId(id);
  Squadron.setLogger(ConsoleSquadronLogger());
  Squadron.logLevel = SquadronLogLevel.all;
  Squadron.debugMode = kDebugMode;
}

class AppBlocObserver extends BlocObserver {}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  String url = 'https://api.iptv.safepayhost.com:8088/api/dvrapi.php',
  String dsn =
      'https://22f1424a9a37477e850e729db6c1f9f7@o1285985.ingest.sentry.io/4504089948258304',
  required AuthenticationRepository authenticationRepository,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  final logger = Logger('mdu1.tv');
  Logger.root.level = Level.ALL;
  if (kDebugMode) {
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  FlutterError.onError = (details) {
    if (details.exceptionAsString().contains('RenderFlex overflowed')) return;
    if (kDebugMode) {
      log(details.exceptionAsString(), stackTrace: details.stack);
      return;
    }

    Sentry.captureException(
      details.exceptionAsString(),
      stackTrace: details.stack,
    );

    try {
      final message = MqttClientPayloadBuilder()
        ..addString(
          buildAction(
            {
              'message': details.exceptionAsString(),
              'stackTrace': details.stack,
            },
            MqttAction.warning,
          ),
        );

      final client = GetIt.I.get<MqttServerClient>();

      if (client.connectionStatus?.state == MqttConnectionState.connected &&
          message.payload != null) {
        client.publishMessage(
          'tv/errorlog',
          MqttQos.atLeastOnce,
          message.payload!,
        );
      }
    } catch (e) {
      // no-op: could fail on first boot
    }
  };

  DeviceId.deviceId = (Platform.isAndroid
      ? (await DeviceInfoPlugin().androidInfo).androidId
      : (await DeviceInfoPlugin().iosInfo)
          .identifierForVendor
          ?.replaceAll('-', '')
          .substring(
            0,
            12,
          ))!;

  // DeviceId.deviceId = '98ACF1F8AB9F';

  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    DeviceId.isStb = androidInfo.model.toString().toLowerCase() == 'stvs2' ||
        androidInfo.model.toString().toLowerCase() == 'sdk_google_atv_x86';
  }

  if (DeviceId.isStb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.leanBack,
      overlays: [],
    );
  }

  GetIt.I.registerSingleton<Logger>(logger);

  Bloc.observer = AppBlocObserver();

  initSquadron('mdu1_worker_pool');

  final storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  final jsonDecodeServiceWorkerPool = JsonDecodeServiceWorkerPool();

  final converter = JsonSerializableWorkerPoolConverter(
    const {},
    jsonDecodeServiceWorkerPool,
  );

  GetIt.I.registerSingleton<JsonDecodeServiceWorkerPool>(
    jsonDecodeServiceWorkerPool,
  );

  final client = SentryHttpClient(
    networkTracing: true,
    sendDefaultPii: true,
    captureFailedRequests: true,
    client: RetryClient(
      http.Client(),
    ),
  );

  GetIt.I.registerSingleton<ChopperClient>(
    ChopperClient(
      client: client,
      baseUrl: url,
      services: [
        AuthService.create(),
        ChannelService.create(),
        DVRService.create(),
        SettingsService.create(),
      ],
      interceptors: [
        (Request request) async {
          final queryMap = request.parameters;
          final listOfCommands = <String>[];

          if (authenticationRepository.user != null) {
            queryMap.addAll({
              'token': authenticationRepository.user!.accessToken,
              'custid': authenticationRepository.user!.customerId,
              'cid': authenticationRepository.user!.customerId,
              'CustomerID': authenticationRepository.user!.customerId,
              'id': authenticationRepository.user!.customerId,
              'mac': DeviceId.deviceId,
            });
          }

          queryMap.forEach((k, v) => listOfCommands.add('"$k":"$v"'));

          return request.copyWith(
            parameters: {},
            url: "${request.url}?uri={${listOfCommands.join(",")}}",
          );
        },
        HttpLoggingInterceptor(),
      ],
      converter: converter,
    ),
  );

  await Hive.initFlutter();

  await runZonedGuarded(
    () async {
      if (dsn.isNotEmpty) {
        var finalDsn = dsn;
        if (DeviceId.isStb) {
          finalDsn = dsn;
        } else {
          if (Platform.isAndroid) {
            finalDsn =
                'https://d9dfed9640fe4a8db88306c174587fb8@o1285985.ingest.sentry.io/4504165094064128';
          } else {
            finalDsn =
                'https://4784c03bd6564e25a387a8009f1e6958@o1285985.ingest.sentry.io/4504165089083392';
          }
        }

        await SentryFlutter.init(
          (options) {
            options
              ..dsn = finalDsn
              ..sendDefaultPii = true
              ..reportPackages = false
              ..attachThreads = true
              ..addIntegration(LoggingIntegration())
              ..attachStacktrace = true;
          },
        );
      }

      return HydratedBlocOverrides.runZoned(
        () async => runApp(await builder()),
        storage: storage,
      );
    },
    (error, stackTrace) {
      if (kDebugMode) {
        log(error.toString(), stackTrace: stackTrace);
        return;
      }

      Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      try {
        final message = MqttClientPayloadBuilder()
          ..addString(
            buildAction(
              {
                'message': error,
                'stackTrace': stackTrace,
              },
              MqttAction.severe,
            ),
          );

        final client = GetIt.I.get<MqttServerClient>();

        if (client.connectionStatus?.state == MqttConnectionState.connected &&
            message.payload != null) {
          client.publishMessage(
            'tv/errorlog',
            MqttQos.atLeastOnce,
            message.payload!,
          );
        }
      } catch (e) {
        // no-op: could fail on first boot
      }
    },
  );
}
