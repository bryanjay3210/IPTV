import 'dart:io';

// import 'package:app_settings/app_settings.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_install_apk_silently/flutter_install_apk_silently.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hive/hive.dart';
import 'package:iptv/app/features/apps/pages/apps_page.dart';
import 'package:iptv/app/features/live_tv/pages/live_tv_page.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_menu/dvr_menu.dart';
import 'package:iptv/app/home/bloc/channel_bloc.dart';
import 'package:iptv/app/home/bloc/home_cubit.dart';
import 'package:iptv/app/home/widgets/copyright_fragment_widget.dart';
import 'package:iptv/app/view/navigation_service.dart';
import 'package:iptv/core/blocs/profile_bloc/profile_bloc.dart';
import 'package:iptv/core/control_constants.dart';
import 'package:iptv/core/device_id.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        FocusScope.of(context).requestFocus(focusNode);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      },
    );
  }

  late final _menuItems = <MenuItem>[
    MenuItem(
      menuIcon: 'assets/menu/LiveTv.png',
      menuText: DeviceId.isCommunity ? 'Common Area TV' : 'Live TV',
      doFunction: () {
        context.read<ChannelBloc>().state.maybeMap(
              loaded: (channelState) {
                if (channelState.channels.isEmpty) {
                  return SmartDialog.showToast(
                    'You do not have any active plans.',
                  );
                }

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const LiveTvPage(),
                  ),
                  (route) => false,
                );
              },
              orElse: () => null,
            );
      },
    ),
    MenuItem(
      menuIcon: 'assets/menu/DVR.png',
      menuText: 'Saved Shows',
      doFunction: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const DVRView(),
          ),
          (route) => false,
        );
      },
    ),
    if (DeviceId.isStb && (context.read<ProfileBloc>().state is ProfileUser)
        ? (context.read<ProfileBloc>().state as ProfileUser).user.beta
        : false) ...[
      MenuItem(
        menuIcon: 'assets/menu/Setting.png',
        menuText: 'Change Player',
        doFunction: () {
          setState(() {
            DeviceId.isVLC = !DeviceId.isVLC;
          });
          SmartDialog.showToast(
            'Now using ${DeviceId.isVLC ? 'VLC Player' : 'ExoPlayer'}',
          );
        },
      ),
    ],
    if (DeviceId.isStb) ...[
      MenuItem(
        menuIcon: 'assets/menu/Setting.png',
        menuText: 'System Settings',
        doFunction: () {
          try {
            DeviceApps.openApp('com.droidlogic.tv.settings').then((value) {
              if (!value) {
                // AppSettings.openAppSettings();
              }
            });
          } catch (e) {
            // AppSettings.openAppSettings();
          }
        },
      ),
      MenuItem(
        menuIcon: 'assets/menu/App.png',
        menuText: 'Apps',
        doFunction: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const AppsPage(),
            ),
            (route) => false,
          );
        },
      ),
    ]
  ];

  @override
  Widget build(BuildContext context) {
    if (!FocusScope.of(context).hasFocus) {
      FocusScope.of(context).requestFocus(focusNode);
    }

    return WillPopScope(
      onWillPop: () async {
        if (DeviceId.isStb) {
          return false;
        }

        return true;
      },
      child: RawKeyboardListener(
        focusNode: focusNode,
        onKey: (e) {
          if (e.runtimeType == RawKeyDownEvent && DeviceId.isStb) {
            context.read<ChannelBloc>().state.whenOrNull(
              loaded: (
                channels,
                genres,
                spacePurchased,
                spaceUsed,
                spaceRemaining,
                channelSelected,
                genreSelected,
                filteredChannels,
              ) {
                switch (e.logicalKey.keyLabel) {
                  case keyLeft:
                    context.read<HomeCubit>().handleLeft();
                    break;
                  case keyRight:
                    context.read<HomeCubit>().handleRight(
                          isBeta:
                              (context.read<ProfileBloc>().state is ProfileUser)
                                  ? (context.read<ProfileBloc>().state
                                          as ProfileUser)
                                      .user
                                      .beta
                                  : false,
                        );
                    break;
                  case keyCenter:
                  case keyEnter:
                    FocusScope.of(context).unfocus();
                    _menuItems[context.read<HomeCubit>().state.selectedIndex]
                        .doFunction!();
                    FocusScope.of(context).unfocus();
                    break;
                  default:
                }
              },
            );
          }
        },
        child: BlocConsumer<ChannelBloc, ChannelState>(
          listener: (context, state) {
            // no-op
          },
          listenWhen: (previous, current) {
            if (previous.runtimeType.toString().contains('Loading') &&
                current.runtimeType.toString().contains('Loaded')) {
              if (mounted &&
                  ModalRoute.of(context)?.isCurrent == true &&
                  DeviceId.isCommunity) {
                current.maybeMap(
                  loaded: (state) {
                    if (state.channels.isNotEmpty) {
                      NavigationService.navigatorKey.currentState
                          ?.pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const LiveTvPage(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                  orElse: () => null,
                );
              } else if (mounted &&
                  ModalRoute.of(context)?.isCurrent == true &&
                  !DeviceId.isCommunity) {
                Hive.openBox('tv_cache').then((value) {
                  final isOn = value.get('isOn', defaultValue: false);
                  if (isOn == true) {
                    current.maybeMap(
                      loaded: (state) {
                        if (state.channels.isNotEmpty) {
                          NavigationService.navigatorKey.currentState
                              ?.pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LiveTvPage(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      orElse: () => null,
                    );
                  }
                });
              }
            }

            return true;
          },
          builder: (context, state) {
            return Scaffold(
              body: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
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
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8525,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/menu/mdu1-logo.png',
                              height: 60,
                            ),
                            state.when(
                              initial: () {
                                context
                                    .read<ChannelBloc>()
                                    .add(const ChannelEvent.fetch());
                                return const Text('Initializing...');
                              },
                              loading: () {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LoadingAnimationWidget.staggeredDotsWave(
                                      color: Colors.amber,
                                      size: 50,
                                    ),
                                    const SizedBox(height: 12),
                                    const Text('Loading channels...'),
                                    if (!DeviceId.isStb)
                                      const SizedBox(height: 80),
                                  ],
                                );
                              },
                              loaded: (
                                _,
                                __,
                                ___,
                                ____,
                                _____,
                                ______,
                                _______,
                                filteredChannels,
                              ) {
                                FocusScope.of(context).requestFocus(focusNode);
                                if (!DeviceId.isStb) {
                                  return Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ..._menuItems.map(
                                          (e) => GestureDetector(
                                            onTap: e.doFunction,
                                            behavior: HitTestBehavior.opaque,
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  e.menuIcon,
                                                  height: 150,
                                                ),
                                                Text(e.menuText),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                return BlocBuilder<HomeCubit, HomeState>(
                                  builder: (context, state) {
                                    return SizedBox(
                                      height: 300,
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          primary: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap:
                                                  _menuItems[index].doFunction,
                                              child: AnimatedScale(
                                                duration: const Duration(
                                                  milliseconds: 200,
                                                ),
                                                curve: Curves.easeInOut,
                                                scale:
                                                    index == state.selectedIndex
                                                        ? 1.05
                                                        : 0.65,
                                                child: SizedBox(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Image.asset(
                                                          _menuItems[index]
                                                              .menuIcon,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          _menuItems[index]
                                                              .menuText,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: _menuItems.length,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              error: (error) {
                                return Column(
                                  children: [
                                    const Icon(Icons.error),
                                    const SizedBox(height: 12),
                                    Text(
                                      '$error\nAutomatically retrying in ${DeviceId.retryTimer} seconds...',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: !DeviceId.isStb ? 20 : 0,
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (context.select(
                              (ProfileBloc b) => b.state is ProfileUser
                                  ? (b.state as ProfileUser).user.beta
                                  : false,
                            )) ...[
                              Text(
                                'Using ${DeviceId.isVLC ? 'VLC player' : 'ExoPlayer'}',
                                style: const TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                              Text(
                                'Using ${DateTime.now().timeZoneName} ${DateTime.now().timeZoneOffset.inHours} Timezone ',
                                style: const TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                              FutureBuilder(
                                future: Future.wait([
                                  NetworkInfo().getWifiIP(),
                                  FlutterInstallApkSilently.fetchNetworkStats(),
                                  NetworkInterface.list(),
                                ]),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    return Row(
                                      children: [
                                        Text(
                                          'Connected using ${(snapshot.data![2] as List<NetworkInterface>).first.name}',
                                          style: const TextStyle(
                                            color: Colors.white54,
                                          ),
                                        ),
                                        const Text(
                                          ' | ',
                                          style: TextStyle(
                                            color: Colors.white54,
                                          ),
                                        ),
                                        Text(
                                          'IP: ${(snapshot.data![2] as List<NetworkInterface>).first.addresses.first.address}/${((snapshot.data![1] as Map<String, dynamic>)['mask']).toString()}',
                                          style: const TextStyle(
                                            color: Colors.white54,
                                          ),
                                        ),
                                      ],
                                    );
                                  }

                                  return const SizedBox();
                                },
                              ),
                              BlocBuilder<ChannelBloc, ChannelState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    loaded: (
                                      channels,
                                      genres,
                                      spacePurchased,
                                      spaceUsed,
                                      spaceRemaining,
                                      channelSelected,
                                      genreSelected,
                                      filteredChannels,
                                    ) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (channels.isNotEmpty)
                                            Text(
                                              'Currently watching ${filteredChannels[channelSelected].guideChannelNum} ${filteredChannels[channelSelected].channelName}',
                                              style: const TextStyle(
                                                color: Colors.white54,
                                              ),
                                            ),
                                          Text(
                                            '${channels.length} Channels Loaded | ${genres.length} Genres Loaded',
                                            style: const TextStyle(
                                              color: Colors.white54,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    orElse: () {
                                      return const SizedBox();
                                    },
                                  );
                                },
                              ),
                            ],
                            if (!DeviceId.isStb)
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  launchUrlString(
                                    'https://mdu1.com/privacy-policy/',
                                  );
                                },
                                child: const Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            const Text(
                              'Copyright © 2020-2022, MDU1, LLC',
                              style: TextStyle(
                                color: Colors.white54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const CopyrightFragmentWidget(
                    loadMqtt: true,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class MenuItem {
  MenuItem({
    required this.menuIcon,
    required this.menuText,
    this.navigateTo,
    this.doFunction,
  });

  final String menuIcon;
  final String menuText;
  final Widget? navigateTo;
  final void Function()? doFunction;
}
