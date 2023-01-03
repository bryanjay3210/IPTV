import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:iptv/app/features/live_tv/blocs/epg/epg_cubit.dart';
import 'package:iptv/app/features/live_tv/blocs/epg/new_epg_page.dart';
import 'package:iptv/app/features/live_tv/blocs/mini_menu/mini_menu_bloc.dart';
import 'package:iptv/app/features/live_tv/pages/channel_menu.dart';
import 'package:iptv/app/features/live_tv/pages/channel_select.dart';
import 'package:iptv/app/features/live_tv/pages/material_transparent_route.dart';
import 'package:iptv/app/features/live_tv/pages/program_guide.dart';
import 'package:iptv/app/home/bloc/channel_bloc.dart';
import 'package:iptv/app/home/pages/home_page.dart';
import 'package:iptv/core/control_constants.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/models/channel.dart';
import 'package:iptv/core/mqtt_helper.dart';
import 'package:mdu1_player/mdu1_player.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:screen_state/screen_state.dart';

class LiveTvPageSTB extends StatefulWidget {
  const LiveTvPageSTB({super.key});

  @override
  State<LiveTvPageSTB> createState() => _LiveTvPageState();
}

class _LiveTvPageState extends State<LiveTvPageSTB>
    with WidgetsBindingObserver {
  ScreenStateEvent _screenStateEvent = ScreenStateEvent.SCREEN_ON;
  StreamSubscription<ScreenStateEvent>? _screenStateSubscription;
  late Mdu1Controller controller;
  FocusNode focusNode = FocusNode();
  bool currentlyRetrying = false;
  int countOfRetries = 0;
  bool isLoading = true;
  bool isGuideOpen = false;
  bool isMiniMenuOpen = false;
  bool isChannelSelectOpen = false;
  bool isChannelMenuOpen = false;

  // for handling exceptions

  List<int> keyPresses = [];
  int percentage = 0;
  Timer? _timer;
  String statusCodeError = '';

  String? programId;
  Timer? _tvExceptionTimer;
  Timer? _statsTimer;

  void _handleUserInteraction() {
    if (_timer != null) {
      _timer?.cancel();
    }

    _timer = Timer(const Duration(seconds: 7), () {
      if (mounted) {
        setState(() {
          keyPresses = [];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    context.read<ChannelBloc>().state.maybeMap(
      loaded: (a) {
        controller = Mdu1Controller(
          a.filteredChannels[a.channelSelected].streamUrl,
        );
      },
      orElse: () {
        // no-op
      },
    );

    controller.stream.listen((event) {
      switch (event['event']) {
        case 'bufferingEnd':
          setState(() {
            isLoading = false;
            currentlyRetrying = false;
          });
          break;
        case 'exception':
          countOfRetries += 1;
          setState(() {
            currentlyRetrying = true;
            isLoading = true;
            statusCodeError = event['error'].toString();
          });
          break;
        default:
      }
    });

    try {
      _screenStateSubscription =
          DeviceId.screenListener.screenStateStream?.listen((event) {
        switch (event) {
          case ScreenStateEvent.SCREEN_OFF:
            controller.pause();
            break;
          case ScreenStateEvent.SCREEN_ON:
            controller.play();
            break;
          default:
            break;
        }

        setState(() {
          _screenStateEvent = event;
        });
      });
    } on ScreenStateException {
      // no-op
    }

    _tvExceptionTimer =
        Timer.periodic(Duration(seconds: DeviceId.retryTimer), (timer) {
      if (!mounted) return;
      if (_screenStateEvent == ScreenStateEvent.SCREEN_OFF) return;

      if (currentlyRetrying) {
        print(
          '---------- RETRYING DATA SOURCE ----------',
        );
        context.read<ChannelBloc>().state.maybeMap(
          loaded: (a) {
            controller
                .changeChannel(a.filteredChannels[a.channelSelected].streamUrl);
          },
          orElse: () {
            // no-op
          },
        );
      }
    });

    _statsTimer = Timer.periodic(
      const Duration(minutes: 1),
      (timer) {
        if (!mounted) return;

        final now = DateTime.now();

        context.read<ChannelBloc>().state.maybeMap(
          loaded: (state) {
            final currentChannel =
                state.filteredChannels[state.channelSelected];
            final currentProgram = currentChannel.programs?.firstWhereOrNull(
              (currentEpg) =>
                  (now.isAfter(currentEpg.startEpoch) ||
                      now.isAtSameMomentAs(
                        currentEpg.startEpoch,
                      )) &&
                  now.isBefore(currentEpg.stopEpoch),
            );

            if (currentProgram == null) return;

            if (programId == null || programId != currentProgram.epgShowId) {
              programId = currentProgram.epgShowId;
              final builder = MqttClientPayloadBuilder()
                ..addString(
                  buildAction(
                    {
                      'chan': currentChannel.epgChannelId,
                      'prog': currentProgram.epgShowId,
                      'time': (currentProgram.startEpoch
                                  .toUtc()
                                  .millisecondsSinceEpoch /
                              1000)
                          .round()
                          .toString(),
                    },
                    MqttAction.prog,
                  ),
                );

              try {
                final client = GetIt.I.get<MqttServerClient>();

                if (client.connectionStatus?.state ==
                        MqttConnectionState.connected &&
                    builder.payload != null) {
                  client.publishMessage(
                    'statlog',
                    MqttQos.atLeastOnce,
                    builder.payload!,
                  );
                }
              } catch (e) {
                // no-op if fails
              }
            }
          },
          orElse: () {
            // no-op
          },
        );
      },
    );

    setLiveTvStatus(isOn: true);
  }

  Future<void> setLiveTvStatus({
    required bool isOn,
  }) async {
    final box = await Hive.openBox('tv_cache');
    unawaited(box.put('isOn', isOn));
  }

  void updatePlayer(int index, {int? genreIndex}) {
    setState(() {
      isLoading = true;
      percentage = 0;
      countOfRetries = 0;
      currentlyRetrying = false;
    });

    context.read<ChannelBloc>().state.maybeMap(
      loaded: (a) {
        if (a.channelSelected != index) {
          context.read<ChannelBloc>().add(ChannelEvent.changeChannel(index));
        }

        if (genreIndex != null) {
          context.read<ChannelBloc>().add(ChannelEvent.changeGenre(genreIndex));

          var filteredChannels = <Channel>[];
          final genre = a.genres.elementAt(genreIndex);
          if (genre.contains('All Channels')) {
            filteredChannels = a.channels;
          } else if (genre.contains('Favorites')) {
            filteredChannels =
                a.channels.where((element) => element.isFavorite).toList();
          } else if (genre.contains('DVR')) {
            filteredChannels =
                a.channels.where((element) => element.dvrEnabled).toList();
          } else {
            filteredChannels = a.channels
                .where((element) => element.genreName == genre)
                .toList();
          }

          controller.changeChannel(filteredChannels[index].streamUrl);
        } else {
          controller.changeChannel(a.filteredChannels[index].streamUrl);
        }
      },
      orElse: () {
        // no-op
      },
    );
  }

  void showMiniMenu() {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => ProgramGuide(
        mduController: controller,
        onChannelMenuSelected: () {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialTransparentRoute<void>(
              builder: (BuildContext context) => ChannelMenu(
                updatePlayer: updatePlayer,
              ),
            ),
          );
        },
      ),
      bounce: true,
      animationCurve: Curves.easeInOut,
      enableDrag: false,
      expand: false,
      isDismissible: true,
    ).whenComplete(() => isMiniMenuOpen = false);
  }

  void showChannelSelect() {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ChannelSelect(
        updatePlayer: updatePlayer,
      ),
      bounce: true,
      animationCurve: Curves.easeInOut,
      enableDrag: false,
      expand: false,
      isDismissible: true,
    ).whenComplete(() {
      isChannelSelectOpen = false;
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  void showChannelMenu() {
    FocusScope.of(context).unfocus();

    Navigator.of(context)
        .push(
      MaterialTransparentRoute<void>(
        builder: (BuildContext context) => ChannelMenu(
          updatePlayer: updatePlayer,
        ),
      ),
    )
        .then((value) {
      isChannelMenuOpen = false;
      FocusScope.of(context).requestFocus(focusNode);

      Future.delayed(Duration.zero, () {
        FocusScope.of(context).requestFocus(focusNode);
      });
    });
  }

  Future<void> showGuide() async {
    try {
      unawaited(SmartDialog.showLoading());
      context.read<ChannelBloc>().add(
        ChannelEvent.clean(() {
          SmartDialog.dismiss();
          context.read<ChannelBloc>().state.maybeMap(
                loaded: (state) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => BlocProvider(
                        create: (context) => EpgCubit(
                          channelSelected: state.channelSelected,
                          channels: state.filteredChannels,
                          genreSelected: state.genreSelected,
                        ),
                        child: const NewEpgPage(),
                      ),
                    ),
                    (route) => false,
                  );
                },
                orElse: () => null,
              );
        }),
      );
    } catch (e) {
      unawaited(SmartDialog.dismiss());
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        isLoading = true;
        countOfRetries = 0;
        currentlyRetrying = false;
      });
    }
  }

  @override
  void dispose() {
    _tvExceptionTimer?.cancel();
    _statsTimer?.cancel();
    _screenStateSubscription?.cancel();
    _tvExceptionTimer = null;
    _statsTimer = null;

    controller.dispose();
    setLiveTvStatus(isOn: false);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const HomePage(),
          ),
          (route) => false,
        );

        return false;
      },
      child: RawKeyboardListener(
        focusNode: focusNode,
        onKey: (e) {
          if (e.runtimeType != RawKeyDownEvent) return;

          switch (e.logicalKey.keyLabel) {
            case '0':
            case '1':
            case '2':
            case '3':
            case '4':
            case '5':
            case '6':
            case '7':
            case '8':
            case '9':
              if (keyPresses.length >= 4) {
                setState(() {
                  keyPresses = [];
                });
              }
              if (keyPresses.isEmpty && e.logicalKey.keyLabel == '0') {
                return;
              }
              setState(() {
                keyPresses.add(
                  int.parse(e.logicalKey.keyLabel),
                );
              });
              _handleUserInteraction();
              break;
            case pageUp:
            case keyUp:
              if (isMiniMenuOpen) return;
              context.read<ChannelBloc>().add(
                    const ChannelEvent.traverseChannel(increment: true),
                  );
              break;
            case pageDown:
            case keyDown:
              if (isMiniMenuOpen) return;
              context.read<ChannelBloc>().add(
                    const ChannelEvent.traverseChannel(increment: false),
                  );
              break;
            case keyCenter:
            case keyEnter:
              if (keyPresses.isNotEmpty) {
                final idx = context.read<ChannelBloc>().state.maybeMap(
                      loaded: (a) {
                        return a.filteredChannels.indexWhere(
                          (element) =>
                              element.guideChannelNum == keyPresses.join(),
                        );
                      },
                      orElse: () => 1,
                    );
                if (idx != -1) {
                  updatePlayer(idx);
                  setState(() {
                    keyPresses = [];
                  });
                  return;
                }
              }

              if (isMiniMenuOpen == false &&
                  isChannelSelectOpen == false &&
                  isGuideOpen == false &&
                  isChannelMenuOpen == false &&
                  !isLoading) {
                FocusScope.of(context).unfocus();

                isMiniMenuOpen = true;
                showMiniMenu();
              }
              break;
            case keyLeft:
            case keyRight:
              if (isMiniMenuOpen == false &&
                  isChannelSelectOpen == false &&
                  isGuideOpen == false &&
                  isChannelMenuOpen == false) {
                isChannelSelectOpen = true;
                showChannelSelect();
                FocusScope.of(context).unfocus();
              }
              break;
            case 'Color F3 Blue':
              if (isMiniMenuOpen == false &&
                  isChannelSelectOpen == false &&
                  isGuideOpen == false &&
                  isChannelMenuOpen == false) {
                isGuideOpen = true;
                showGuide();
              }
              break;
            case 'Color F0 Red':
              context.read<ChannelBloc>().state.maybeMap(
                    loaded: (state) {
                      final miniMenuBloc = context.read<MiniMenuBloc>();
                      final currentChannel =
                          state.filteredChannels[state.channelSelected];
                      miniMenuBloc.add(
                        FetchMiniMenuData(
                          currentChannel,
                          currentChannel.epgChannelId,
                          context,
                          isFavoriteState: currentChannel.isFavorite,
                        ),
                      );
                      miniMenuBloc.stream
                          .firstWhere((element) => element is MiniMenuLoaded)
                          .then((menuState) {
                        final channelIndex = state.channelSelected;

                        final now = DateTime.now();

                        final programIndex = state
                            .filteredChannels[channelIndex].programs!
                            .indexWhere(
                          (currentEpg) =>
                              (now.isAfter(
                                    currentEpg.startEpoch,
                                  ) ||
                                  now.isAtSameMomentAs(
                                    currentEpg.startEpoch,
                                  )) &&
                              now.isBefore(
                                currentEpg.stopEpoch,
                              ),
                        );

                        if (channelIndex == -1 || programIndex == -1) {
                          return null;
                        }
                        if (menuState is! MiniMenuLoaded) return true;

                        if (!menuState.isRecording) {
                          context.read<ChannelBloc>().add(
                                ChannelEvent.recordProgram(
                                  channelIndex,
                                  programIndex,
                                  (_) async {
                                    context.read<MiniMenuBloc>().add(
                                          StartRecording(
                                            state
                                                .channels[state.channelSelected]
                                                .epgChannelId,
                                          ),
                                        );
                                  },
                                ),
                              );
                        } else {
                          context.read<ChannelBloc>().add(
                                ChannelEvent.stopRecordingProgram(
                                  channelIndex,
                                  programIndex,
                                  (p0) {
                                    context.read<MiniMenuBloc>().add(
                                          StopRecording(
                                            state
                                                .channels[state.channelSelected]
                                                .epgChannelId,
                                          ),
                                        );
                                  },
                                ),
                              );
                        }
                      });
                    },
                    orElse: () => null,
                  );
              break;
            case 'Color F2 Yellow':
              isChannelMenuOpen = true;
              showChannelMenu();
              break;
            default:
          }
        },
        child: BlocConsumer<ChannelBloc, ChannelState>(
          listenWhen: (previous, current) {
            previous.maybeMap(
              loaded: (previous) {
                current.maybeMap(
                  loaded: (current) {
                    if (previous.filteredChannels[previous.channelSelected]
                            .streamUrl !=
                        current.filteredChannels[current.channelSelected]
                            .streamUrl) {
                      setState(() {
                        isLoading = true;
                        // percentage = 0;
                        // isStartingVideo = true;
                        countOfRetries = 0;
                        // isAtFinalEnd = false;
                        currentlyRetrying = false;
                      });
                      controller.changeChannel(
                        current.filteredChannels[current.channelSelected]
                            .streamUrl,
                      );
                    }
                  },
                  orElse: () {},
                );
              },
              orElse: () {},
            );

            return true;
          },
          listener: (context, state) {
            // no-op
          },
          builder: (context, state) {
            if (!FocusScope.of(context).hasFocus) {
              FocusScope.of(context).requestFocus(focusNode);
            }

            return state.maybeWhen(
              loaded: (
                channels,
                genres,
                spacePurchased,
                spaceUsed,
                spaceRemaining,
                currentChannel,
                currentGenre,
                filteredChannels,
              ) {
                FocusScope.of(context).requestFocus(focusNode);

                return Stack(
                  children: [
                    Mdu1Player(
                      controller: controller,
                      useAndroidViewSurface: true,
                      enableCaptions: DeviceId.ccEnabled,
                    ),
                    if (isLoading)
                      Positioned.fill(
                        child: ColoredBox(
                          color: Colors.black,
                          child: Container(
                            alignment: Alignment.center,
                            width: 125,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: CachedNetworkImage(
                                    imageUrl: filteredChannels[currentChannel]
                                        .iconUrl,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  filteredChannels[currentChannel]
                                      .guideChannelNum,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Text(
                                  filteredChannels[currentChannel].channelName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                CircularPercentIndicator(
                                  radius: 30,
                                  center: const Text(
                                    '0%',
                                  ),
                                  progressColor: Colors.amber,
                                ),
                                if (currentlyRetrying) ...[
                                  const SizedBox(height: 16),
                                  Text(
                                    "We're encountering some issues now, retrying...\n$statusCodeError",
                                    textAlign: TextAlign.center,
                                  ),
                                ]
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (keyPresses.isNotEmpty)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            OutlinedText(
                              keyPresses.join(),
                              textColor: Colors.black,
                              strokeColor: Colors.amber,
                              strokeWidth: 3,
                              style: const TextStyle(
                                fontSize: 100,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (filteredChannels.firstWhereOrNull(
                                  (element) =>
                                      element.guideChannelNum ==
                                      keyPresses.join(),
                                ) !=
                                null)
                              OutlinedText(
                                filteredChannels
                                    .firstWhere(
                                      (element) =>
                                          element.guideChannelNum ==
                                          keyPresses.join(),
                                    )
                                    .channelName,
                                textColor: Colors.white,
                                strokeColor: Colors.black,
                                strokeWidth: 1.5,
                                style: const TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                );
              },
              orElse: () {
                return Column(
                  children: const [
                    Icon(Icons.more_horiz_sharp),
                    SizedBox(height: 12),
                    Text('Refreshing channels...'),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class OutlinedText extends StatelessWidget {
  /// Places a stroke around text to make it appear outlined
  ///
  /// Adapted from https://stackoverflow.com/a/55559435/11846040
  const OutlinedText(
    this.text, {
    super.key,
    this.style = const TextStyle(),
    required this.textColor,
    required this.strokeColor,
    required this.strokeWidth,
  });

  /// Text to display
  final String text;

  /// Original text style (if you weren't outlining)
  ///
  /// Do not specify `color` inside this: use [textColor] instead.
  final TextStyle style;

  /// Text color
  final Color textColor;

  /// Outline stroke color
  final Color strokeColor;

  /// Outline stroke width
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: style.copyWith(
            foreground: Paint()..color = textColor,
          ),
        ),
        Text(
          text,
          style: style.copyWith(
            foreground: Paint()
              ..strokeWidth = strokeWidth
              ..color = strokeColor
              ..style = PaintingStyle.stroke,
          ),
        ),
      ],
    );
  }
}
