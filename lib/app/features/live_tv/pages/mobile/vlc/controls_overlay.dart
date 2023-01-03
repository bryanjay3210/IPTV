import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iptv/app/features/live_tv/blocs/video_control_cubit.dart';
import 'package:iptv/app/features/live_tv/pages/mobile/epg_search.dart';
import 'package:iptv/app/features/live_tv/pages/mobile/vlc/bloc/vlc_player_status_cubit.dart';
import 'package:iptv/app/features/live_tv/pages/program_guide.dart';
import 'package:iptv/app/view/navigation_service.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

class ControlsOverlay extends StatefulWidget {
  const ControlsOverlay({super.key, required this.controller});

  final VlcPlayerController controller;

  static const double _playButtonIconSize = 20;
  static const double _replayButtonIconSize = 20;
  static const double _seekButtonIconSize = 48;

  static const Duration _seekStepForward = Duration(seconds: 10);
  static const Duration _seekStepBackward = Duration(seconds: -10);

  static const Color _iconColor = Colors.white;

  @override
  State<ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<ControlsOverlay> {
  int playingIndicator = 1;
  bool isBackground = false;
  bool isPlaying = false;
  Map<int, String> vlcSubs = {};
  Map<int, String> vlcAudios = {};
  Map<int, String> vlcVideos = {};
  bool isMuted = false;

  @override
  void initState() {
    context.read<VlcPlayerStatusCubit>().changeStarted(false);
    widget.controller.addListener(
      () {
        if (!mounted) {
          return;
        }
        if (widget.controller.value.playingState == PlayingState.stopped) {
          isPlaying = false;
          playingIndicator = 1;
          isBackground = false;
          if (Theme.of(context).platform == TargetPlatform.iOS) {
            context.read<VlcPlayerStatusCubit>().changeStarted(false);
          } else {
            setState(() {});
          }
          return;
        }
        if (playingIndicator > 55 &&
            !context.read<VlcPlayerStatusCubit>().hasStarted) {
          isPlaying = true;

          if (Theme.of(context).platform == TargetPlatform.iOS) {
            context.read<VlcPlayerStatusCubit>().changeStarted(true);
          } else {
            setState(() {});
          }
        }
        // else if (isPlayingIndicator > 8 &&
        //     context.read<VlcPlayerStatusCubit>().hasStarted) {
        //   isPlaying = true;
        //   isPlayingIndicator = 0;
        // }

        // print('listener $playingIndicator');
        playingIndicator++;
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.controller.removeListener(() {});
    widget.controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.value.playingState == PlayingState.stopped) {
      playingIndicator = 1;
      if (context.read<VlcPlayerStatusCubit>().manuallyStopped) {
        _initialize();
        context.read<VlcPlayerStatusCubit>().manuallyStopped = false;
      }
    }
    if (widget.controller.value.isInitialized) {
      widget.controller.getSpuTracks().then((value) => vlcSubs = value);
      widget.controller.getAudioTracks().then((value) => vlcAudios = value);
      widget.controller.getVideoTracks().then((value) => vlcVideos = value);
    }

    final isPortrait = MediaQuery.of(context).orientation.index == 0;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 50),
      reverseDuration: const Duration(milliseconds: 200),
      child: Builder(
        builder: (ctx) {
          if (widget.controller.value.isEnded ||
              widget.controller.value.hasError) {
            _replay();
            return Container(
              color: Colors.black45,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Something went wrong. Please try again',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    IconButton(
                      onPressed: _replay,
                      color: ControlsOverlay._iconColor,
                      splashRadius: 20,
                      iconSize: ControlsOverlay._replayButtonIconSize,
                      icon: const Icon(Icons.replay),
                    ),
                  ],
                ),
              ),
            );
          }
          if (playingIndicator < 6) {
            return Container(
              color: Colors.black45,
              child: const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
              ),
            );
          }

          switch (widget.controller.value.playingState) {
            case PlayingState.initializing:
              return GestureDetector(
                onTap: _pause,
                child: Container(
                  color: Colors.black45,
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              );
            case PlayingState.initialized:
              return GestureDetector(
                onTap: _pause,
                child: Container(
                  color: Colors.black45,
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              );
            case PlayingState.stopped:
              return Container(
                color: Colors.black45,
                child: const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                ),
              );
            case PlayingState.paused:
              return GestureDetector(
                onTap: () {
                  context.read<VlcPlayerStatusCubit>().refresh();
                  playSubtitle();
                },
                child: Container(
                  color: Colors.black45,
                  child: const Center(
                    child: Icon(
                      Icons.pause,
                      color: ControlsOverlay._iconColor,
                      size: 30,
                    ),
                  ),
                ),
              );

            case PlayingState.buffering:
              return const Center(
                child: FittedBox(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                ),
              );
            case PlayingState.playing:
              final subKey = context.read<VideoControlCubit>().state.captionIdx;
              if (subKey != '0') {
                widget.controller.setSpuTrack(subKey);
              }

              return isPlaying
                  ? AnimatedContainer(
                      duration: const Duration(milliseconds: 1500),
                      child: GestureDetector(
                        onTap: () {
                          // playSubtitle();
                          setState(
                            () {
                              isBackground = !isBackground;
                            },
                          );
                        },
                        child: isBackground
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: isPortrait ? 10 : 15,
                                ),
                                color: Colors.black54,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Card(
                                          color: Colors.redAccent.shade700,
                                          elevation: 2,
                                          child: const Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              'LIVE',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                // locator<NavigatorService>()
                                                //     .navigateTo(
                                                //   '/epg_search',
                                                // );
                                                NavigationService
                                                    .navigatorKey.currentState
                                                    ?.push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const EpgSearchPage(),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(Icons.movie),
                                            ),
                                            IconButton(
                                              splashRadius: 30,
                                              splashColor: Colors.green,
                                              icon: const Icon(
                                                Icons.headphones,
                                              ),
                                              onPressed: () async {
                                                await SmartDialog.show(
                                                  builder: (_) => BlocBuilder<
                                                      VideoControlCubit,
                                                      VideoControlState>(
                                                    buildWhen:
                                                        (previous, current) {
                                                      return previous
                                                              .audioIdx !=
                                                          current.audioIdx;
                                                    },
                                                    builder: (context, state) {
                                                      return MiniMenuButtonPopupWidget(
                                                        title: 'Audio',
                                                        count: vlcAudios.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          String formatString(
                                                            String data,
                                                          ) {
                                                            final language =
                                                                data
                                                                    .split('[')
                                                                    .last
                                                                    .split(']')
                                                                    .first;
                                                            final stereo =
                                                                data.contains(
                                                              'aac',
                                                            )
                                                                    ? 'Stereo'
                                                                    : '';
                                                            return [
                                                              language,
                                                              stereo
                                                            ].join(' ');
                                                          }

                                                          var subId = '';
                                                          var subKey = -1;
                                                          subId = vlcAudios
                                                              .values
                                                              .elementAt(index);
                                                          subKey = vlcAudios
                                                              .keys
                                                              .elementAt(index);
                                                          return ListTile(
                                                            tileColor:
                                                                state.audioIdx ==
                                                                        subKey
                                                                    ? Colors
                                                                        .grey
                                                                        .shade300
                                                                    : null,
                                                            title: Row(
                                                              children: [
                                                                if (state
                                                                        .audioIdx ==
                                                                    subKey)
                                                                  const Icon(
                                                                    Icons
                                                                        .circle,
                                                                    color: Colors
                                                                        .green,
                                                                  )
                                                                else
                                                                  const Icon(
                                                                    Icons
                                                                        .circle_outlined,
                                                                  ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  formatString(
                                                                    subId,
                                                                  ),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            onTap: () async {
                                                              if (subKey !=
                                                                  -1) {
                                                                context
                                                                    .read<
                                                                        VideoControlCubit>()
                                                                    .updateAudioIdx(
                                                                      data:
                                                                          subKey,
                                                                    );
                                                                Future.delayed(
                                                                    const Duration(
                                                                      milliseconds:
                                                                          500,
                                                                    ),
                                                                    () async {
                                                                  await widget
                                                                      .controller
                                                                      .setAudioTrack(
                                                                    subKey,
                                                                  );
                                                                });
                                                              }
                                                              await SmartDialog
                                                                  .dismiss();
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(width: 7),
                                            IconButton(
                                              splashRadius: 30,
                                              splashColor: Colors.green,
                                              icon: const Icon(
                                                Icons.video_label_rounded,
                                              ),
                                              onPressed: () async {
                                                await SmartDialog.show(
                                                  builder: (_) => BlocBuilder<
                                                      VideoControlCubit,
                                                      VideoControlState>(
                                                    buildWhen:
                                                        (previous, current) {
                                                      return previous
                                                              .videoIdx !=
                                                          current.videoIdx;
                                                    },
                                                    builder: (context, state) {
                                                      return MiniMenuButtonPopupWidget(
                                                        title: 'Video',
                                                        count: vlcVideos.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          var subId = '';
                                                          var subKey = -1;
                                                          subId = vlcVideos
                                                              .values
                                                              .elementAt(index);
                                                          subKey = vlcVideos
                                                              .keys
                                                              .elementAt(index);
                                                          return ListTile(
                                                            tileColor:
                                                                state.videoIdx ==
                                                                        subKey
                                                                    ? Colors
                                                                        .grey
                                                                        .shade300
                                                                    : null,
                                                            title: Row(
                                                              children: [
                                                                if (state.videoIdx ==
                                                                        subKey ||
                                                                    vlcVideos
                                                                            .length ==
                                                                        1)
                                                                  const Icon(
                                                                    Icons
                                                                        .circle,
                                                                    color: Colors
                                                                        .green,
                                                                  )
                                                                else
                                                                  const Icon(
                                                                    Icons
                                                                        .circle_outlined,
                                                                  ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  vlcVideos.length ==
                                                                          1
                                                                      ? 'Auto'
                                                                      : subId,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            onTap: () async {
                                                              if (subKey !=
                                                                  -1) {
                                                                context
                                                                    .read<
                                                                        VideoControlCubit>()
                                                                    .updateVideoIdx(
                                                                      data:
                                                                          subKey,
                                                                    );
                                                                Future.delayed(
                                                                    const Duration(
                                                                      milliseconds:
                                                                          500,
                                                                    ),
                                                                    () async {
                                                                  await widget
                                                                      .controller
                                                                      .setVideoTrack(
                                                                    subKey,
                                                                  );
                                                                });
                                                              }
                                                              await SmartDialog
                                                                  .dismiss();
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(width: 7),
                                            IconButton(
                                              splashRadius: 30,
                                              splashColor: Colors.green,
                                              icon: const Icon(
                                                Icons.closed_caption,
                                              ),
                                              onPressed: () async {
                                                await SmartDialog.show(
                                                  builder: (_) => BlocBuilder<
                                                      VideoControlCubit,
                                                      VideoControlState>(
                                                    buildWhen:
                                                        (previous, current) {
                                                      return previous
                                                              .captionIdx !=
                                                          current.captionIdx;
                                                    },
                                                    builder: (context, state) {
                                                      return MiniMenuButtonPopupWidget(
                                                        title: 'Captions',
                                                        count:
                                                            vlcSubs.length + 1,
                                                        itemBuilder:
                                                            (context, index) {
                                                          var subId = '';
                                                          var subKey = -1;
                                                          if (index !=
                                                              vlcSubs.length) {
                                                            subId = vlcSubs
                                                                .values
                                                                .elementAt(
                                                              index,
                                                            );
                                                          }
                                                          if (index !=
                                                              vlcSubs.length) {
                                                            subKey = vlcSubs
                                                                .keys
                                                                .elementAt(
                                                              index,
                                                            );
                                                          }

                                                          if (subId.toLowerCase() ==
                                                                  'closed captions 1' ||
                                                              subId == '') {
                                                            return ListTile(
                                                              tileColor:
                                                                  state.captionIdx ==
                                                                          subKey
                                                                      ? Colors
                                                                          .grey
                                                                          .shade300
                                                                      : Colors
                                                                          .red,
                                                              title: Row(
                                                                children: [
                                                                  if (state.captionIdx ==
                                                                          subKey ||
                                                                      (state.captionIdx ==
                                                                              0 &&
                                                                          index ==
                                                                              vlcSubs.length))
                                                                    const Icon(
                                                                      Icons
                                                                          .circle,
                                                                      color: Colors
                                                                          .green,
                                                                    )
                                                                  else
                                                                    const Icon(
                                                                      Icons
                                                                          .circle_outlined,
                                                                    ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    index ==
                                                                            vlcSubs.length
                                                                        ? 'Disable'
                                                                        : 'English',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              onTap: () async {
                                                                if (subKey !=
                                                                        null ||
                                                                    subKey !=
                                                                        -1) {
                                                                  context
                                                                      .read<
                                                                          VideoControlCubit>()
                                                                      .updateCaptionIdx(
                                                                        data:
                                                                            subKey,
                                                                      );
                                                                  Future.delayed(
                                                                      const Duration(
                                                                        milliseconds:
                                                                            500,
                                                                      ), () async {
                                                                    await widget
                                                                        .controller
                                                                        .setSpuTrack(
                                                                      subKey,
                                                                    );
                                                                    await widget
                                                                        .controller
                                                                        .setSpuDelay(
                                                                      0,
                                                                    );
                                                                  });
                                                                }

                                                                await SmartDialog
                                                                    .dismiss();
                                                              },
                                                            );
                                                          }
                                                          return const SizedBox();
                                                        },
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(),
                                          ],
                                        ),
                                        IconButton(
                                          splashRadius: 30,
                                          splashColor: Colors.green,
                                          icon: Icon(
                                            isMuted
                                                ? Icons.volume_off_outlined
                                                : Icons.volume_up_outlined,
                                          ),
                                          onPressed: () async {
                                            await setVolume();
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                color: Colors.transparent,
                              ),
                      ),
                    )
                  : Container(
                      color: Colors.black45,
                      child: const Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    );

            case PlayingState.ended:
            case PlayingState.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Something went wrong. Please try again',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        IconButton(
                          onPressed: _replay,
                          color: ControlsOverlay._iconColor,
                          iconSize: 30,
                          icon: const Icon(Icons.replay),
                        ),
                        const SizedBox(width: 5),
                        const Text('Tap to Retry')
                      ],
                    ),
                  ],
                ),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget buildButton(
    FocusNode node,
    IconData icon,
    String title,
    Function()? onPressed, {
    Color? iconColor,
  }) =>
      Container(
        margin: const EdgeInsets.only(right: 4),
        child: OutlinedButton(
          focusNode: node,
          onPressed: () {},
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(
                    MaterialState.focused,
                  ) ||
                  states.contains(
                    MaterialState.hovered,
                  )) {
                return const Color(0xff3eb469);
              }

              return Colors.transparent;
            }),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor ?? Colors.white,
              ),
            ],
          ),
        ),
      );

  playSubtitle() async {
    Future.delayed(const Duration(), () async {
      await widget.controller.play();
      // vlcSubs = await widget.controller.getSpuTracks();
      if (vlcSubs.isEmpty) {
        playSubtitle();
        return;
      }
      if (context.read<VideoControlCubit>().state.captionIdx <= 0) {
        final sub = vlcSubs.entries.firstWhere(
          (element) => element.value.contains('1'),
        );

        final playerBox = await Hive.openBox('player');
        await playerBox.put('english_sub', sub.key);

        await widget.controller.setSpuTrack(sub.key);
        await widget.controller.setSpuTrack(sub.key);
        context.read<VideoControlCubit>().updateCaptionIdx(
              data: sub.key,
            );
        await widget.controller.setSpuDelay(0);
        // Future.delayed(const Duration(seconds: 500), () async {
        //   await widget.controller.setSpuDelay(0);

        // });

        context.read<VlcPlayerStatusCubit>().refresh();
        await SmartDialog.showToast(
          'Caption Turned On',
          displayTime: const Duration(seconds: 3),
        );
      } else {
        final playerBox = await Hive.openBox('player');
        await playerBox.put('english_sub', null);

        await widget.controller.setSpuTrack(-1);
        context.read<VideoControlCubit>().updateCaptionIdx(
              data: -1,
            );
        await SmartDialog.showToast(
          'Caption Turned Off',
          displayTime: const Duration(seconds: 3),
        );
      }

      if (widget.controller.value.playingState != PlayingState.playing) {
        playSubtitle();
      } else {
        context.read<VlcPlayerStatusCubit>().refresh();
      }
    });
  }

  _initialize() async {
    isBackground = false;
    // Future.delayed(const Duration(milliseconds: 400), () async {});
    await widget.controller.play();
  }

  Future<void> _replay() async {
    await widget.controller.stop();
    await widget.controller.play();
    context.read<VlcPlayerStatusCubit>().refresh();
  }

  Future<void> _pause() async {
    Future.delayed(const Duration(milliseconds: 200), () async {
      //   Future.delayed(const Duration(milliseconds: 100), () {

      // });
      // await locator<CacheService>().setValue(
      // widget.controller.
      final playerBox = await Hive.openBox('player');
      final track =
          int.parse(playerBox.get('english_sub', defaultValue: -1).toString());
      await widget.controller.setSpuTrack(
        track,
      );

      await widget.controller.setSpuDelay(0);
    });
    // isPlaying = false;
    // await widget.controller.pause();
    // context.read<VlcPlayerStatusCubit>().changeStatus();
  }

  Future<void> setVolume() async {
    final currentVol = await PerfectVolumeControl.getVolume();
    final playerBox = await Hive.openBox('player');
    if (isMuted) {
      final vol = int.parse(
        playerBox.get('vlc_player_volume', defaultValue: 50).toString(),
      );

      await widget.controller.setVolume(
        vol,
      );
      setState(() {
        isMuted = false;
      });
    } else {
      await widget.controller.setVolume(0);
      setState(() {
        isMuted = true;
      });

      await playerBox.put('vlc_player_volume', (currentVol * 100).toInt());
    }
  }
}
