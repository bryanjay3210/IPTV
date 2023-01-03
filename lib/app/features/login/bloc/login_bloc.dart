import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:chopper/chopper.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_install_apk_silently/flutter_install_apk_silently.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';
import 'package:iptv/core/api_service/auth_service.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/models/user_data.dart';
import 'package:iptv/core/repositories/authentication_repository.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'login_event.dart';
part 'login_state.dart';

class TimeoutException implements Exception {
  const TimeoutException(this.message);

  final String message;
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(InitialLoginState()) {
    on<InitiateLogin>(
      (event, emit) async {
        try {
          await Future.delayed(const Duration(seconds: 5));

          if (DeviceId.isStb) {
            try {
              if (DateTime.now().isBefore(DeviceId.buildVersionDate)) {
                unawaited(
                  SmartDialog.showToast(
                    '[${DateTime.now().toIso8601String()}] Date is out of sync! Trying to set to ${DeviceId.buildVersionDate}...',
                    displayTime: const Duration(seconds: 10),
                  ),
                );

                await const MethodChannel('MDU1Channel').invokeMethod(
                  'syncTime',
                  {
                    'time': DateFormat('MMddHHmmyy')
                        .format(DeviceId.buildVersionDate),
                  },
                );

                unawaited(
                  SmartDialog.showToast(
                    'Successfully synced time to NTP pool.',
                    displayTime: const Duration(seconds: 10),
                  ),
                );
              }
            } catch (e) {
              unawaited(
                SmartDialog.showToast(
                  '[${DateTime.now().toIso8601String()}] Error setting date and time programmatically. $e',
                  displayTime: const Duration(seconds: 10),
                ),
              );
              log('Error setting date and time programmatically. $e');
            }

            await Future.delayed(const Duration(seconds: 5));

            try {
              await const MethodChannel('MDU1Channel').invokeMethod('setTime');
            } catch (e) {
              // no-op
            }
          }
        } catch (e) {
          // no-op if this doesn't work out
        }

        try {
          _reauthenticateTimer?.pause();
          _unregisteredTimer?.pause();
          emit(LoadingLoginState());

          final registrationCheck = await GetIt.I<ChopperClient>()
              .getService<AuthService>()
              .registrationCheck(id: DeviceId.deviceId)
              .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              throw const TimeoutException(
                '[500] [DNS] Cannot connect to Backend server - DNS Timed out',
              );
            },
          );

          final parsedRegistrationCheck = registrationCheck.body!;

          final bytes = utf8.encode(
            DeviceId().uniqueCode + DeviceId.deviceId,
          ); // data being hashed
          final digest = sha256.convert(bytes);

          if (parsedRegistrationCheck['registered'] != 'Y') {
            await HydratedBlocOverrides.current?.storage.delete('ProfileBloc');
            _authenticationRepository.logOut();
            return emit(UnregisteredLoginState());
          }

          if (parsedRegistrationCheck['cid'] == '000000' ||
              parsedRegistrationCheck['cid'] == '0') {
            await HydratedBlocOverrides.current?.storage.delete('ProfileBloc');
            _authenticationRepository.logOut();
            return emit(
              WaitingLoginState(
                '''${DeviceId().uniqueCode.split('-')[0]}-${DeviceId().uniqueCode.split('-')[1]}''',
              ),
            );
          }

          final isCommunity = parsedRegistrationCheck['community'] == 'Y';
          final dvrVal = await GetIt.I<ChopperClient>()
              .getService<AuthService>()
              .authenticate(
                username: DeviceId.deviceId,
                password: digest.toString(),
              );

          Sentry.configureScope(
            (scope) {
              scope
                ..setUser(
                  SentryUser(
                    id: DeviceId.deviceId,
                    username: dvrVal.body!['customerid'].toString(),
                    email: DeviceId().uniqueCode,
                  ),
                )
                ..setTag(
                  'community',
                  isCommunity.toString(),
                );
            },
          );

          try {
            if (DeviceId.isStb) {
              dynamic tz = parsedRegistrationCheck['tz'];
              if (tz == 'EST') {
                tz = 'America/New_York';
              } else if (tz == 'MST') {
                tz = 'America/Denver';
              } else if (tz == 'PST') {
                tz = 'America/Los_Angeles';
              } else if (tz == 'CST') {
                tz = 'America/Chicago';
              }

              if (tz is String && tz.isNotEmpty) {
                await FlutterInstallApkSilently.updateTimezone(tz)
                    .then((value) {
                  // SmartDialog.showToast(
                  //   'Successfully set timezone to $tz',
                  //   displayTime: const Duration(seconds: 7),
                  // );
                }).catchError((dynamic e) {
                  if (e.toString().contains('error=13')) return;
                  SmartDialog.showToast('Error setting timezone ($tz): $e');
                });
              }

              await FlutterInstallApkSilently.fetchNetworkStats().then((value) {
                Sentry.configureScope(
                  (scope) {
                    scope
                      ..setTag(
                        'dns',
                        '${value['dns1']}|${value['dns2']}',
                      )
                      ..setTag(
                        'gateway',
                        value['gateway'].toString(),
                      )
                      ..setTag(
                        'mask',
                        value['mask'].toString(),
                      );
                  },
                );
              }).catchError((error) {
                // do nothing
              });
            }
          } catch (e) {
            // no-op
          }

          DeviceId.isCommunity = isCommunity;
          try {
            DeviceId.retryTimer =
                int.parse(dvrVal.body!['retryTimer'].toString());
            DeviceId.idleTimer =
                int.parse(dvrVal.body!['idleTimer'].toString());
          } catch (e) {
            // no-op
          }

          final user = UserData(
            customerId: dvrVal.body!['customerid'].toString(),
            accessToken: dvrVal.body!['access_token'].toString(),
            expiresIn: dvrVal.body!['expires_in'].toString(),
            tokenType: dvrVal.body!['token_type'].toString(),
            scope: dvrVal.body!['scope'].toString(),
            timezone: dvrVal.body!['timezone'].toString(),
            cc: dvrVal.body!['cc'].toString() == '1',
            community: isCommunity,
            beta: dvrVal.body!['beta'] == '1',
            urlLink: (dvrVal.body?.containsKey('url_link') ?? false)
                ? dvrVal.body!['url_link'].toString()
                : null,
            latestVersion: (dvrVal.body?.containsKey('latest_version') ?? false)
                ? dvrVal.body!['latest_version'].toString()
                : null,
          );

          if (dvrVal.body!['status']
              .toString()
              .toLowerCase()
              .contains('suspended')) {
            await HydratedBlocOverrides.current?.storage.delete('ProfileBloc');
            _authenticationRepository.logOut();
            return emit(
              SuspendedLoginState(
                dvrVal.body!['customerid'].toString(),
                user,
              ),
            );
          }

          if (_reauthenticateTimer == null) {
            _reauthenticateTimer ??=
                Stream.periodic(const Duration(minutes: 30), (x) => x).listen(
              (_) => add(InitiateLogin()),
              onError: (Object error, StackTrace stacktrace) =>
                  GetIt.I.get<Logger>().severe(
                        'Error refetching token',
                        error,
                        stacktrace,
                      ),
            );
          } else {
            _reauthenticateTimer?.resume();
          }
          DeviceId.ccEnabled = user.cc;
          await _authenticationRepository.logIn(user);
        } catch (e, st) {
          if (e is TimeoutException) {
            emit(
              ErrorLoginState(
                e.message,
              ),
            );
          } else if (e is HandshakeException) {
            try {
              await const MethodChannel('MDU1Channel').invokeMethod('setTime');
            } catch (e) {
              // no-op
            }

            emit(
              ErrorLoginState(
                '[500-01] [Handshake] Device Date & Time is outdated!',
              ),
            );
          } else {
            emit(
              ErrorLoginState(
                '[500-01] [RegCheck] Unexpected error\n${e.toString()}',
              ),
            );
          }

          try {
            GetIt.I.get<Logger>().severe(
                  '[500-01] [RegCheck] Unexpected error',
                  e,
                  st,
                );
          } catch (e) {
            // no-op
          }

          // ignore: inference_failure_on_instance_creation
          await Future<void>.delayed(Duration(seconds: DeviceId.retryTimer));

          add(InitiateLogin());
        }
      },
      // transformer: debounceSequential(const Duration(seconds: 30)),
    );

    on<RegisterDevice>((event, emit) async {
      try {
        final bytes = utf8.encode(
          DeviceId().uniqueCode + DeviceId.deviceId,
        );

        final digest = sha256.convert(bytes);

        final regOauth = await GetIt.I<ChopperClient>()
            .getService<AuthService>()
            .registerOauth(id: DeviceId.deviceId, hash: digest.toString())
            .timeout(
          const Duration(seconds: 15),
          onTimeout: () {
            throw const TimeoutException(
              '[500-01] [DNS] Cannot connect to Backend server - DNS Timed out',
            );
          },
        );

        if (regOauth.body != null &&
            regOauth.body!.containsKey('rc') &&
            !regOauth.body!['rc'].toString().contains('E-000')) {
          return emit(
            ErrorLoginState(
              '[500] [OAuth] ${regOauth.body!['rc']}',
            ),
          );
        }

        final codeRegistration = await GetIt.I<ChopperClient>()
            .getService<AuthService>()
            .sendCode(
              id: DeviceId.deviceId,
              code: DeviceId().uniqueCode,
            )
            .timeout(
          const Duration(seconds: 15),
          onTimeout: () {
            throw const TimeoutException(
              '[500-02] [DNS] Cannot connect to Backend server - DNS Timed out',
            );
          },
        );

        if (codeRegistration.body != null &&
            codeRegistration.body!.containsKey('rc') &&
            !codeRegistration.body!['rc'].toString().contains('E-000')) {
          return emit(
            ErrorLoginState(
              '[500] [4-4] ${regOauth.body!['rc']}',
            ),
          );
        }

        add(InitiateLogin());
      } catch (e, st) {
        if (e is TimeoutException) {
          return emit(
            ErrorLoginState(
              e.message,
            ),
          );
        }

        try {
          GetIt.I.get<Logger>().severe(
                '[500] [Register] Unexpected error',
                e,
                st,
              );
        } catch (e) {
          // no-op
        }

        return emit(
          ErrorLoginState(
            '[500] [Register] ${e.toString()}',
          ),
        );
      }
    });
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<dynamic>? _reauthenticateTimer;
  StreamSubscription<dynamic>? _unregisteredTimer;

  EventTransformer<E> debounceSequential<E>(Duration duration) {
    return (events, mapper) {
      return sequential<E>().call(events.debounceTime(duration), mapper);
    };
  }
}
