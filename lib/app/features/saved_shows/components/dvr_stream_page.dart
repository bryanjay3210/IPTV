import 'dart:async';
import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_stream/dvr_stream_cubit.dart';
import 'package:iptv/app/features/saved_shows/components/helpers.dart';
import 'package:iptv/core/control_constants.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/models/recording.dart';

class DVRStreamPage extends StatefulWidget {
  const DVRStreamPage({
    super.key,
    required this.streamUrl,
    required this.recording,
  });

  final Recording recording;
  final String streamUrl;

  @override
  State<DVRStreamPage> createState() => _DVRStreamPageState();
}

class _DVRStreamPageState extends State<DVRStreamPage> {
  late BetterPlayerController betterPlayerController;
  late BetterPlayerDataSource betterPlayerDataSource;

  late bool isSeries = widget.recording.seriesRecord;

  StreamController<String> controller = StreamController<String>.broadcast();
  late Stream stream = controller.stream;
  BuildContext? blocContext;
  Timer? _timer;
  FocusNode node = FocusNode();
  int speedIndex = 3;

  bool isTimecodeReminderShowing = false;
  Duration? lastTimecode;
  int selectedReminderOption = 0;
  double progressValue = 0;

  List<PlaybackSpeedSelection> speedSelection = [
    PlaybackSpeedSelection(0.25),
    PlaybackSpeedSelection(0.5),
    PlaybackSpeedSelection(0.75),
    PlaybackSpeedSelection(1),
    if (!Platform.isIOS) ...[
      PlaybackSpeedSelection(1.25),
      PlaybackSpeedSelection(1.5),
      PlaybackSpeedSelection(1.75),
      PlaybackSpeedSelection(2),
    ]
  ];

  @override
  void initState() {
    super.initState();

    betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        aspectRatio: WidgetsBinding.instance.window.physicalSize.aspectRatio,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ],
        controlsConfiguration: const BetterPlayerControlsConfiguration(
          enablePlaybackSpeed: false,
          enablePlayPause: false,
          enableSkips: false,
          enableProgressBar: false,
          showControls: false,
        ),
        systemOverlaysAfterFullScreen: [],
        allowedScreenSleep: false,
        autoDetectFullscreenAspectRatio: true,
        autoPlay: true,
        subtitlesConfiguration: const BetterPlayerSubtitlesConfiguration(
          fontSize: 12,
          outlineColor: Colors.black87,
        ),
      ),
    );

    betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.streamUrl,
    );

    betterPlayerController.setupDataSource(betterPlayerDataSource).then((res) {
      Hive.openBox('dvr_cache').then((value) {
        if (value.containsKey(widget.streamUrl)) {
          final data = int.tryParse(
                value.get(widget.streamUrl, defaultValue: 0).toString(),
              ) ??
              0;
          if (data > 0) {
            final duration = Duration(seconds: data);
            setState(() {
              isTimecodeReminderShowing = true;
              lastTimecode = duration;
            });
            betterPlayerController.pause();
          }
        }
      });
    });

    betterPlayerController.addEventsListener((p0) {
      controller.add(p0.betterPlayerEventType.toString());
    });
  }

  void _handleUserInteraction() {
    progressValue = betterPlayerController
        .videoPlayerController!.value.position.inSeconds
        .toDouble();
    if (_timer != null) {
      _timer?.cancel();
    }

    _timer = Timer(const Duration(seconds: 7), () {
      if (mounted && blocContext != null) {
        blocContext!.read<DvrStreamCubit>().hideControls();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(node);
    return BlocProvider(
      create: (context) => DvrStreamCubit(),
      child: BlocBuilder<DvrStreamCubit, DvrStreamState>(
        builder: (context, state) {
          blocContext = context;

          FocusScope.of(context).requestFocus(node);

          return WillPopScope(
            onWillPop: () async {
              if (state.isScrubbing) {
                context.read<DvrStreamCubit>().toggleScrubbing();
                return false;
              }
              if (state.isSelectionPageActive) {
                context.read<DvrStreamCubit>().toggleSelectionPage();
                return false;
              }
              if (state.isControlsActive) {
                context.read<DvrStreamCubit>().hideControls();
                return false;
              }

              context.read<DvrStreamCubit>().hideControls();

              if (betterPlayerController.videoPlayerController != null &&
                  (betterPlayerController.isVideoInitialized() ?? false)) {
                final box = await Hive.openBox('dvr_cache');
                await box.put(
                  widget.streamUrl,
                  betterPlayerController
                      .videoPlayerController!.value.position.inSeconds,
                );
              }

              return true;
            },
            child: RawKeyboardListener(
              onKey: (event) {
                _handleUserInteraction();
                if (event.runtimeType != RawKeyDownEvent) return;
                switch (event.logicalKey.keyLabel) {
                  case playPause:
                    togglePlayPause();
                    break;
                  case rewind:
                    scrubBackwards();
                    break;
                  case fastForward:
                    scrubForward();
                    break;
                  case stop:
                    betterPlayerController.pause();
                    break;
                  default:
                    break;
                }

                if (isTimecodeReminderShowing) {
                  switch (event.logicalKey.keyLabel) {
                    case keyUp:
                      setState(() {
                        selectedReminderOption = 0;
                      });
                      break;
                    case keyDown:
                      setState(() {
                        selectedReminderOption = 1;
                      });
                      break;
                    case keyCenter:
                      if (selectedReminderOption == 0 && lastTimecode != null) {
                        betterPlayerController
                            .seekTo(lastTimecode!)
                            .then((value) {
                          betterPlayerController.play();
                        });
                      } else {
                        betterPlayerController
                            .seekTo(Duration.zero)
                            .then((value) {
                          betterPlayerController.play();
                        });
                      }
                      setState(() {
                        isTimecodeReminderShowing = false;
                      });
                      break;
                  }
                  return;
                } else if (state.isControlsActive) {
                  if (state.isScrubbing) {
                    switch (event.logicalKey.keyLabel) {
                      case keyLeft:
                        scrubBackwards();
                        break;
                      case keyRight:
                        scrubForward();
                        break;
                    }
                    return;
                  }

                  switch (event.logicalKey.keyLabel) {
                    case keyDown:
                      context.read<DvrStreamCubit>().handleKeyDown();
                      break;
                    case keyUp:
                      context.read<DvrStreamCubit>().handleKeyUp();
                      break;
                    case keyLeft:
                      context.read<DvrStreamCubit>().handleKeyLeft();
                      break;
                    case keyRight:
                      context.read<DvrStreamCubit>().handleKeyRight();
                      break;
                    case keyCenter:
                      switch (state.controlColumn) {
                        case 0:
                          switch (state.controlRow) {
                            case 0:
                              goBack();
                              break;
                            case 1:
                              playBackFromBeginning();
                              break;
                            case 2:
                              playNextEpisode();
                              break;
                            default:
                          }
                          break;
                        case 1:
                          switch (state.controlRow) {
                            case 0:
                              togglePlayPause();
                              break;
                            case 1:
                              context.read<DvrStreamCubit>().toggleScrubbing();
                              break;

                            default:
                          }
                          break;
                        case 2:
                          final selectedIndex =
                              getCurrentSelectedIndex(state.controlRow);
                          context.read<DvrStreamCubit>().toggleSelectionPage();
                          context
                              .read<DvrStreamCubit>()
                              .changeSelectionIndex(selectedIndex);
                          break;
                        default:
                      }
                      break;
                  }
                } else if (!state.isControlsActive) {
                  if (state.isSelectionPageActive) {
                    final list = buildListFromSelectionIndex(state.controlRow);

                    switch (event.logicalKey.keyLabel) {
                      case keyUp:
                        if (state.selectionIndex == 0) return;
                        context
                            .read<DvrStreamCubit>()
                            .changeSelectionIndex(state.selectionIndex - 1);
                        break;
                      case keyDown:
                        if (state.selectionIndex == list.length - 1) return;
                        context
                            .read<DvrStreamCubit>()
                            .changeSelectionIndex(state.selectionIndex + 1);
                        break;
                      case keyCenter:
                        selectionPageChange(
                          state.controlRow,
                          state.selectionIndex,
                        );
                        break;
                    }
                    return;
                  }

                  switch (event.logicalKey.keyLabel) {
                    case keyCenter:
                      if (!state.isControlsActive) {
                        context.read<DvrStreamCubit>().showControls();
                        _handleUserInteraction();
                      }
                      break;
                  }
                }
              },
              focusNode: node,
              child: GestureDetector(
                onTap: () {
                  if (state.isControlsActive) {
                    context.read<DvrStreamCubit>().hideControls();
                  } else {
                    context.read<DvrStreamCubit>().showControls();
                  }
                },
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: BetterPlayer(
                          controller: betterPlayerController,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state.isControlsActive &&
                          !state.isSelectionPageActive,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.black.withOpacity(0.3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: goBack,
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 32,
                                    color: state.controlColumn == 0 &&
                                            state.controlRow == 0
                                        ? const Color(0xff3eb469)
                                        : null,
                                  ),
                                ),
                                IconButton(
                                  onPressed: playBackFromBeginning,
                                  icon: Icon(
                                    Icons.restore,
                                    size: 32,
                                    color: state.controlColumn == 0 &&
                                            state.controlRow == 1
                                        ? const Color(0xff3eb469)
                                        : null,
                                  ),
                                ),
                                Visibility(
                                  visible: isSeries,
                                  child: IconButton(
                                    onPressed: playNextEpisode,
                                    icon: Icon(
                                      Icons.queue_play_next,
                                      size: 32,
                                      color: state.controlColumn == 0 &&
                                              state.controlRow == 2
                                          ? const Color(0xff3eb469)
                                          : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            CachedNetworkImage(
                              imageUrl: widget.recording.channelIconURL,
                            ),
                            Text(
                              widget.recording.programTitle,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.recording.programDescription,
                            ),
                            const Spacer(),
                            StreamBuilder(
                              stream: stream,
                              builder: (context, snapshot) {
                                return Row(
                                  children: [
                                    IconButton(
                                      onPressed: togglePlayPause,
                                      icon: Icon(
                                        betterPlayerController.isPlaying() ??
                                                false
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: state.controlColumn == 1 &&
                                                state.controlRow == 0
                                            ? const Color(0xff3eb469)
                                            : null,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                        betterPlayerController
                                                .videoPlayerController
                                                ?.value
                                                .position
                                                .formatDuration() ??
                                            '00:00',
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          if (!DeviceId.isStb) {
                                            return Slider(
                                              activeColor: Colors.amber,
                                              inactiveColor: Colors.white70,
                                              value: progressValue,
                                              onChanged: (value) async {
                                                progressValue = value;
                                                await betterPlayerController
                                                    .seekTo(
                                                  Duration(
                                                    seconds:
                                                        progressValue.toInt(),
                                                  ),
                                                );
                                                setState(() {});
                                              },
                                              max: betterPlayerController
                                                      .videoPlayerController!
                                                      .value
                                                      .duration
                                                      ?.inSeconds
                                                      .toDouble() ??
                                                  0,
                                              label: progressValue.toString(),
                                            );
                                          }
                                          return Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              LinearProgressIndicator(
                                                value: (betterPlayerController
                                                                .videoPlayerController !=
                                                            null &&
                                                        betterPlayerController
                                                                .videoPlayerController!
                                                                .value
                                                                .duration !=
                                                            null)
                                                    ? betterPlayerController
                                                            .videoPlayerController!
                                                            .value
                                                            .position
                                                            .inSeconds /
                                                        betterPlayerController
                                                            .videoPlayerController!
                                                            .value
                                                            .duration!
                                                            .inSeconds
                                                    : null,
                                                // color: Colors.amber,
                                                color: state.controlColumn ==
                                                            1 &&
                                                        state.controlRow == 1
                                                    ? state.isScrubbing
                                                        ? Colors.red
                                                        : const Color(
                                                            0xff3eb469,
                                                          )
                                                    : Colors.amber,
                                                backgroundColor: Colors.white,
                                              ),
                                              Visibility(
                                                visible:
                                                    state.controlColumn == 1 &&
                                                        state.controlRow == 1,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                      left: (betterPlayerController
                                                                      .videoPlayerController !=
                                                                  null &&
                                                              betterPlayerController
                                                                      .videoPlayerController!
                                                                      .value
                                                                      .duration !=
                                                                  null)
                                                          ? constraints
                                                                  .maxWidth *
                                                              (betterPlayerController
                                                                      .videoPlayerController!
                                                                      .value
                                                                      .position
                                                                      .inSeconds /
                                                                  betterPlayerController
                                                                      .videoPlayerController!
                                                                      .value
                                                                      .duration!
                                                                      .inSeconds)
                                                          : 0,
                                                    ),
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          state.isScrubbing
                                                              ? Colors.red
                                                              : const Color(
                                                                  0xff3eb469,
                                                                ),
                                                      radius: 6,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    SizedBox(
                                      width: 60,
                                      child: Text(
                                        betterPlayerController
                                                .videoPlayerController
                                                ?.value
                                                .duration
                                                .formatDuration() ??
                                            '00:00',
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: state.controlColumn == 2 &&
                                            state.controlRow == 0 &&
                                            DeviceId.isStb
                                        ? const Color(0xff3eb469)
                                        : Colors.white,
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    tapControlButton(context, 0);
                                  },
                                  child: const Text(
                                    'Video',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: state.controlColumn == 2 &&
                                            state.controlRow == 1 &&
                                            DeviceId.isStb
                                        ? const Color(0xff3eb469)
                                        : Colors.white,
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    tapControlButton(context, 1);
                                  },
                                  child: const Text(
                                    'Audio',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: state.controlColumn == 2 &&
                                            state.controlRow == 2 &&
                                            DeviceId.isStb
                                        ? const Color(0xff3eb469)
                                        : Colors.white,
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    tapControlButton(context, 2);
                                  },
                                  child: const Text(
                                    'Captions',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: state.controlColumn == 2 &&
                                            state.controlRow == 3 &&
                                            DeviceId.isStb
                                        ? const Color(0xff3eb469)
                                        : Colors.white,
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    tapControlButton(context, 3);
                                  },
                                  child: const Text(
                                    'Playback Speed',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state.isSelectionPageActive,
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 2,
                            child: SizedBox(),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              color: Colors.black.withOpacity(0.3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    parseSelectionToString(state.controlRow),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  buildSelectionListView(state.controlRow),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isTimecodeReminderShowing,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.black.withOpacity(0.3),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Do you want to continue watching at ${lastTimecode.formatDuration()}?',
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: 350,
                              color: selectedReminderOption == 0
                                  ? Colors.amber
                                  : Colors.transparent,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    betterPlayerController
                                        .seekTo(lastTimecode!)
                                        .then((value) {
                                      betterPlayerController.play();
                                    });
                                    isTimecodeReminderShowing = false;
                                    progressValue =
                                        lastTimecode!.inSeconds.toDouble();
                                  });
                                },
                                child: const Text(
                                  'Continue watching',
                                ),
                              ),
                            ),
                            Container(
                              width: 350,
                              color: selectedReminderOption == 1
                                  ? Colors.amber
                                  : Colors.transparent,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  betterPlayerController
                                      .seekTo(Duration.zero)
                                      .then((value) {
                                    betterPlayerController.play();
                                  });
                                  setState(() {
                                    isTimecodeReminderShowing = false;
                                    progressValue = 0;
                                  });
                                },
                                child: const Text(
                                  'Start from beginning',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void tapControlButton(BuildContext context, int controlRow) {
    final selectedIndex = getCurrentSelectedIndex(controlRow);
    context.read<DvrStreamCubit>().toggleSelectionPage();
    context.read<DvrStreamCubit>().changeSelectionIndex(selectedIndex);
    context.read<DvrStreamCubit>().changeControlRowForButtons(
          controlRow,
        );
  }

  void goBack() {
    Navigator.pop(context);
  }

  Future<void> playBackFromBeginning() async {
    await betterPlayerController.seekTo(Duration.zero);
  }

  void playNextEpisode() {
    // TODO(mis-kcn): Play next episode
  }

  Future<void> togglePlayPause() async {
    await (betterPlayerController.isPlaying() ?? false
        ? betterPlayerController.pause()
        : betterPlayerController.play());
  }

  Future<void> scrubBackwards() async {
    if (betterPlayerController.videoPlayerController == null ||
        betterPlayerController.videoPlayerController!.value.absolutePosition ==
            null) return;
    final previousTime =
        betterPlayerController.videoPlayerController!.value.position.inSeconds;
    final newTime = previousTime - 15;

    await betterPlayerController.seekTo(
      Duration(seconds: newTime),
    );
  }

  Future<void> scrubForward() async {
    if (betterPlayerController.videoPlayerController == null ||
        betterPlayerController.videoPlayerController!.value.absolutePosition ==
            null) return;
    final previousTime =
        betterPlayerController.videoPlayerController!.value.position.inSeconds;
    final newTime = previousTime + 15;

    await betterPlayerController.seekTo(
      Duration(seconds: newTime),
    );
  }

  String parseSelectionToString(int index) {
    switch (index) {
      case 0:
        return 'Video';
      case 1:
        return 'Audio';
      case 2:
        return 'Captions';
      case 3:
        return 'Playback Speed';
      default:
        return 'Others';
    }
  }

  List<Object> buildListFromSelectionIndex(int index) {
    switch (index) {
      case 0:
        return betterPlayerController.betterPlayerAsmsTracks;
      case 1:
        return betterPlayerController.betterPlayerAsmsAudioTracks ?? [];
      case 2:
        return betterPlayerController.betterPlayerSubtitlesSourceList;
      case 3:
        return speedSelection;
      default:
        return [];
    }
  }

  int getCurrentSelectedIndex(int index) {
    final currentSelected = getCurrentFromSelectionIndex(index);
    final selectedIndex = buildListFromSelectionIndex(index)
        .indexWhere((element) => element == currentSelected);

    if (selectedIndex == -1) {
      return 0;
    }

    return selectedIndex;
  }

  Object? getCurrentFromSelectionIndex(int index) {
    switch (index) {
      case 0:
        return betterPlayerController.betterPlayerAsmsTrack;
      case 1:
        return betterPlayerController.betterPlayerAsmsAudioTrack;
      case 2:
        return betterPlayerController.betterPlayerSubtitlesSource;
      case 3:
        return speedSelection[speedIndex];
      default:
        throw UnsupportedError('Error!');
    }
  }

  void selectionPageChange(
    int typeIndex,
    int selectionIndex,
  ) {
    final data = buildListFromSelectionIndex(typeIndex)[selectionIndex];
    if (data is BetterPlayerAsmsTrack) {
      betterPlayerController.setTrack(data);
    } else if (data is BetterPlayerAsmsAudioTrack) {
      betterPlayerController.setAudioTrack(data);
    } else if (data is BetterPlayerSubtitlesSource) {
      betterPlayerController.setupSubtitleSource(data);
    } else if (data is PlaybackSpeedSelection) {
      setState(() {
        speedIndex = selectionIndex;
      });
      betterPlayerController.setSpeed(data.speed);
    }

    if (mounted && blocContext != null) {
      blocContext?.read<DvrStreamCubit>().toggleSelectionPage();
    }
  }

  Widget buildSelectionListView(int index) {
    final list = buildListFromSelectionIndex(index);

    return BlocBuilder<DvrStreamCubit, DvrStreamState>(
      builder: (context, state) {
        return ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                selectionPageChange(state.controlRow, index);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 6),
                decoration: state.selectionIndex == index
                    ? BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      )
                    : null,
                child: Text(
                  parseDataFormatTypeToString(context, list[index]),
                  style: TextStyle(
                    fontWeight: state.selectionIndex == index
                        ? FontWeight.bold
                        : FontWeight.w400,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemCount: list.length,
        );
      },
    );
  }
}

class PlaybackSpeedSelection {
  PlaybackSpeedSelection(this.speed);

  final double speed;
}

extension DurationFormat on Duration? {
  String formatDuration() {
    if (this == null) {
      return '00:00';
    }

    final list = <String>[];

    if (this!.inHours > 0) {
      list.add(this!.inHours.toString());
    }

    list
      ..add(this!.inMinutes.remainder(60).toString().padLeft(2, '0'))
      ..add(this!.inSeconds.remainder(60).toString().padLeft(2, '0'));

    return list.join(':');
  }
}
