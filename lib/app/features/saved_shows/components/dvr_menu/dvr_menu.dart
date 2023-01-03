import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:iptv/app/dvr_service.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_menu/dvr_menu_cubit.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_delete_shows.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_menu/tab_pages/record_tab.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_menu/tab_pages/scheduled_tab.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_menu/tab_pages/search_tab.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_menu/tab_pages/series_manager_tab.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_movie.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_search_result.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_series_manager.dart';
import 'package:iptv/app/home/pages/home_page.dart';
import 'package:iptv/core/api_service/dvr_service.dart';
import 'package:iptv/core/device_id.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class DVRView extends StatefulWidget {
  const DVRView({super.key});

  @override
  State<DVRView> createState() => _DVRViewState();
}

class _DVRViewState extends State<DVRView> with SingleTickerProviderStateMixin {
  FocusNode focusNode = FocusNode();
  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  ItemScrollController itemScrollController1 = ItemScrollController();
  ItemPositionsListener itemPositionsListener1 = ItemPositionsListener.create();
  ItemScrollController itemScrollController2 = ItemScrollController();
  ItemPositionsListener itemPositionsListener2 = ItemPositionsListener.create();
  final searchCtrl = TextEditingController();
  late AutoScrollController controller;
  late TabController _tabController;

  late NavigatorState _navigator;

  @override
  void didChangeDependencies() {
    _navigator = Navigator.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    context.read<DvrMenuCubit>().restartNavigation();
    context.read<DvrMenuCubit>().initializeCubit(context);
    super.initState();
    controller = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical,
    );
    _tabController = TabController(length: 4, vsync: this);
    if (!DeviceId.isStb) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await DvrService().fetchChannelAndProgram();
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
    return WillPopScope(
      onWillPop: () async {
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        // ignore: use_build_context_synchronously
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const HomePage(),
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
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const HomePage(),
                      ),
                      (route) => false,
                    );
                  },
                ),
                title: const Text('Saved Shows'),
              ),
        backgroundColor: const Color(0xFF212332),
        body: RawKeyboardListener(
          focusNode: focusNode,
          onKey: (e) {
            FocusScope.of(context).requestFocus(focusNode);
            if (e.runtimeType == RawKeyDownEvent) {
              switch (e.logicalKey.keyLabel) {
                case 'Arrow Up':
                  context.read<DvrMenuCubit>().handleKeyUp();
                  break;
                case 'Arrow Down':
                  context.read<DvrMenuCubit>().handleKeyDown();
                  break;
                case 'Arrow Left':
                  context.read<DvrMenuCubit>().handleKeyLeft();
                  break;
                case 'Arrow Right':
                  context.read<DvrMenuCubit>().handleKeyRight();
                  break;
                case 'Select':
                  final state = context.read<DvrMenuCubit>().state;
                  if (state.currentTabSelected == 0 &&
                      !state.isNavigatingSortDrawer &&
                      !state.isNavigatingTabDrawer) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute<void>(
                        builder: (context) => DVRMovie(recording: state.recordedPrograms[state.currentRecordedSelected], isFinishedRecording: false),
                      ),
                      (route) => false,
                    );
                  }
                  if (state.currentTabSelected == 0 &&
                      state.isNavigatingSortDrawer) {
                    if (state.currentSortSelected == 1) {
                      setState(() {
                        context.read<DvrMenuCubit>().sortListByDate();
                      });
                    }
                    if (state.currentSortSelected == 2) {
                      setState(() {
                        context.read<DvrMenuCubit>().sortListByTime();
                      });
                    }
                  }
                  if (state.currentTabSelected == 1 &&
                      !state.isNavigatingTabDrawer) {
                    if (state.isNavigatingAlertDialog) {
                      if (state.currentAlertBoxSelected == 0) {
                        context
                            .read<DvrMenuCubit>()
                            .deleteScheduledProgram(context: context, index: 0);
                        Navigator.of(context).pop();
                      }
                      if (state.currentAlertBoxSelected == 1) {
                        context.read<DvrMenuCubit>().hideAlertDialog();
                        Navigator.of(context).pop();
                      }
                    }
                    if (!state.isNavigatingAlertDialog) {
                      showAlertDialog(context: context, index: state.currentScheduledSelected);
                    }
                  }
                  if (state.currentTabSelected == 2 && !state.isNavigatingTabDrawer) {
                    if (state.currentManagedSelected == 1) {
                      _navigator.pushAndRemoveUntil(
                        MaterialPageRoute<void>(
                          builder: (context) => const DVRDeleteShows(),
                        ),
                            (route) => false,
                      );
                    }
                    if (state.currentManagedSelected == 2) {
                      _navigator.pushAndRemoveUntil(
                        MaterialPageRoute<void>(
                          builder: (context) => const DVRSeriesManager(),
                        ),
                            (route) => false,
                      );
                    }
                  }

                  if (state.currentTabSelected == 3 &&
                      state.isNavigatingControl && !state.isNavigatingTabDrawer) {
                    switch (state.controlIndex) {
                      case 0:
                        context.read<DvrMenuCubit>().del();
                        break;
                      case 1:
                        context.read<DvrMenuCubit>().space();
                        break;
                      case 2:
                        context.read<DvrMenuCubit>().clear();
                        break;
                      case 3:
                        context.read<DvrMenuCubit>().ok();
                        break;
                    }
                  } else {
                    if (state.currentTabSelected == 3 && state.inSearchList && !state.isNavigatingTabDrawer) {
                      /// Navigate to search result screen
                      Navigator.of(context)
                          .pushAndRemoveUntil(
                            MaterialPageRoute<void>(
                              builder: (context) => DVRSearchResult(
                                searchResult:
                                    state.searchResultList[state.searchIndex],
                              ),
                            ),
                          (route) => false,
                          )
                          .then((_) => focusNode.nextFocus());
                    } else {
                      if (state.searchResultList.isEmpty &&
                          state.inSearchList && !state.isNavigatingTabDrawer) {
                        return;
                      } else {
                        if (state.alphanumericIndex >= 0 && !state.isNavigatingTabDrawer) {
                          context.read<DvrMenuCubit>().typeTextResult(
                                state.alphanumeric[state.alphanumericIndex],
                              );
                          context.read<DvrMenuCubit>().searchRecord(search: '');
                        }
                      }
                    }
                  }

                  break;
                default:
              }
            }
          },
          child: BlocConsumer<DvrMenuCubit, DvrMenuState>(
            listener: (context, state) {
              if (itemScrollController.isAttached) {
                itemScrollController.scrollTo(
                  index: state.currentRecordedSelected,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                  alignment: 0.75,
                );
              }
              if (itemScrollController1.isAttached) {
                itemScrollController1.scrollTo(
                  index: state.currentScheduledSelected,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                  alignment: 0.75,
                );
              }
              if (itemScrollController2.isAttached) {
                itemScrollController2.scrollTo(
                  index: state.searchIndex,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                  alignment: 0.75,
                );
              }
              _tabController.animateTo(state.currentTabSelected);
            },
            builder: (context, state) {
              if(state.isLoading){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingAnimationWidget.staggeredDotsWave(color: Colors.amber, size: 50),
                      const SizedBox(height: 10,),
                      const Text('Loading....', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20, )),
                    ],
                  ),
                );
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: DeviceId.isStb ? const EdgeInsets.fromLTRB(20, 10, 20, 20) : EdgeInsets.zero,
                            child: Row(
                              children: [
                                const Text(
                                  'DVR',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                DigitalClock(
                                  is24HourTimeFormat: false,
                                  areaAligment: AlignmentDirectional.center,
                                  areaHeight: 30,
                                  areaWidth: 80,
                                  showSecondsDigit: false,
                                  hourMinuteDigitDecoration:
                                      const BoxDecoration(),
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
                          Container(
                            color: const Color(0xFF7E9FDB),
                            height: 30,
                            child: TabBar(
                              controller: _tabController,
                              onTap: (value) {
                                context.read<DvrMenuCubit>().changeTab(value);
                              },
                              tabs: [
                                tab(
                                  state: state,
                                  title: 'Recorded',
                                  color: state.currentTabSelected == 0 &&
                                          state.isNavigatingTabDrawer
                                      ? Colors.amber
                                      : Colors.white,
                                ),
                                tab(
                                  state: state,
                                  title: 'Scheduled',
                                  color: state.currentTabSelected == 1 &&
                                          state.isNavigatingTabDrawer
                                      ? Colors.amber
                                      : Colors.white,
                                ),
                                tab(
                                  state: state,
                                  title: 'Managed',
                                  color: state.currentTabSelected == 2 &&
                                          state.isNavigatingTabDrawer
                                      ? Colors.amber
                                      : Colors.white,
                                ),
                                tab(
                                  state: state,
                                  title: 'Search',
                                  color: state.currentTabSelected == 3 &&
                                          state.isNavigatingTabDrawer
                                      ? Colors.amber
                                      : Colors.white,
                                ),
                              ],
                              indicator: const ContainerTabIndicator(),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * (DeviceId.isStb ? .75 : .53),
                            child: TabBarView(
                              controller: _tabController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                recordTab(
                                  state: state,
                                  itemPositionsListener: itemPositionsListener,
                                  itemScrollController: itemScrollController,
                                ),
                                scheduledTab(
                                  state: state,
                                  context: context,
                                  itemPositionsListener1: itemPositionsListener1,
                                  itemScrollController1: itemScrollController1,
                                ),
                                seriesManagerTab(context: context, state: state),
                                searchTab(
                                  state: state,
                                  context: context,
                                  itemPositionsListener2: itemPositionsListener2,
                                  itemScrollController2: itemScrollController2,
                                  searchCtrl: searchCtrl,
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget tab({
  required DvrMenuState state,
  required String title,
  required Color color,
}) {
  return Text(
    title,
    style: TextStyle(
      color: color,
    ),
  );
}

