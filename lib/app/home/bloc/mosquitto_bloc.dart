import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_install_apk_silently/flutter_install_apk_silently.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:iptv/app/home/bloc/channel_bloc.dart';
import 'package:iptv/app/view/app_brightness_cubit.dart';
import 'package:iptv/app/view/navigation_service.dart';
import 'package:iptv/core/api_service/auth_service.dart';
import 'package:iptv/core/api_service/fetch_ota.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/models/user_data.dart';
import 'package:logging/logging.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:restart_app/restart_app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:wifi_info_plugin_plus/wifi_info_plugin_plus.dart';

part 'mosquitto_bloc.freezed.dart';
part 'mosquitto_event.dart';
part 'mosquitto_state.dart';

class MosquittoBloc extends Bloc<MosquittoEvent, MosquittoState> {
  MosquittoBloc() : super(const _Initial()) {
    on<MosquittoEvent>((event, emit) async {
      await event.when(
        check: () async {
          if (client == null) return;

          if (client?.connectionStatus?.state !=
              MqttConnectionState.connected) {
            emit(const _Error('MQTT is not active.'));
          } else {
            emit(const _Loaded());
          }
        },
        started: (user) async {
          emit(const _Loading());

          try {
            await sendDeviceStatus(user);
          } catch (e, st) {
            emit(
              _Error(
                '[500] [DeviceStats] $e',
              ),
            );

            try {
              GetIt.I.get<Logger>().severe(
                    '[500] [DeviceStats] Unexpected error!',
                    e,
                    st,
                  );
            } catch (e) {
              // no-op
            }
          }

          try {
            unawaited(
              fetchOta(
                show: true,
                user: user,
              ),
            );
            _otaTimer ??=
                Stream.periodic(const Duration(minutes: 5), (x) => x).listen(
              (_) => fetchOta(show: false, user: user),
              onError: (Object error, StackTrace stackTrace) =>
                  GetIt.I.get<Logger>().severe(
                        'Error refetching OTA...',
                        error,
                        stackTrace,
                      ),
            );
          } catch (e, st) {
            try {
              GetIt.I.get<Logger>().severe(
                    '[500] [OTA] Unexpected error!',
                    e,
                    st,
                  );
            } catch (e) {
              // no-op
            }
          }

          final client = MqttServerClient.withPort(
            'mq.safepayhost.com',
            DeviceId.deviceId,
            8883,
          )..keepAlivePeriod = 60;

          final securityContext = SecurityContext.defaultContext;
          try {
            if (!DeviceId.isMqttCertLoaded) {
              final data = await PlatformAssetBundle().load('cert.pem');
              securityContext
                  .setTrustedCertificatesBytes(data.buffer.asUint8List());
              DeviceId.isMqttCertLoaded = true;
            }
          } catch (e) {
            // no-op
          }

          client
            ..secure = true
            ..logging(on: kDebugMode)
            ..onBadCertificate = ((dynamic certificate) => true)
            ..securityContext = securityContext
            ..autoReconnect = true
            ..connectionMessage = MqttConnectMessage()
                .authenticateAs('MDU1IOT', 'Bloodsucker')
                .withClientIdentifier(DeviceId.deviceId)
                .startClean()
                .withWillTopic('tv/muerte')
                .withWillMessage('{"id":"${DeviceId.deviceId}"}')
                .withWillQos(MqttQos.atLeastOnce);

          try {
            _reconnectMqttTimer ??=
                Stream.periodic(const Duration(minutes: 5), (x) => x).listen(
              (_) {
                client.doAutoReconnect();
              },
              onError: (Object error, StackTrace stackTrace) =>
                  GetIt.I.get<Logger>().severe(
                        'Error reconnecting MQTT...',
                        error,
                        stackTrace,
                      ),
            );
          } catch (e) {
            // no-op
          }

          _mosquittoChecker ??=
              Stream.periodic(const Duration(minutes: 1), (x) => x).listen(
            (_) {
              add(const _Check());
            },
            onError: (Object error, StackTrace stackTrace) =>
                GetIt.I.get<Logger>().severe(
                      'Error checking MQTT connection...',
                      error,
                      stackTrace,
                    ),
          );

          await client.connect().then((_) {
            if (client.connectionStatus!.state !=
                MqttConnectionState.connected) {
              emit(const _Error('Connection failed'));

              throw Exception(
                'ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}',
              );
            } else if (client.connectionStatus!.state ==
                MqttConnectionState.connected) {
              emit(const _Loaded());
            }

            this.client = client;

            GetIt.I.registerSingleton<MqttServerClient>(client);

            client.published!.listen((MqttPublishMessage message) {
              GetIt.I.get<Logger>().info(
                    'Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos} with payload ${String.fromCharCodes(message.payload.message)}',
                  );
            });

            client.subscribe('tv/${DeviceId.deviceId}', MqttQos.atLeastOnce);

            client.updates!
                .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
              final recMess = c![0].payload as MqttPublishMessage?;
              if (recMess != null) {
                final pt = MqttPublishPayload.bytesToStringAsString(
                  recMess.payload.message,
                );
                final parseJson = jsonDecode(pt) as Map<String, dynamic>;

                final cmd = parseJson['cmd'];
                if (cmd == 'vol' && parseJson.containsKey('percent')) {
                  PerfectVolumeControl.setVolume(
                    num.parse(parseJson['percent'].toString()).toDouble() / 100,
                  );
                } else if (cmd == 'power' && parseJson.containsKey('action')) {
                  final action = parseJson['action'] == 0;

                  if (NavigationService.navigatorKey.currentContext == null) {
                    return;
                  }

                  if (action) {
                    if (!DeviceId.isStb) return;

                    NavigationService.navigatorKey.currentContext!
                        .read<AppBrightnessCubit>()
                        .turnOff();
                  } else {
                    if (!DeviceId.isStb) return;

                    Restart.restartApp();
                  }
                } else if (cmd == 'chan') {
                  final stream = parseJson['num'].toString();

                  if (NavigationService.navigatorKey.currentContext == null) {
                    return;
                  }

                  NavigationService.navigatorKey.currentContext!
                      .read<ChannelBloc>()
                      .state
                      .maybeMap(
                        loaded: (state) {
                          final channelIndex = state.channels.indexWhere(
                            (element) =>
                                element.epgChannelId.toLowerCase() ==
                                stream.toLowerCase(),
                          );
                          if (channelIndex == -1) return;

                          NavigationService.navigatorKey.currentContext!
                              .read<ChannelBloc>()
                              .add(const ChannelEvent.changeGenre(0));

                          NavigationService.navigatorKey.currentContext!
                              .read<ChannelBloc>()
                              .add(ChannelEvent.changeChannel(channelIndex));
                        },
                        orElse: () => null,
                      );
                } else if (cmd == 'install') {
                  final url = parseJson['url'].toString();
                  download(url);
                } else if (cmd == 'update') {
                  switch (parseJson['data']) {
                    case 'reboot':
                      FlutterInstallApkSilently.rebootDevice()
                          .catchError((error) {
                        SmartDialog.showToast(
                          'There was an error automatically restarting your device.',
                        );
                      });
                      break;
                    case 'ota':
                      fetchOta(show: true, user: user);
                      break;
                    default:
                      break;
                  }
                }

                //   } else if (parseJson.containsKey('stream')) {
                //     context
                //         .read<CommunityCubit>()
                //         .changeCommunity(parseJson['stream'].toString());
                //   } else if (cmd == 'update' && parseJson.containsKey('data')) {
                //     switch (parseJson['data']) {
                //       case 'reboot':
                //         FlutterInstallApkSilently.rebootDevice()
                //             .catchError((error) {
                //           SmartDialog.showToast(
                //             'There was an error automatically restarting your device.',
                //           );
                //         });
                //         break;
                //       case 'ota':
                //         fetchOtaUpdate();
                //         break;
                //       case 'dvr':
                //         fetchDvrStatus();
                //         break;
                //       case 'channels':
                //         EasyDebounce.debounce(
                //           'load-channels',
                //           const Duration(seconds: 1),
                //           loadChannels,
                //         );
                //         break;
                //       default:
                //     }
                //   }
              }
            });
          }).catchError((dynamic error, dynamic st) {
            if (st is StackTrace) {
              GetIt.I.get<Logger>().severe(
                    'Failed to connect to MQTT server.',
                    error.toString(),
                    st,
                  );
            } else {
              GetIt.I.get<Logger>().severe(
                    error.toString(),
                    st,
                  );
            }

            client.disconnect();
          });
        },
      );
    });
  }

  Future<void> sendDeviceStatus(UserData user) async {
    final ipAddressResponse = await SentryHttpClient().get(
      Uri.parse(
        'https://api64.ipify.org',
      ),
    );
    final interfaces = await NetworkInterface.list();
    final packageInfo = await PackageInfo.fromPlatform();
    if (interfaces.isEmpty) return;

    var deviceType = 'Unknown';
    if (DeviceId.isStb) {
      deviceType = 'STB';
    } else if (!DeviceId.isStb && Platform.isAndroid) {
      deviceType = 'Android';
    } else if (Platform.isIOS) {
      deviceType = 'iOS';
    }
    final wifiStats =
        Platform.isAndroid ? await WifiInfoPlugin.wifiDetails : null;

    if (DeviceId.isStb) {
      final networkStats = await FlutterInstallApkSilently.fetchNetworkStats();

      await GetIt.I<ChopperClient>().getService<AuthService>().sendDeviceStatus(
            publicIp: ipAddressResponse.body,
            privateIp: interfaces.first.addresses.first.address,
            interface: interfaces.first.name,
            version: '${packageInfo.version} Build ${packageInfo.buildNumber}',
            dns0: networkStats['dns1'].toString(),
            dns1: networkStats['dns2'].toString(),
            gateway: networkStats['gateway'].toString(),
            mask: networkStats['mask'].toString(),
            closedCaptions: user.cc ? 'Y' : 'N',
            deviceId: DeviceId.deviceId,
            type: deviceType,
            frequency: wifiStats?.frequency.toString() ?? '',
            linkSpeed: wifiStats?.linkSpeed.toString() ?? '',
            rssi: networkStats['rssi'].toString(),
          );
    } else {
      await GetIt.I<ChopperClient>().getService<AuthService>().sendDeviceStatus(
            publicIp: ipAddressResponse.body,
            privateIp: interfaces.first.addresses.first.address,
            interface: interfaces.first.name,
            version: '${packageInfo.version} Build ${packageInfo.buildNumber}',
            dns0: 'N/A',
            dns1: 'N/A',
            gateway: 'N/A',
            mask: 'N/A',
            closedCaptions: user.cc ? 'Y' : 'N',
            deviceId: DeviceId.deviceId,
            type: deviceType,
            frequency: wifiStats?.frequency.toString() ?? '',
            linkSpeed: wifiStats?.linkSpeed.toString() ?? '',
            rssi: wifiStats?.signalStrength.toString() ?? '',
          );
    }
  }

  MqttServerClient? client;
  StreamSubscription<dynamic>? _otaTimer;
  StreamSubscription<dynamic>? _reconnectMqttTimer;
  StreamSubscription<dynamic>? _mosquittoChecker;
}
