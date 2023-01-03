import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_series/dvr_series_cubit.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_movie.dart';
import 'package:iptv/core/models/recording.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DVRSeries extends StatefulWidget {
  const DVRSeries({super.key});

  @override
  State<DVRSeries> createState() => _DVRSeriesState();
}

String dropdownValue = 'All Episodes';

class _DVRSeriesState extends State<DVRSeries> {
  FocusNode focusNode = FocusNode();
  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212332),
      body: BlocProvider(
        create: (context) => DvrSeriesCubit(),
        child: BlocConsumer<DvrSeriesCubit, DvrSeriesState>(
          listener: (context, state) {
            if (itemScrollController.isAttached) {
              itemScrollController.scrollTo(
                index: state.indexSelectedSeason,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: 0.5,
              );
            }
          },
          builder: (context, state) {
            return RawKeyboardListener(
              focusNode: focusNode,
              onKey: (e) {
                FocusScope.of(context).requestFocus(focusNode);
                if (e.runtimeType == RawKeyDownEvent) {
                  switch (e.logicalKey.keyLabel) {
                    case 'Arrow Up':
                      context.read<DvrSeriesCubit>().handleKeyUp();
                      break;
                    case 'Arrow Down':
                      context.read<DvrSeriesCubit>().handleKeyDown();
                      break;
                    case 'Arrow Left':
                      context.read<DvrSeriesCubit>().handleKeyLeft();
                      break;
                    case 'Arrow Right':
                      context.read<DvrSeriesCubit>().handleKeyRight();
                      break;
                    case 'Select':

                      // Navigator.of(context).pop();
                      break;
                    default:
                  }
                }
              },
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            color: Colors.white,
                            height: 250,
                            width: 200,
                            child: const Center(
                              child: Text(
                                'Movie picture',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                color: state.isNavigatingDrawer &&
                                        state.indexSelectedDrawer == 1
                                    ? Colors.blue
                                    : const Color(0xFF7E9FDB),
                                height: 30,
                                width: 200,
                                child: const Center(
                                  child: Text(
                                    'Record options',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                color: state.isNavigatingDrawer &&
                                        state.indexSelectedDrawer == 2
                                    ? Colors.blue
                                    : const Color(0xFF7E9FDB),
                                height: 30,
                                width: 200,
                                child: const Center(
                                  child: Text(
                                    'Cancel Series',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                color: state.isNavigatingDrawer &&
                                        state.indexSelectedDrawer == 3
                                    ? Colors.blue
                                    : null,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  child: Text(
                                    '< Back',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Movie Title',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: 30,
                              color: !state.isNavigatingDrawer &&
                                      state.indexSelectedEpisode < 0 &&
                                      state.isNavigatingComboBox
                                  ? Colors.blue
                                  : const Color(0xFF7E9FDB),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  style: const TextStyle(color: Colors.white),
                                  items: <String>[
                                    'DVR',
                                    'All Episodes',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value == 'DVR') {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                        MaterialPageRoute<void>(
                                          builder: (context) => DVRMovie(
                                            recording: Recording.fromJson(
                                              {'': ''},
                                            ),
                                            isFinishedRecording: false,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .75,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                              child: Scrollbar(
                                child: ScrollablePositionedList.builder(
                                  shrinkWrap: true,
                                  // physics: const BouncingScrollPhysics(),
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    final indexSeason =
                                        index == state.indexSelectedSeason;
                                    return Card(
                                      color: Colors.transparent,
                                      child: ExpansionTile(
                                        textColor: Colors.white,
                                        initiallyExpanded: true,
                                        leading: Text(
                                          'Season $index',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        title: const Text(''),
                                        expandedCrossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        trailing: const Text(''),
                                        children: [
                                          Column(
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: 10,
                                                itemBuilder: (context, index) {
                                                  final indexEpisode = index ==
                                                      state
                                                          .indexSelectedEpisode;
                                                  return Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 12,
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            5,
                                                          ),
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                      context,
                                                                    )
                                                                        .size
                                                                        .width *
                                                                    .65,
                                                            height: 30,
                                                            color: indexSeason &&
                                                                    indexEpisode &&
                                                                    !state
                                                                        .isNavigatingDrawer
                                                                ? Colors.blue
                                                                : null,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 10,
                                                              ),
                                                              child: Row(
                                                                children: const [
                                                                  Text(
                                                                    'Ep ',
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Text(
                                                                    'Title',
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                    'Wed 3/10',
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: index == 0,
                                                        child: const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 25,
                                                            vertical: 5,
                                                          ),
                                                          child: Text(
                                                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 20,
                                                        ),
                                                        child: Divider(
                                                          color: Colors.grey,
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemScrollController: itemScrollController,
                                  itemPositionsListener: itemPositionsListener,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
