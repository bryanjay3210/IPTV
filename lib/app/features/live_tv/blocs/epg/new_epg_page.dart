import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:intl/intl.dart';
import 'package:iptv/app/features/live_tv/blocs/epg/epg_cubit.dart';
import 'package:iptv/app/features/live_tv/pages/live_tv_page.dart';
import 'package:iptv/app/home/bloc/channel_bloc.dart';
import 'package:iptv/app/stop_alert_dialog.dart';
import 'package:iptv/core/control_constants.dart';
import 'package:iptv/core/device_id.dart';
import 'package:mdu1_player/mdu1_player.dart';

class NewEpgPage extends StatefulWidget {
  const NewEpgPage({
    super.key,
  });

  @override
  State<NewEpgPage> createState() => _NewEpgPageState();
}

class _NewEpgPageState extends State<NewEpgPage> {
  late String streamUrl;
  final node = FocusNode();
  late Mdu1Controller controller;
  late String initialEpgChannelId;

  final ScrollController _scrollControllerChannel = ScrollController();
  final ScrollController _scrollControllerTimeline = ScrollController();
  final ScrollController _scrollControllerVertical = ScrollController();
  final ScrollController _scrollControllerDates = ScrollController();
  final myWidgetState = GlobalKey<StopAlertDialogState>();

  num height = DeviceId.isStb ? 125 : 62.5;
  num timelineHeight = 50;

  final timeline = <DateTime>[];
  bool isAlertDialogShowing = false;
  bool isStopSelected = false;

  @override
  void initState() {
    super.initState();
    node.requestFocus();

    final now = DateTime.now();
    var minute = 0;
    if (now.minute < 30) {
      minute = 0;
    } else if (now.minute >= 30) {
      minute = 30;
    }

    var startTime = DateTime(now.year, now.month, now.day, now.hour, minute);

    final endTime = now.add(const Duration(days: 7));
    const step = Duration(minutes: 30);

    timeline.add(startTime);

    while (startTime.isBefore(endTime)) {
      final timeIncrement = startTime.add(step);
      timeline.add(timeIncrement);
      startTime = timeIncrement;
    }

    final state = context.read<EpgCubit>().state;
    initialEpgChannelId = state.channels[state.currChanSel].epgChannelId;

    final diffFromMn = state
        .channels[state.currChanSel].programs![state.currProgSel].startEpoch
        .difference(timeline.first)
        .inMinutes;

    controller = Mdu1Controller(state.channels[state.currChanSel].streamUrl);

    var jumpPos = (diffFromMn / 30) * 100;

    jumpPos = jumpPos * (100 * .02);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollControllerChannel.position.moveTo(
        ((state.currChanSel * height) - height).toDouble(),
      );
      _scrollControllerVertical.position.moveTo(
        ((state.currChanSel * height) - height).toDouble(),
      );
      _scrollControllerDates.position.moveTo(
        jumpPos,
      );
      _scrollControllerTimeline.position.moveTo(
        jumpPos,
      );
    });

    if (!DeviceId.isStb) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
  }

  @override
  void dispose() {
    if (!DeviceId.isStb) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(node);

    return Scaffold(
      appBar: DeviceId.isStb
          ? null
          : AppBar(
              backgroundColor: Colors.black,
              leading: BackButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const LiveTvPage(),
                    ),
                    (route) => false,
                  );
                },
              ),
              title: const Text('Program Guide'),
            ),
      body: WillPopScope(
        onWillPop: () async {
          if (context.read<EpgCubit>().state.isInfoSheet) {
            context.read<EpgCubit>().disableInfoSheet();
            return false;
          }

          await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const LiveTvPage(),
            ),
            (route) => false,
          );

          return false;
        },
        child: ColoredBox(
          color: Colors.black,
          child: WillPopScope(
            onWillPop: () async {
              if (context.read<EpgCubit>().state.isInfoSheet) {
                context.read<EpgCubit>().disableInfoSheet();
                return false;
              }

              if (context.read<EpgCubit>().state.isPaginationLoading) {
                return false;
              }

              if (context.read<EpgCubit>().state.horizontalPaginationIndex !=
                  0) {
                unawaited(
                  SmartDialog.showLoading(
                    backDismiss: false,
                  ),
                );
                // await locator<DVRApiService>().fetchChannels(
                //   onDone: (_) {
                //     SmartDialog.dismiss();
                //     final channels =
                //         context.read<EpgCubit>().fetchChannelsWithGenreFilter();
                //     context.read<EpgCubit>().updateChannels(channels);
                //     return true;
                //   },
                // );

                return true;
              } else {
                return true;
              }
            },
            child: RawKeyboardListener(
              focusNode: node,
              onKey: (e) async {
                FocusScope.of(context).requestFocus(node);

                if (e.runtimeType == RawKeyDownEvent) {
                  final cubit = context.read<EpgCubit>();
                  final state = context.read<EpgCubit>().state;

                  if (state.isPaginationLoading) return;

                  switch (e.logicalKey.keyLabel) {
                    case keyUp:
                      if (state.isInfoSheet) return;
                      if (state.currChanSel == 0) return;
                      cubit.handleKeyUp(state.channels);
                      unawaited(
                        _scrollControllerChannel.position.moveTo(
                          _scrollControllerChannel.offset - 75,
                        ),
                      );
                      unawaited(
                        _scrollControllerVertical.position.moveTo(
                          _scrollControllerVertical.offset - 75,
                        ),
                      );

                      break;
                    case keyDown:
                      if (state.isInfoSheet) return;
                      if (state.currChanSel == (state.channels.length - 1)) {
                        return;
                      }
                      cubit.handleKeyDown(state.channels);
                      if (state.isInfoSheet) return;
                      unawaited(
                        _scrollControllerChannel.position.moveTo(
                          _scrollControllerChannel.offset + 75,
                        ),
                      );
                      unawaited(
                        _scrollControllerVertical.position.moveTo(
                          _scrollControllerVertical.offset + 75,
                        ),
                      );

                      break;
                    case keyLeft:
                      if (isAlertDialogShowing) {
                        myWidgetState.currentState?.changeStopSelected(true);

                        return;
                      }
                      await cubit.handleKeyLeft(state.channels);

                      break;
                    case keyRight:
                      if (isAlertDialogShowing) {
                        myWidgetState.currentState?.changeStopSelected(false);

                        return;
                      }
                      await cubit.handleKeyRight(state.channels);

                      break;

                    case keyCenter:
                    case keyEnter:
                      if (!state.isInfoSheet) {
                        cubit.enableInfoSheet(state.channels);
                      } else if (isAlertDialogShowing) {
                        myWidgetState.currentState?.sendResponse();
                      } else {
                        switch (cubit.getButtonName()) {
                          case 'live':
                            await playChannel();
                            break;
                          case 'record':
                            await startRecording();

                            break;
                          case 'series':
                            await startRecording(series: true);

                            break;
                          case 'stop':
                            await stopRecording();

                            break;
                          default:
                        }
                      }
                      break;
                    default:
                  }
                }
              },
              child: Stack(
                children: [
                  if (!Platform.isIOS)
                    Offstage(
                      child: Mdu1Player(
                        controller: controller,
                        useAndroidViewSurface: true,
                        enableCaptions: DeviceId.ccEnabled,
                      ),
                    ),
                  BlocConsumer<EpgCubit, EpgState>(
                    listenWhen: (previous, current) {
                      if (_scrollControllerChannel.positions.isNotEmpty) {
                        _scrollControllerChannel.position.moveTo(
                          ((current.currChanSel * height) - height).toDouble(),
                        );
                        _scrollControllerVertical.position.moveTo(
                          ((current.currChanSel * height) - height).toDouble(),
                        );
                        final diffFromMn = current.channels[current.currChanSel]
                            .programs![current.currProgSel].startEpoch
                            .difference(timeline.first)
                            .inMinutes;

                        var jumpPos = (diffFromMn / 30) * 100;

                        jumpPos = jumpPos * (100 * .02);
                        _scrollControllerTimeline.position
                            .moveTo(
                          jumpPos,
                        )
                            .then((value) {
                          //  if (previous.cachedNavigationDates !=
                          //                     current.cachedNavigationDates) {
                          _scrollControllerDates.position.moveTo(
                            // (jumpPos ~/ 200) * 200,
                            _scrollControllerTimeline.position.pixels,
                          );
                          // }
                        });
                      }

                      if (previous.horizontalPaginationIndex !=
                          current.horizontalPaginationIndex) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scrollControllerChannel.position.moveTo(
                            ((current.currChanSel * height) - height)
                                .toDouble(),
                          );
                          _scrollControllerVertical.position.moveTo(
                            ((current.currChanSel * height) - height)
                                .toDouble(),
                          );
                          final diffFromMn = current
                              .channels[current.currChanSel]
                              .programs![current.currProgSel]
                              .startEpoch
                              .difference(timeline.first)
                              .inMinutes;

                          var jumpPos = (diffFromMn / 30) * 100;

                          jumpPos = jumpPos * (100 * .02);
                          _scrollControllerTimeline.position
                              .moveTo(
                            jumpPos,
                          )
                              .then((value) {
                            //  if (previous.cachedNavigationDates !=
                            //                     current.cachedNavigationDates) {
                            _scrollControllerDates.position.moveTo(
                              // (jumpPos ~/ 200) * 200,
                              _scrollControllerTimeline.position.pixels,
                            );
                            // }
                          });
                        });
                      }
                      return true;
                    },
                    listener: (context, state) {},
                    builder: (context, state) {
                      var startIndex = math.max(state.currChanSel - 2, 0);
                      var stopIndex = math.min(
                        state.currChanSel + 2,
                        state.channels.length - 1,
                      );
                      final remainder = stopIndex - startIndex;
                      if (remainder != 5) {
                        if (stopIndex == state.channels.length - 1) {
                          startIndex -= 5 - remainder;
                        } else if (startIndex == 0) {
                          stopIndex += 5 - remainder;
                        }
                      }

                      if (startIndex.isNegative) startIndex = 0;
                      if (stopIndex > state.channels.length - 1) {
                        stopIndex = state.channels.length - 1;
                      }
                      // stopIndex = math.max(stopIndex, state.filteredChannels.length - 1);

                      final now = DateTime.now();
                      final a = !DeviceId.isStb
                          ? state.channels
                          : state.channels
                              .getRange(startIndex, stopIndex + 1)
                              .toList();

                      final currentEpg = state.channels[state.currChanSel]
                          .programs![state.currProgSel];
                      final currentChannel = state.channels[state.currChanSel];
                      final isCurrentlyPlaying =
                          (now.isAfter(currentEpg.startEpoch) ||
                                  now.isAtSameMomentAs(
                                    currentEpg.startEpoch,
                                  )) &&
                              now.isBefore(currentEpg.stopEpoch);

                      return Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.black,
                                  Color(0xff012835),
                                  Color(0xff012835),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: DeviceId.isStb ? 125 : null,
                                color: Colors.black.withOpacity(0.4),
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentEpg.programTitle,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: DeviceId.isStb ? 17.5 : 14,
                                      ),
                                    ),
                                    Text(
                                      'Starts at ${DateFormat('h:mm a').format(
                                        currentEpg.startEpoch,
                                      )}',
                                      style: TextStyle(
                                        fontSize: DeviceId.isStb ? 12 : 10,
                                      ),
                                    ),
                                    Text(
                                      currentEpg.programDesc,
                                      style: TextStyle(
                                        fontSize: DeviceId.isStb ? 14 : 10,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Visibility(
                                          visible: isCurrentlyPlaying,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  state.goLiveSelected
                                                      ? Colors.amber
                                                      : null,
                                            ),
                                            onPressed: playChannel,
                                            child: Text(
                                              'Go Live',
                                              style: TextStyle(
                                                fontSize:
                                                    DeviceId.isStb ? 14 : 11,
                                                color: state.goLiveSelected
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: currentChannel.dvrEnabled &&
                                              !currentEpg.isCurrentlyRecording,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  state.recordSelected
                                                      ? Colors.amber
                                                      : null,
                                            ),
                                            onPressed: startRecording,
                                            child: Text(
                                              'Record',
                                              style: TextStyle(
                                                fontSize:
                                                    DeviceId.isStb ? 14 : 11,
                                                color: state.recordSelected
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: currentChannel.dvrEnabled &&
                                              !currentEpg.isCurrentlyRecording,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  state.seriesSelected
                                                      ? Colors.amber
                                                      : null,
                                            ),
                                            onPressed: () => startRecording(
                                              series: true,
                                            ),
                                            child: Text(
                                              'Record Series',
                                              style: TextStyle(
                                                fontSize:
                                                    DeviceId.isStb ? 14 : 11,
                                                color: state.seriesSelected
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              currentEpg.isCurrentlyRecording,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  state.stopSelected
                                                      ? Colors.amber
                                                      : null,
                                            ),
                                            onPressed: stopRecording,
                                            child: Text(
                                              'Stop Recording',
                                              style: TextStyle(
                                                fontSize:
                                                    DeviceId.isStb ? 14 : 11,
                                                color: state.stopSelected
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: double.infinity,
                                            child: Center(
                                              child: Text(
                                                DateFormat('EE MMM d')
                                                    .format(
                                                      currentEpg.startEpoch,
                                                    )
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              controller:
                                                  _scrollControllerChannel,
                                              shrinkWrap: true,
                                              physics: DeviceId.isStb
                                                  ? const NeverScrollableScrollPhysics()
                                                  : null,
                                              itemExtent: height.toDouble(),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  height: height.toDouble(),
                                                  margin: const EdgeInsets.only(
                                                    right: 2,
                                                    bottom: 2,
                                                    top: 2,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: const Color(
                                                      0xff303030,
                                                    ).withOpacity(0.4),
                                                    border: Border.all(
                                                      width: 0.25,
                                                      color: const Color(
                                                        0xff5d5d5d,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      if (initialEpgChannelId ==
                                                          a[index].epgChannelId)
                                                        Container(
                                                          width: 8,
                                                          color: Colors.amber,
                                                        ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                  8,
                                                                ),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: a[
                                                                          index]
                                                                      .iconUrl,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  DeviceId.isStb
                                                                      ? 6
                                                                      : 0,
                                                            ),
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  a[index]
                                                                      .guideChannelNum,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        DeviceId.isStb
                                                                            ? 16
                                                                            : 12,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  DeviceId.isStb
                                                                      ? 6
                                                                      : 2,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              itemCount: a.length,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          EPGTimeline(
                                            timeline: timeline,
                                            scrollControllerDates:
                                                _scrollControllerDates,
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              physics: DeviceId.isStb
                                                  ? const NeverScrollableScrollPhysics()
                                                  : null,
                                              scrollDirection: Axis.horizontal,
                                              primary: false,
                                              controller:
                                                  _scrollControllerTimeline,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Stack(
                                                      children: [
                                                        NotificationListener(
                                                          onNotification: DeviceId
                                                                  .isStb
                                                              ? null
                                                              : (notification) {
                                                                  if (notification
                                                                      is ScrollEndNotification) {}
                                                                  _scrollControllerChannel
                                                                      .jumpTo(
                                                                    _scrollControllerVertical
                                                                        .position
                                                                        .pixels,
                                                                  );
                                                                  return false;
                                                                },
                                                          child:
                                                              SingleChildScrollView(
                                                            controller:
                                                                _scrollControllerVertical,
                                                            physics: DeviceId
                                                                    .isStb
                                                                ? const NeverScrollableScrollPhysics()
                                                                : null,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children:
                                                                  List.generate(
                                                                a.length,
                                                                (channelIndex) =>
                                                                    Row(
                                                                  children: List
                                                                      .generate(
                                                                    (a[channelIndex].programs ??
                                                                            [])
                                                                        .length,
                                                                    (idx) {
                                                                      final now =
                                                                          DateTime
                                                                              .now();

                                                                      var leftMargin =
                                                                          0.0;

                                                                      final currentEpg =
                                                                          a[channelIndex]
                                                                              .programs![idx];

                                                                      if (idx ==
                                                                          0) {
                                                                        leftMargin = (currentEpg.startEpoch
                                                                                    .difference(
                                                                                      timeline.first,
                                                                                    )
                                                                                    .inMinutes /
                                                                                30) *
                                                                            100 *
                                                                            2;
                                                                      } else {
                                                                        final prev =
                                                                            a[channelIndex].programs![idx -
                                                                                1];

                                                                        if (!prev.stopEpoch.isAtSameMomentAs(
                                                                              currentEpg.startEpoch,
                                                                            ) &&
                                                                            currentEpg.startEpoch.isAfter(
                                                                              prev.stopEpoch,
                                                                            )) {
                                                                          leftMargin = (currentEpg.stopEpoch
                                                                                      .difference(
                                                                                        prev.startEpoch,
                                                                                      )
                                                                                      .inMinutes /
                                                                                  30) *
                                                                              100 *
                                                                              2;
                                                                        }
                                                                      }

                                                                      if (leftMargin
                                                                          .isNegative) {
                                                                        leftMargin =
                                                                            0;
                                                                      }

                                                                      var color = Colors
                                                                          .black
                                                                          .withOpacity(
                                                                        0.25,
                                                                      );

                                                                      final isCurrentlyPlaying = (now.isAfter(
                                                                                currentEpg.startEpoch,
                                                                              ) ||
                                                                              now.isAtSameMomentAs(
                                                                                currentEpg.startEpoch,
                                                                              )) &&
                                                                          now.isBefore(
                                                                            currentEpg.stopEpoch,
                                                                          );
                                                                      // print(
                                                                      //   '$channelIndex ${state.currChanSel} $startIndex $idx ${state.currProgSel}',
                                                                      // );
                                                                      if (DeviceId
                                                                          .isStb) {
                                                                        if (channelIndex == state.currChanSel - startIndex &&
                                                                            idx ==
                                                                                state.currProgSel) {
                                                                          color = Colors
                                                                              .blue
                                                                              .withOpacity(0.6);
                                                                        }
                                                                      } else {
                                                                        if (channelIndex == state.currChanSel &&
                                                                            idx ==
                                                                                state.currProgSel) {
                                                                          color =
                                                                              const Color(
                                                                            0xff3eb469,
                                                                          );
                                                                        }
                                                                      }

                                                                      final durationSeconds = a[
                                                                              channelIndex]
                                                                          .programs![
                                                                              idx]
                                                                          .stopEpoch
                                                                          .difference(
                                                                            a[channelIndex].programs![idx].startEpoch,
                                                                          )
                                                                          .inSeconds;
                                                                      var programWidth =
                                                                          (durationSeconds / 60) /
                                                                              60;
                                                                      if (idx ==
                                                                          0) {
                                                                        final difference = timeline
                                                                            .first
                                                                            .difference(
                                                                              a[channelIndex].programs![idx].startEpoch,
                                                                            )
                                                                            .inMinutes;

                                                                        if (difference >
                                                                            0) {
                                                                          programWidth -=
                                                                              (difference / 30) * 0.5;
                                                                        }
                                                                      }
                                                                      programWidth =
                                                                          math.max(
                                                                        programWidth *
                                                                            100 *
                                                                            4,
                                                                        0,
                                                                      );

                                                                      // print(programWidth);
                                                                      // return Container();

                                                                      return GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          context
                                                                              .read<EpgCubit>()
                                                                              .changeChannelAndProgramSelected(
                                                                                channelIndex,
                                                                                idx,
                                                                              );
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              programWidth,
                                                                          height:
                                                                              height.toDouble(),
                                                                          margin:
                                                                              EdgeInsets.only(
                                                                            left:
                                                                                leftMargin,
                                                                          ),
                                                                          child:
                                                                              Container(
                                                                            margin:
                                                                                const EdgeInsets.all(2),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: color,
                                                                              border: Border.all(
                                                                                color: Colors.amber,
                                                                                width: 0.05,
                                                                              ),
                                                                            ),
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              left: 8,
                                                                              right: 8,
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                RichText(
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  text: TextSpan(
                                                                                    style: TextStyle(
                                                                                      fontSize: DeviceId.isStb ? 12 : 10,
                                                                                      color: color != Colors.black
                                                                                          ? Colors.white
                                                                                          : const Color(
                                                                                              0xffBE9421,
                                                                                            ),
                                                                                    ),
                                                                                    children: [
                                                                                      TextSpan(
                                                                                        text: DateFormat(
                                                                                          'h:mm a',
                                                                                        ).format(
                                                                                          a[channelIndex].programs![idx].startEpoch,
                                                                                        ),
                                                                                      ),
                                                                                      const TextSpan(
                                                                                        text: ' - ',
                                                                                      ),
                                                                                      TextSpan(
                                                                                        text: DateFormat(
                                                                                          'h:mm a',
                                                                                        ).format(
                                                                                          currentEpg.stopEpoch,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                if (isCurrentlyPlaying)
                                                                                  Text(
                                                                                    '${a[channelIndex].programs![idx].stopEpoch.difference(DateTime.now()).inMinutes} MIN LEFT',
                                                                                    style: TextStyle(
                                                                                      fontSize: DeviceId.isStb ? 12 : 10,
                                                                                      color: color != Colors.black
                                                                                          ? Colors.white
                                                                                          : const Color(
                                                                                              0xffBE9421,
                                                                                            ),
                                                                                    ),
                                                                                    maxLines: 1,
                                                                                  ),
                                                                                Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Text(
                                                                                        a[channelIndex].programs![idx].programTitle,
                                                                                        maxLines: DeviceId.isStb ? 4 : 1,
                                                                                        overflow: DeviceId.isStb ? TextOverflow.fade : TextOverflow.ellipsis,
                                                                                        style: TextStyle(
                                                                                          fontSize: DeviceId.isStb ? 16.5 : 12,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          color: color != Colors.black
                                                                                              ? Colors.white
                                                                                              : const Color(
                                                                                                  0xffBE9421,
                                                                                                ),
                                                                                        ),
                                                                                        textAlign: TextAlign.left,
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width: 8,
                                                                                    ),
                                                                                    if (a[channelIndex].programs![idx].isCurrentlyRecording) ...[
                                                                                      Expanded(
                                                                                        flex: programWidth >= 1000 ? 10 : 1,
                                                                                        child: isCurrentlyPlaying
                                                                                            ? const Icon(
                                                                                                Icons.fiber_smart_record,
                                                                                                color: Colors.red,
                                                                                              )
                                                                                            : const Icon(
                                                                                                Icons.timer,
                                                                                                color: Colors.white,
                                                                                              ),
                                                                                      )
                                                                                    ]
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    growable:
                                                                        false,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        IgnorePointer(
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              left: ((DateTime.now()
                                                                                  .difference(
                                                                                    timeline.first,
                                                                                  )
                                                                                  .inMinutes /
                                                                              30) *
                                                                          100)
                                                                      .abs() *
                                                                  2,
                                                            ),
                                                            color: const Color(
                                                              0xffBE9421,
                                                            ),
                                                            width: 5,
                                                            height:
                                                                MediaQuery.of(
                                                              context,
                                                            ).size.height,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (!DeviceId.isStb)
                            Positioned(
                              right: 24,
                              bottom: 24,
                              child: Container(
                                color: Colors.grey.withOpacity(0.5),
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    if (state.horizontalPaginationIndex != 0)
                                      IconButton(
                                        onPressed: () {
                                          context
                                              .read<EpgCubit>()
                                              .handleLeftPagination();
                                        },
                                        icon: const Icon(
                                          CupertinoIcons.left_chevron,
                                        ),
                                      ),
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<EpgCubit>()
                                            .handleRightPagination();
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.right_chevron,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
      ),
    );
  }

  Future<void> playChannel() async {
    await context.read<ChannelBloc>().state.maybeMap(
      loaded: (a) async {
        final state = context.read<EpgCubit>().state;

        context
            .read<ChannelBloc>()
            .add(ChannelEvent.changeChannel(state.currChanSel));

        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const LiveTvPage(),
          ),
          (route) => false,
        );
      },
      orElse: () {
        return null;
      },
    );
  }

  Future<void> startRecording({
    bool series = false,
  }) async {
    final state = context.read<EpgCubit>().state;

    if (!series) {
      context.read<ChannelBloc>().add(
            ChannelEvent.recordProgram(
              state.currChanSel,
              state.currProgSel,
              (channels) async {
                await context.read<ChannelBloc>().state.maybeMap(
                      loaded: (channelState) async {
                        context.read<EpgCubit>().handleStartRecording(
                              channelState.filteredChannels,
                            );
                      },
                      orElse: () => null,
                    );
              },
            ),
          );
    } else {
      context.read<ChannelBloc>().add(
            ChannelEvent.recordSeries(
              state.currChanSel,
              state.currProgSel,
              (channels) async {
                await context.read<ChannelBloc>().state.maybeMap(
                      loaded: (channelState) async {
                        context.read<EpgCubit>().handleStartRecording(
                              channelState.filteredChannels,
                            );
                      },
                      orElse: () => null,
                    );
              },
            ),
          );
    }
  }

  Future<void> stopRecording() async {
    setState(() {
      isAlertDialogShowing = true;
    });

    await SmartDialog.show(
      backDismiss: false,
      builder: (_) => StopAlertDialog(
        key: myWidgetState,
        response: (proceed) {
          setState(() {
            isAlertDialogShowing = false;
          });

          SmartDialog.dismiss();

          if (!proceed) {
            return;
          }

          final state = context.read<EpgCubit>().state;

          context.read<ChannelBloc>().add(
                ChannelEvent.stopRecordingProgram(
                  state.currChanSel,
                  state.currProgSel,
                  (channels) async {
                    await context.read<ChannelBloc>().state.maybeMap(
                          loaded: (channelState) async {
                            context
                                .read<EpgCubit>()
                                .handleStopRecording(channels);
                          },
                          orElse: () => null,
                        );
                  },
                ),
              );
        },
      ),
    );
    return;
  }
}

class EPGTimeline extends StatelessWidget {
  const EPGTimeline({
    super.key,
    required this.timeline,
    required this.scrollControllerDates,
  });

  final List<DateTime> timeline;
  final ScrollController scrollControllerDates;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: scrollControllerDates,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemExtent: 200,
        itemCount: timeline.length,
        itemBuilder: (context, index) {
          return DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.25,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                top: 8,
                bottom: 8,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  DateFormat('h:mm a').format(timeline[index]),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
