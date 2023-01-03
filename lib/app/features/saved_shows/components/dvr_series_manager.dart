import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_series_details/dvr_series_details_cubit.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_series_manager/dvr_series_manager_cubit.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_percentage_widget.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_series_details.dart';
import 'package:iptv/core/device_id.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

import 'dvr_menu/dvr_menu.dart';

class DVRSeriesManager extends StatefulWidget {
  const DVRSeriesManager({super.key});

  @override
  State<DVRSeriesManager> createState() => _DVRSeriesManagerState();
}

class _DVRSeriesManagerState extends State<DVRSeriesManager> {
  FocusNode focusNode = FocusNode();
  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  late AutoScrollController controller;
  late String seriesId;

  @override
  void initState() {
    context.read<DvrSeriesManagerCubit>().initializeCubit(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
    return WillPopScope(
      onWillPop: () async{
        await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
            builder: (context) => const DVRView(),
          ),
              (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: DeviceId.isStb
            ? null
            : AppBar(
          backgroundColor: Colors.black,
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Series Manager'),
        ),
        backgroundColor: const Color(0xFF212332),
        body: RawKeyboardListener(
          focusNode: focusNode,
          onKey: (e) {
            FocusScope.of(context).requestFocus(focusNode);
            if (e.runtimeType == RawKeyDownEvent) {
              switch (e.logicalKey.keyLabel) {
                case 'Arrow Up':
                  if (!context.read<DvrSeriesManagerCubit>().state.isOnSettings) {
                    context.read<DvrSeriesManagerCubit>().handleKeyUp();
                  } else {
                    context.read<DvrSeriesDetailsCubit>().handleKeyUp();
                  }
                  break;
                case 'Arrow Down':
                  if (!context.read<DvrSeriesManagerCubit>().state.isOnSettings) {
                    context.read<DvrSeriesManagerCubit>().handleKeyDown();
                  } else {
                    context.read<DvrSeriesDetailsCubit>().handleKeyDown();
                  }
                  break;
                case 'Arrow Left':
                  if (!context.read<DvrSeriesManagerCubit>().state.isOnSettings) {
                    context.read<DvrSeriesManagerCubit>().handleKeyLeft();
                  } else {
                    context.read<DvrSeriesDetailsCubit>().handleKeyLeft();
                  }
                  break;
                case 'Arrow Right':
                  if (!context.read<DvrSeriesManagerCubit>().state.isOnSettings) {
                    context.read<DvrSeriesManagerCubit>().handleKeyRight();
                  } else {
                    context.read<DvrSeriesDetailsCubit>().handleKeyRight();
                  }
                  break;
                case 'Select':
                  final state = context.read<DvrSeriesManagerCubit>().state;
                  if (!context.read<DvrSeriesManagerCubit>().state.isOnSettings) {
                    if (context
                        .read<DvrSeriesManagerCubit>()
                        .state
                        .isNavigatingTabDrawer) {
                       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute<void>(builder: (context) => const DVRView(),), (route) => false);
                    } else {
                      if (state.isLoading || state.recordedSeries.isEmpty) return;
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) => DVRSeriesDetail(
                            seriesName:
                                state.recordedSeries[state.currentSelected].name,
                            seriesId: state.recordedSeries[state.currentSelected]
                                .episode['EPGSeriesID']
                                .toString(),
                          ),
                        ),
                      );
                      context
                          .read<DvrSeriesManagerCubit>()
                          .isOnSettingsChangeValue(value: true);
                      context.read<DvrSeriesDetailsCubit>().fetchSettings(
                            context,
                            state.recordedSeries[state.currentSelected]
                                .episode['EPGSeriesID']
                                .toString(),
                          );
                    }
                  } else {
                    context.read<DvrSeriesDetailsCubit>().handleKeySelect(
                          context,
                          state.recordedSeries[state.currentSelected]
                              .episode['EPGSeriesID']
                              .toString(),
                        );
                  }
                  break;
                case 'Go Back':
                  context
                      .read<DvrSeriesManagerCubit>()
                      .isOnSettingsChangeValue(value: false);
                  // Navigator.of(context).pop();
                  break;
                default:
              }
            }
          },
          child: BlocConsumer<DvrSeriesManagerCubit, DvrSeriesManagerState>(
            listener: (context, state) {
              if (itemScrollController.isAttached) {
                itemScrollController.scrollTo(
                  index: state.currentSelected,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  alignment: 0.5,
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          StatefulBuilder(
                            builder: (context, setState) {
                              if(DeviceId.isStb){
                                return const Text(
                                  'Series Manager',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                          const Spacer(),
                          DigitalClock(
                            is24HourTimeFormat: false,
                            areaAligment: AlignmentDirectional.center,
                            areaHeight: 30,
                            areaWidth: 80,
                            showSecondsDigit: false,
                            hourMinuteDigitDecoration: const BoxDecoration(),
                            secondDigitDecoration: const BoxDecoration(),
                            hourMinuteDigitTextStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.white54,
                            ),
                            secondDigitTextStyle: const TextStyle(
                              fontSize: 14,
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (DeviceId.isStb ? 0.80 : 0.65),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 30,
                                  child: Row(
                                    children: const [
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Text(
                                        'No.',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Text(
                                        'Title',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: BlocBuilder<DvrSeriesManagerCubit, DvrSeriesManagerState>(
                                    builder: (context, state) {
                                      if (state.isLoading &&
                                          state.recordedSeries.isEmpty) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (!state.isLoading &&
                                          state.recordedSeries.isEmpty) {
                                        return const Center(
                                          child: Text('No series recording.'),
                                        );
                                      }

                                      return  Scrollbar(
                                        child: ScrollablePositionedList.builder(
                                          itemCount: state.recordedSeries.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () =>
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DVRSeriesDetail(
                                                            seriesName: state
                                                                .recordedSeries[index]
                                                                .name,
                                                            seriesId: state
                                                                .recordedSeries[index]
                                                                .episode['EPGSeriesID']
                                                                .toString(),
                                                          ),
                                                    ),
                                                  ),
                                              child: Container(
                                                height: 35,
                                                width: double.infinity,
                                                color: state.currentSelected ==
                                                    index &&
                                                    !state
                                                        .isNavigatingTabDrawer && DeviceId.isStb
                                                    ? Colors.blue
                                                    : Colors.transparent,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 100,
                                                      child: Center(
                                                        child: Text(
                                                          '${index + 1}',
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: SizedBox(
                                                        child: Text(
                                                          state
                                                              .recordedSeries[
                                                          index]
                                                              .name,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 50,
                                                      child: Icon(
                                                        Icons
                                                            .arrow_drop_down_outlined,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          itemScrollController:
                                          itemScrollController,
                                          itemPositionsListener:
                                          itemPositionsListener,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                              child: Column(
                                children: [
                                  // const SizedBox(
                                  //   height: 50,
                                  // ),
                                  // Container(
                                  //   color: state.isNavigatingTabDrawer &&
                                  //           state.currentMenuSelected == 1
                                  //       ? Colors.blue
                                  //       : null,
                                  //   child: const Padding(
                                  //     padding: EdgeInsets.all(10),
                                  //     child: Text(
                                  //       'Press RIGHT to change series priority',
                                  //       style: TextStyle(fontSize: 15),
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Press SELECT to view series options',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 80,
                                  ),
                                  Visibility(
                                    visible: DeviceId.isStb,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Container(
                                          color: state.isNavigatingTabDrawer
                                              ? Colors.blue
                                              : const Color(0xFF7E9FDB),
                                          height: 30,
                                          width: 200,
                                          child: const Center(
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  const DvrPercentageWidget(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
