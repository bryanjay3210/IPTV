import 'dart:async';
import 'dart:io';

// import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iptv/app/features/login/bloc/login_bloc.dart';
import 'package:iptv/app/home/widgets/copyright_fragment_widget.dart';
import 'package:iptv/core/api_service/fetch_ota.dart';
import 'package:iptv/core/device_id.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Timer? _registerChecker;

  @override
  void dispose() {
    if (_registerChecker != null) {
      _registerChecker?.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (DeviceId.isStb) {
          return false;
        }

        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover,
                  isAntiAlias: true,
                  colorFilter: ColorFilter.mode(
                    Color(0xFF222222),
                    BlendMode.hardLight,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: StreamBuilder<ConnectivityResult>(
                initialData: ConnectivityResult.none,
                stream: Connectivity().onConnectivityChanged,
                builder: (context, connectivitySnapshot) {
                  if ((connectivitySnapshot.data != null &&
                          connectivitySnapshot.data !=
                              ConnectivityResult.none) ||
                      Platform.isIOS) {
                    return BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is InitialLoginState) {
                          context.read<LoginBloc>().add(InitiateLogin());
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoadingAnimationWidget.prograssiveDots(
                                color: Colors.amber,
                                size: 100,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                '''Initializing...''',
                              ),
                            ],
                          );
                        } else if (state is LoadingLoginState) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoadingAnimationWidget.hexagonDots(
                                color: Colors.amber,
                                size: 100,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                '''Checking for your device registration, please wait...''',
                              ),
                            ],
                          );
                        } else if (state is UnregisteredLoginState) {
                          context.read<LoginBloc>().add(RegisterDevice());

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.amber,
                                size: 100,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                '''Registering your device, please wait...''',
                              ),
                            ],
                          );
                        } else if (state is WaitingLoginState) {
                          Future.delayed(const Duration(seconds: 30), () {
                            if (!mounted) return;
                            context.read<LoginBloc>().add(InitiateLogin());
                          });

                          if (!DeviceId.isStb) {
                            return SafeArea(
                              child: Container(
                                alignment: Alignment.center,
                                constraints:
                                    const BoxConstraints(maxWidth: 1300),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const Text(
                                            'Finish set-up on \nthe Customer Portal',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 30,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 40),
                                          const Text(
                                            'Please visit https://portal.mdu1.com or use the mobile app \nto register using the code below',
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 25),
                                          Text(
                                            state.code,
                                            style: const TextStyle(
                                              fontSize: 40,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          QrImage(
                                            data: state.code,
                                            backgroundColor: Colors.white,
                                            size: 200,
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            'ID: ${DeviceId.deviceId}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white30,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          return Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(maxWidth: 1300),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 100,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Finish set-up on \nthe Customer Portal',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 60,
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                      const Text(
                                        'Please visit https://portal.mdu1.com or use the mobile app \nto register using the code below',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(height: 25),
                                      Text(
                                        state.code,
                                        style: const TextStyle(
                                          fontSize: 80,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const VerticalDivider(color: Colors.white),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      QrImage(
                                        data: state.code,
                                        backgroundColor: Colors.white,
                                        size: 200,
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        'ID: ${DeviceId.deviceId}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white30,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (state is ErrorLoginState) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(height: 12),
                              Text(
                                '''There was a problem encountered while logging in. Automatically retrying in ${DeviceId.retryTimer} seconds.''',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                state.message,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                        } else if (state is SuspendedLoginState) {
                          fetchOta(
                            show: true,
                            user: state.user,
                          );

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.warning_amber,
                                color: Colors.amber,
                                size: 128,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Your account has been temporarily suspended. Please contact customer support.',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Customer ID: ${state.customerId}',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                        }

                        return Text(state.toString());
                      },
                    );
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingAnimationWidget.prograssiveDots(
                        color: Colors.amber,
                        size: 100,
                      ),
                      const SizedBox(height: 12),
                      FutureBuilder(
                        future: Future.delayed(
                          const Duration(seconds: 15),
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return FutureBuilder(
                              future: NetworkInterface.list(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData == false) {
                                    return const Text(
                                      '''Checking for any active network interfaces...''',
                                    );
                                  } else if (snapshot.data?.isEmpty ?? false) {
                                    Future.delayed(const Duration(seconds: 15),
                                        () {
                                      try {
                                        if (!mounted) return;
                                        Connectivity()
                                            .checkConnectivity()
                                            .then((value) {
                                          if (connectivitySnapshot.data ==
                                              ConnectivityResult.none) {
                                            Future.delayed(
                                                const Duration(seconds: 10),
                                                () {
                                              Connectivity()
                                                  .checkConnectivity()
                                                  .then((value) {
                                                if (connectivitySnapshot.data ==
                                                        ConnectivityResult
                                                            .none ||
                                                    connectivitySnapshot.data ==
                                                        null) {
                                                  try {
                                                    const MethodChannel(
                                                      'MDU1Channel',
                                                    )
                                                        .invokeMethod(
                                                          'openSettings',
                                                        )
                                                        .then((value) => null);
                                                  } catch (e) {
                                                    DeviceApps.openApp(
                                                      'com.android.settings',
                                                    );
                                                  }
                                                }
                                              });
                                            });
                                          }
                                        });
                                      } catch (e) {
                                        // no-op
                                      }
                                    });

                                    return const Text(
                                      '''No active network interface found\n\nAutomatically redirecting you to the Settings page, please wait...''',
                                      textAlign: TextAlign.center,
                                    );
                                  } else if (snapshot.data?.isNotEmpty ??
                                      false) {
                                    Future.delayed(const Duration(seconds: 15),
                                        () {
                                      try {
                                        if (!mounted) return;
                                        Connectivity()
                                            .checkConnectivity()
                                            .then((value) {
                                          if (connectivitySnapshot.data ==
                                              ConnectivityResult.none) {
                                            Future.delayed(
                                                const Duration(seconds: 10),
                                                () {
                                              Connectivity()
                                                  .checkConnectivity()
                                                  .then((value) {
                                                if (connectivitySnapshot.data ==
                                                        ConnectivityResult
                                                            .none ||
                                                    connectivitySnapshot.data ==
                                                        null) {
                                                  try {
                                                    const MethodChannel(
                                                      'MDU1Channel',
                                                    )
                                                        .invokeMethod(
                                                          'openSettings',
                                                        )
                                                        .then((value) => null);
                                                  } catch (e) {
                                                    DeviceApps.openApp(
                                                      'com.android.settings',
                                                    );
                                                  }
                                                }
                                              });
                                            });
                                          }
                                        });
                                      } catch (e) {
                                        // no-op
                                      }
                                    });

                                    return Text(
                                      '''Found ${snapshot.data?.length ?? 0} active network interface but detected no connection\n\nAutomatically redirecting you to the Settings page, please wait...''',
                                      textAlign: TextAlign.center,
                                    );
                                  }
                                }

                                return const Text(
                                  '''Checking for any active network interfaces...''',
                                );
                              },
                            );
                          }
                          return const Text(
                            '''Waiting for network to connect...''',
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            const Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: CopyrightFragmentWidget(
                loadMqtt: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
