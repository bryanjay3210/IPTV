import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:iptv/app/features/live_tv/blocs/epg/epg_cubit.dart';
import 'package:iptv/app/features/live_tv/blocs/epg/new_epg_page.dart';
import 'package:iptv/app/features/live_tv/blocs/mini_menu/mini_menu_bloc.dart';
import 'package:iptv/app/features/live_tv/blocs/video_control_cubit.dart';
import 'package:iptv/app/home/bloc/channel_bloc.dart';
import 'package:iptv/app/stop_alert_dialog.dart';
import 'package:iptv/core/api_service/auth_service.dart';
import 'package:iptv/core/control_constants.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/models/program.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:timer_builder/timer_builder.dart';

enum PopupItemType { captions, video, audio }

enum RecordingStatus { initial, disabled, inProgress, ready }

class ProgramGuideVlc extends StatefulWidget {
  const ProgramGuideVlc({
    super.key,
    required this.vlcController,
    required this.onChannelMenuSelected,
  });

  final VlcPlayerController vlcController;
  final Function() onChannelMenuSelected;

  @override
  State<ProgramGuideVlc> createState() => _ProgramGuideVlcState();
}

class _ProgramGuideVlcState extends State<ProgramGuideVlc> {
  final myWidgetState = GlobalKey<StopAlertDialogState>();
  FocusNode focusNode = FocusNode(skipTraversal: true);
  bool isAlertDialogShowing = false;
  bool isStopSelected = false;
  List<FocusNode> nodeList = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  PopupItemType? popupItemType;
  ScrollController scrollController = ScrollController();
  bool shouldListen = false;
  bool isInfoSheetOpen = false;

  Timer? _timer;

  void _handleUserInteraction() {
    if (_timer != null) {
      _timer?.cancel();
    }

    _timer = Timer(const Duration(seconds: 7), () {
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    context.read<ChannelBloc>().state.maybeMap(
          loaded: (a) {
            final currentChannel = a.filteredChannels[a.channelSelected];
            context.read<MiniMenuBloc>().add(
                  FetchMiniMenuData(
                    currentChannel,
                    currentChannel.epgChannelId,
                    context,
                    isFavoriteState: currentChannel.isFavorite,
                  ),
                );
          },
          orElse: () => null,
        );

    initVideoControlCubit();

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(nodeList[0]);
    });

    _handleUserInteraction();
  }

  Future<void> initVideoControlCubit() async {
    final videoTracks = await widget.vlcController.getVideoTracks();
    final audioTracks = await widget.vlcController.getAudioTracks();
    final captionTracks = {
      -1: 'Disable',
      ...await widget.vlcController.getSpuTracks()
    };

    var videoTrack = 0;

    try {
      videoTrack = await widget.vlcController.getVideoTrack() ?? 0;
    } catch (e) {
      videoTrack = videoTracks.entries.first.key;
    }

    final audioTrack = await widget.vlcController.getAudioTrack();
    final captionTrack = await widget.vlcController.getSpuTrack();

    final videoTrackSelection = videoTracks.keys
        .toList()
        .indexWhere((element) => element == videoTrack);
    final audioTrackSelection = audioTracks.keys
        .toList()
        .indexWhere((element) => element == audioTrack);
    final captionTrackSelection = captionTracks.keys
        .toList()
        .indexWhere((element) => element == captionTrack);

    if (!mounted) return;
    context.read<VideoControlCubit>().initValues(
          captionTrackSelection,
          videoTrackSelection,
          audioTrackSelection,
          captionTracks.length,
          videoTracks.length,
          audioTracks.length,
        );
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(nodeList[0]);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _handleUserInteraction,
      onPanDown: (_) => _handleUserInteraction(),
      child: RawKeyboardListener(
        focusNode: focusNode,
        onKey: (event) async {
          _handleUserInteraction();

          if (event is! RawKeyDownEvent) return;
          if (isAlertDialogShowing) {
            switch (event.logicalKey.keyLabel) {
              case keyLeft:
                myWidgetState.currentState?.changeStopSelected(true);
                break;
              case keyRight:
                myWidgetState.currentState?.changeStopSelected(false);
                break;
              case keyCenter:
              case keyEnter:
                myWidgetState.currentState?.sendResponse();
                break;
              default:
            }

            return;
          }

          if (event is RawKeyDownEvent && isInfoSheetOpen) {
            focusNode.requestFocus();

            if (event.logicalKey.keyLabel == keyCenter) {
              unawaited(SmartDialog.dismiss());
            }

            return;
          } else if (event is RawKeyDownEvent && shouldListen) {
            switch (event.logicalKey.keyLabel) {
              case keyDown:
                switch (popupItemType!) {
                  case PopupItemType.video:
                    context.read<VideoControlCubit>().updateVideoIdx();
                    break;
                  case PopupItemType.audio:
                    context.read<VideoControlCubit>().updateAudioIdx();
                    break;
                  case PopupItemType.captions:
                    context.read<VideoControlCubit>().updateCaptionIdx();
                    break;
                }
                break;
              case keyUp:
                // if (idx == array.length - 1) return;
                switch (popupItemType!) {
                  case PopupItemType.video:
                    context
                        .read<VideoControlCubit>()
                        .updateVideoIdx(isIncrement: false);
                    break;
                  case PopupItemType.audio:
                    context
                        .read<VideoControlCubit>()
                        .updateAudioIdx(isIncrement: false);
                    break;
                  case PopupItemType.captions:
                    context
                        .read<VideoControlCubit>()
                        .updateCaptionIdx(isIncrement: false);
                    break;
                }
                break;
              case keyCenter:
              case keyEnter:
                final state = context.read<VideoControlCubit>().state;

                switch (popupItemType!) {
                  case PopupItemType.video:
                    final videoTracks =
                        await widget.vlcController.getVideoTracks();

                    await widget.vlcController.setVideoTrack(
                      videoTracks.keys.elementAt(state.videoIdx),
                    );

                    break;
                  case PopupItemType.audio:
                    final audioTracks =
                        await widget.vlcController.getAudioTracks();

                    await widget.vlcController.setAudioTrack(
                      audioTracks.keys.elementAt(state.audioIdx),
                    );
                    break;
                  case PopupItemType.captions:
                    final captionTracks = {
                      -1: 'Disable',
                      ...await widget.vlcController.getSpuTracks()
                    };

                    await widget.vlcController.setSpuTrack(
                      captionTracks.keys.elementAt(state.captionIdx),
                    );

                    unawaited(
                      GetIt.I<ChopperClient>()
                          .getService<AuthService>()
                          .updateCCFlag(
                            closedCaptions: captionTracks.keys
                                        .elementAt(state.captionIdx) ==
                                    -1
                                ? '0'
                                : '1',
                          ),
                    );

                    break;
                }
                await SmartDialog.dismiss();
                break;
            }
          }
        },
        child: BlocBuilder<ChannelBloc, ChannelState>(
          builder: (context, state) {
            return state.maybeMap(
              loaded: (state) {
                final channel = state.filteredChannels[state.channelSelected];

                return Container(
                  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints(
                    maxHeight: 190 > MediaQuery.of(context).size.height * 0.325
                        ? 190
                        : MediaQuery.of(context).size.height * 0.325,
                    minHeight: 190,
                  ),
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 18,
                      right: 18,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child: CachedNetworkImage(
                                      imageUrl: channel.iconUrl,
                                    ),
                                  ),
                                  Text(
                                    channel.channelName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    channel.guideChannelNum,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                flex: 10,
                                child: BlocBuilder<MiniMenuBloc, MiniMenuState>(
                                  builder: (context, state) {
                                    final now = DateTime.now();

                                    Program? program;
                                    Program? nextProgram;

                                    final programIndex =
                                        channel.programs!.indexWhere(
                                      (currentEpg) =>
                                          (now.isAfter(
                                                currentEpg.startEpoch,
                                              ) ||
                                              now.isAtSameMomentAs(
                                                currentEpg.startEpoch,
                                              )) &&
                                          now.isBefore(currentEpg.stopEpoch),
                                    );

                                    if (programIndex != -1) {
                                      program = channel.programs![programIndex];

                                      final nextProgramIndex = programIndex + 1;

                                      if (nextProgramIndex >= 0 &&
                                          nextProgramIndex <
                                              channel.programs!.length) {
                                        nextProgram =
                                            channel.programs![nextProgramIndex];
                                      }
                                    }

                                    if (state is MiniMenuLoading) {
                                      return const CircularProgressIndicator();
                                    }

                                    if (state is MiniMenuLoaded &&
                                        program != null) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          TimerBuilder.periodic(
                                            const Duration(seconds: 30),
                                            builder: (context) {
                                              final timePassed = DateTime.now()
                                                  .difference(
                                                    program!.startEpoch,
                                                  )
                                                  .inMinutes;

                                              final programDuration =
                                                  program.stopEpoch
                                                      .difference(
                                                        program.startEpoch,
                                                      )
                                                      .inMinutes;

                                              return LinearProgressIndicator(
                                                value: timePassed /
                                                    programDuration,
                                                color: Colors.cyan,
                                                backgroundColor: Colors.amber,
                                              );
                                            },
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                DateFormat('h:mm a').format(
                                                  program.startEpoch,
                                                ),
                                              ),
                                              Text(
                                                DateFormat('h:mm a').format(
                                                  program.stopEpoch,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(program.programTitle),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                        ],
                                      );
                                    }

                                    return const Text('No EPG Available.');
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: [
                                  DigitalClock(
                                    is24HourTimeFormat: false,
                                    areaAligment: AlignmentDirectional.center,
                                    areaHeight: 30,
                                    areaWidth: 100,
                                    showSecondsDigit: false,
                                    hourMinuteDigitDecoration:
                                        const BoxDecoration(),
                                    secondDigitDecoration:
                                        const BoxDecoration(),
                                    hourMinuteDigitTextStyle: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white54,
                                    ),
                                    secondDigitTextStyle: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white54,
                                    ),
                                    amPmDigitTextStyle: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white54,
                                    ),
                                    areaDecoration: const BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('MMM d y')
                                        .format(DateTime.now()),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                buildButton(
                                  nodeList[0],
                                  Icons.access_time,
                                  'Guides',
                                  () {
                                    _timer?.cancel();
                                    if (DeviceId.isCommunity) return;
                                    try {
                                      SmartDialog.showLoading();
                                      context.read<ChannelBloc>().add(
                                        ChannelEvent.clean(() {
                                          SmartDialog.dismiss();
                                          context
                                              .read<ChannelBloc>()
                                              .state
                                              .maybeMap(
                                                loaded: (state) {
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute<void>(
                                                      builder: (context) =>
                                                          BlocProvider(
                                                        create: (context) =>
                                                            EpgCubit(
                                                          channelSelected: state
                                                              .channelSelected,
                                                          channels: state
                                                              .filteredChannels,
                                                          genreSelected: state
                                                              .genreSelected,
                                                        ),
                                                        child:
                                                            const NewEpgPage(),
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
                                      SmartDialog.dismiss();
                                    }
                                  },
                                ),
                                buildButton(
                                  nodeList[1],
                                  Icons.info_outline_rounded,
                                  'Info',
                                  () async {
                                    final state =
                                        context.read<MiniMenuBloc>().state;
                                    if (DeviceId.isCommunity) return;
                                    if (state is! MiniMenuLoaded) return;

                                    // final genre = MDUAPIService.genre.firstWhere(
                                    //   (element) =>
                                    //       element['id'] ==
                                    //       (MDUAPIService
                                    //           .channels[locator<CacheService>().getInt(
                                    //         'selectedChannel',
                                    //       )!]['genre_id']),
                                    // );

                                    setState(() {
                                      isInfoSheetOpen = true;
                                      shouldListen = true;
                                    });
                                    await SmartDialog.show(
                                      builder: (_) => Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 32,
                                        ),
                                        padding: const EdgeInsets.all(16),
                                        height: max(
                                          450,
                                          MediaQuery.of(context).size.height *
                                              0.55,
                                        ),
                                        width: max(
                                          600,
                                          MediaQuery.of(context).size.width *
                                              0.6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xff00051B),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                        maxHeight: 60,
                                                        maxWidth: 175,
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            channel.iconUrl,
                                                      ),
                                                    ),
                                                    Text(
                                                      channel.guideChannelNum,
                                                    ),
                                                    // Text(
                                                    //   genre['name'].toString(),
                                                    // ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 24,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Visibility(
                                                    visible: state.data != null,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'Now Playing',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 6,
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .amber,
                                                                  width: 0.5,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  4,
                                                                ),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 8,
                                                                vertical: 2,
                                                              ),
                                                              child: Text(
                                                                '${DateFormat('h:mm a').format(
                                                                  state.data!
                                                                      .startEpoch,
                                                                )} - ${DateFormat('h:mm a').format(
                                                                  state.data!
                                                                      .stopEpoch,
                                                                )}',
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 10,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '${state.data?.programTitle}',
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            if (state
                                                                    .data
                                                                    ?.previousRun
                                                                    .isEmpty ??
                                                                false)
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 4,
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(4),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    4,
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  'NEW',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                        Text(
                                                          state.data!
                                                              .programDesc,
                                                        ),
                                                        Text(
                                                          '${state.data!.stopEpoch.difference(state.data!.startEpoch).inMinutes} mins',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.amber,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Visibility(
                                                    visible:
                                                        state.nextData != null,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'Up Next',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 6,
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .amber,
                                                                  width: 0.5,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  4,
                                                                ),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 8,
                                                                vertical: 2,
                                                              ),
                                                              child: Text(
                                                                '${DateFormat('h:mm a').format(
                                                                  state.nextData
                                                                          ?.startEpoch ??
                                                                      DateTime
                                                                          .now(),
                                                                )} - ${DateFormat('h:mm a').format(
                                                                  state.nextData
                                                                          ?.stopEpoch ??
                                                                      DateTime
                                                                          .now(),
                                                                )}',
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 10,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '${state.nextData?.programTitle}',
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            if (state
                                                                    .nextData
                                                                    ?.previousRun
                                                                    .isEmpty ??
                                                                false)
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 4,
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(4),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    4,
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  'NEW',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                        Text(
                                                          state.nextData
                                                                  ?.programDesc ??
                                                              'No Description',
                                                        ),
                                                        Text(
                                                          '${((state.nextData?.stopEpoch ?? DateTime.now()).difference(state.nextData?.startEpoch ?? DateTime.now()).inMinutes).toStringAsFixed(0)} mins',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.amber,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Align(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.amber,
                                                ),
                                                child: const Text('OK'),
                                                onPressed: () async {
                                                  await SmartDialog.dismiss();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      isInfoSheetOpen = false;
                                      shouldListen = false;
                                    });
                                  },
                                ),
                                BlocBuilder<MiniMenuBloc, MiniMenuState>(
                                  builder: (context, state) {
                                    if (state is! MiniMenuLoaded) {
                                      return Container();
                                    }

                                    return buildButton(
                                      nodeList[2],
                                      !state.isFavorite
                                          ? Icons.favorite_outline
                                          : Icons.favorite,
                                      !state.isFavorite
                                          ? 'Add to Favorites'
                                          : 'Remove from Favorites',
                                      () {
                                        if (DeviceId.isCommunity) return;

                                        if (!state.isFavorite) {
                                          context.read<ChannelBloc>().add(
                                                ChannelEvent.addFavoriteChannel(
                                                  channel.epgChannelId,
                                                  () {
                                                    context
                                                        .read<MiniMenuBloc>()
                                                        .add(
                                                          AddToFavorites(
                                                            channel
                                                                .epgChannelId,
                                                          ),
                                                        );
                                                  },
                                                ),
                                              );
                                        } else {
                                          context.read<ChannelBloc>().add(
                                                ChannelEvent
                                                    .removeFavoriteChannel(
                                                  channel.epgChannelId,
                                                  () {
                                                    context
                                                        .read<MiniMenuBloc>()
                                                        .add(
                                                          RemoveToFavorites(
                                                            channel
                                                                .epgChannelId,
                                                          ),
                                                        );
                                                  },
                                                ),
                                              );
                                        }
                                      },
                                    );
                                  },
                                ),
                                if (channel.dvrEnabled)
                                  BlocBuilder<MiniMenuBloc, MiniMenuState>(
                                    builder: (context, menuState) {
                                      if (menuState is! MiniMenuLoaded) {
                                        return Container();
                                      }

                                      return buildButton(
                                        nodeList[3],
                                        Icons.fiber_manual_record,
                                        buildStringFromRecordingStatus(
                                          status: menuState.isRecording,
                                        ),
                                        () {
                                          final channelIndex =
                                              state.channelSelected;

                                          final now = DateTime.now();

                                          final programIndex = state
                                              .filteredChannels[channelIndex]
                                              .programs!
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

                                          if (channelIndex == -1 ||
                                              programIndex == -1) return;

                                          if (!menuState.isRecording) {
                                            context.read<ChannelBloc>().add(
                                                  ChannelEvent.recordProgram(
                                                    channelIndex,
                                                    programIndex,
                                                    (_) async {
                                                      context
                                                          .read<MiniMenuBloc>()
                                                          .add(
                                                            StartRecording(
                                                              channel
                                                                  .epgChannelId,
                                                            ),
                                                          );
                                                    },
                                                  ),
                                                );

                                            // context
                                            //     .read<MosquittoCubit>()
                                            //     .recordProgram(
                                            //       channel.epgChannelId,
                                            //       currentData.epgShowId,
                                            //       (currentData.startEpoch
                                            //                   .toUtc()
                                            //                   .millisecondsSinceEpoch /
                                            //               1000)
                                            //           .round()
                                            //           .toString(),
                                            //     );
                                          } else {
                                            unawaited(SmartDialog.dismiss());

                                            setState(() {
                                              isAlertDialogShowing = true;
                                            });

                                            SmartDialog.show(
                                              backDismiss: false,
                                              builder: (_) => StopAlertDialog(
                                                key: myWidgetState,
                                                response: (proceed) {
                                                  setState(() {
                                                    isAlertDialogShowing =
                                                        false;
                                                  });

                                                  unawaited(
                                                    SmartDialog.dismiss(),
                                                  );

                                                  context
                                                      .read<ChannelBloc>()
                                                      .add(
                                                        ChannelEvent
                                                            .stopRecordingProgram(
                                                          channelIndex,
                                                          programIndex,
                                                          (p0) {
                                                            context
                                                                .read<
                                                                    MiniMenuBloc>()
                                                                .add(
                                                                  StopRecording(
                                                                    channel
                                                                        .epgChannelId,
                                                                  ),
                                                                );
                                                          },
                                                        ),
                                                      );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                        iconColor:
                                            buildStringFromRecordingStatus(
                                                      status:
                                                          menuState.isRecording,
                                                    ) ==
                                                    'Stop Recording'
                                                ? Colors.red
                                                : null,
                                      );
                                    },
                                  ),
                                buildButton(
                                  nodeList[4],
                                  Icons.menu,
                                  'Channels',
                                  widget.onChannelMenuSelected,
                                ),
                                buildButton(
                                  nodeList[5],
                                  Icons.closed_caption_off_outlined,
                                  'Captions',
                                  () async {
                                    setState(() {
                                      shouldListen = true;
                                      popupItemType = PopupItemType.captions;
                                    });

                                    FocusScope.of(context)
                                        .requestFocus(focusNode);
                                    final list = {
                                      -1: 'Disable',
                                      ...await widget.vlcController
                                          .getSpuTracks()
                                    };

                                    final selectedSpu = await widget
                                        .vlcController
                                        .getSpuTrack();
                                    await SmartDialog.show(
                                      builder: (_) => BlocBuilder<
                                          VideoControlCubit, VideoControlState>(
                                        buildWhen: (previous, current) {
                                          return previous.captionIdx !=
                                              current.captionIdx;
                                        },
                                        builder: (context, state) {
                                          return MiniMenuButtonPopupWidget(
                                            title: 'Captions',
                                            count: list.length,
                                            itemBuilder: (context, index) {
                                              final item =
                                                  list.entries.elementAt(index);

                                              return Theme(
                                                data: ThemeData(
                                                  brightness: Brightness.dark,
                                                  unselectedWidgetColor:
                                                      Colors.grey,
                                                ),
                                                child: Container(
                                                  color:
                                                      state.captionIdx == index
                                                          ? Colors.grey.shade300
                                                          : null,
                                                  child: RadioListTile<dynamic>(
                                                    selected:
                                                        state.captionIdx ==
                                                            index,
                                                    title: Text(
                                                      item.value,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    activeColor: Colors.black,
                                                    value: item.key,
                                                    groupValue: selectedSpu,
                                                    onChanged: (selected) {
                                                      if (selected != null) {
                                                        context
                                                            .read<
                                                                VideoControlCubit>()
                                                            .updateCaptionIdx(
                                                              data: index,
                                                            );

                                                        widget.vlcController
                                                            .setSpuTrack(
                                                          list.keys
                                                              .elementAt(index),
                                                        );

                                                        unawaited(
                                                          GetIt.I<ChopperClient>()
                                                              .getService<
                                                                  AuthService>()
                                                              .updateCCFlag(
                                                                closedCaptions:
                                                                    item.key ==
                                                                            -1
                                                                        ? '0'
                                                                        : '1',
                                                              ),
                                                        );

                                                        SmartDialog.dismiss();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                    setState(() {
                                      shouldListen = false;
                                    });
                                  },
                                ),
                                buildButton(
                                  nodeList[6],
                                  Icons.video_label_rounded,
                                  'Video',
                                  () async {
                                    setState(() {
                                      shouldListen = true;
                                      popupItemType = PopupItemType.video;
                                    });

                                    final list = await widget.vlcController
                                        .getVideoTracks();
                                    var selected = 0;
                                    try {
                                      selected = (await widget.vlcController
                                              .getVideoTrack()) ??
                                          0;
                                    } catch (e) {
                                      selected = list.entries.first.key;
                                    }

                                    FocusScope.of(context)
                                        .requestFocus(focusNode);

                                    await SmartDialog.show(
                                      builder: (_) => BlocBuilder<
                                          VideoControlCubit, VideoControlState>(
                                        buildWhen: (previous, current) {
                                          return previous.videoIdx !=
                                              current.videoIdx;
                                        },
                                        builder: (context, state) {
                                          return MiniMenuButtonPopupWidget(
                                            title: 'Video',
                                            count: list.length,
                                            itemBuilder: (context, index) {
                                              final item =
                                                  list.entries.elementAt(index);

                                              return Container(
                                                color: state.videoIdx == index
                                                    ? Colors.grey.shade300
                                                    : null,
                                                child: Theme(
                                                  data: ThemeData(
                                                    brightness: Brightness.dark,
                                                    unselectedWidgetColor:
                                                        Colors.grey,
                                                  ),
                                                  child: RadioListTile<dynamic>(
                                                    selected:
                                                        state.videoIdx == index,
                                                    title: Text(
                                                      list.length == 1
                                                          ? 'Auto'
                                                          : item.value,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    activeColor: Colors.black,
                                                    value: item.key,
                                                    groupValue: selected,
                                                    onChanged: (selected) {
                                                      if (selected != null) {
                                                        context
                                                            .read<
                                                                VideoControlCubit>()
                                                            .updateVideoIdx(
                                                              data: index,
                                                            );

                                                        widget.vlcController
                                                            .setVideoTrack(
                                                          list.keys.elementAt(
                                                            index,
                                                          ),
                                                        );

                                                        SmartDialog.dismiss();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                    setState(() {
                                      shouldListen = false;
                                    });
                                  },
                                ),
                                buildButton(
                                  nodeList[7],
                                  Icons.headphones,
                                  'Audio',
                                  () async {
                                    setState(() {
                                      shouldListen = true;
                                      popupItemType = PopupItemType.audio;
                                    });
                                    final list = await widget.vlcController
                                        .getAudioTracks();
                                    final selected = await widget.vlcController
                                        .getAudioTrack();

                                    String formatString(
                                      String data,
                                    ) {
                                      final language =
                                          data.split('[').last.split(']').first;
                                      final stereo = data.contains(
                                        'aac',
                                      )
                                          ? 'Stereo'
                                          : '';
                                      return [language, stereo].join(' ');
                                    }

                                    FocusScope.of(context)
                                        .requestFocus(focusNode);

                                    await SmartDialog.show(
                                      builder: (_) => BlocBuilder<
                                          VideoControlCubit, VideoControlState>(
                                        buildWhen: (previous, current) {
                                          return previous.audioIdx !=
                                              current.audioIdx;
                                        },
                                        builder: (context, state) {
                                          return MiniMenuButtonPopupWidget(
                                            title: 'Audio',
                                            itemBuilder: (context, index) {
                                              final item =
                                                  list.entries.elementAt(index);

                                              return Container(
                                                color: state.audioIdx == index
                                                    ? Colors.grey.shade300
                                                    : null,
                                                child: Theme(
                                                  data: ThemeData(
                                                    brightness: Brightness.dark,
                                                    unselectedWidgetColor:
                                                        Colors.grey,
                                                  ),
                                                  child: RadioListTile<dynamic>(
                                                    selected:
                                                        state.audioIdx == index,
                                                    title: Text(
                                                      formatString(
                                                        toBeginningOfSentenceCase(
                                                              item.value,
                                                            ) ??
                                                            item.value,
                                                      ),
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    activeColor: Colors.black,
                                                    value: item.key,
                                                    groupValue: selected,
                                                    onChanged: (selected) {
                                                      if (selected != null) {
                                                        context
                                                            .read<
                                                                VideoControlCubit>()
                                                            .updateAudioIdx(
                                                              data: index,
                                                            );
                                                        widget.vlcController
                                                            .setAudioTrack(
                                                          list.keys
                                                              .elementAt(index),
                                                        );

                                                        SmartDialog.dismiss();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                            count: list.length,
                                          );
                                        },
                                      ),
                                    );

                                    setState(() {
                                      shouldListen = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              orElse: SizedBox.new,
            );
          },
        ),
      ),
    );
  }

  String buildStringFromRecordingStatus({
    required bool status,
  }) {
    if (status) {
      return 'Stop Recording';
    }

    return 'Record';
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
          onPressed: !shouldListen
              ? !isAlertDialogShowing
                  ? onPressed
                  : () {}
              : () {},
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith((states) {
              if ((states.contains(
                        MaterialState.focused,
                      ) ||
                      states.contains(
                        MaterialState.hovered,
                      )) &&
                  !isAlertDialogShowing &&
                  !shouldListen) {
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
              const SizedBox(
                width: 8,
              ),
              Text(title)
            ],
          ),
        ),
      );
}

class MiniMenuButtonPopupWidget extends StatelessWidget {
  const MiniMenuButtonPopupWidget({
    super.key,
    required this.title,
    required this.count,
    required this.itemBuilder,
  });

  final String title;
  final int count;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: itemBuilder,
            itemCount: count,
            padding: DeviceId.isStb
                ? null
                : const EdgeInsets.symmetric(horizontal: 6),
          ),
        ],
      ),
    );
  }
}
