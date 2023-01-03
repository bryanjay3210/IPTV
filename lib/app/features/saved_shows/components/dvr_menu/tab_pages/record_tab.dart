import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_menu/dvr_menu_cubit.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_movie.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_percentage_widget.dart';
import 'package:iptv/core/helpers/date_converter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

Widget recordTab({
  required DvrMenuState state,
  required ItemScrollController itemScrollController,
  required ItemPositionsListener itemPositionsListener,
}) {
  return Row(
    children: [
      Expanded(
        flex: 4,
        child: BlocBuilder<DvrMenuCubit, DvrMenuState>(
          builder: (context, state) {
            if (state.recordedPrograms.isNotEmpty && !state.isLoading) {
              return Column(
                children: [
                  SizedBox(
                    height: 30,
                    width: double.infinity,
                    child: Row(
                      children: const [
                        SizedBox(width: 40,),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Title',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Season',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Episode',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Previously shown date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: ScrollablePositionedList.builder(
                        initialScrollIndex: state.currentRecordedSelected,
                        // initialAlignment: 0.75,
                        itemCount: state.recordedPrograms.length,
                        // shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final isSelected =
                              index == state.currentRecordedSelected;
                          return GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DVRMovie(
                                  recording: state.recordedPrograms[index],
                                  isFinishedRecording: false,
                                ),
                              ),
                            ),
                            child: Container(
                              height: 35,
                              width: double.infinity,
                              color: isSelected &&
                                  !state.isNavigatingTabDrawer &&
                                  !state.isNavigatingSortDrawer
                                  ? Colors.blue
                                  : Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 40,
                                    child: Icon(
                                      Icons.movie,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      state
                                          .recordedPrograms[index].programTitle,
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        state.recordedPrograms[index]
                                            .epgSeasonNum ==
                                            '0'
                                            ? ''
                                            : state.recordedPrograms[index]
                                            .epgSeasonNum,
                                        style: const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        state.recordedPrograms[index].epgShowId,
                                        style: const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      dateTimeStringConverter(
                                        state.recordedPrograms[index]
                                            .programStartTime,
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemScrollController: itemScrollController,
                        itemPositionsListener: itemPositionsListener,
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state.recordedPrograms.isEmpty && !state.isLoading) {
              return const Center(
                child: Text(
                  "You don't have any recorded programs.",
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),
      BlocBuilder<DvrMenuCubit, DvrMenuState>(builder: (context, state) {
        return Expanded(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Sort',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => context.read<DvrMenuCubit>().sortListByDate(),
                child: Container(
                  height: 30,
                  color:
                  state.isNavigatingSortDrawer && state.currentSortSelected == 1
                      ? Colors.blue
                      : null,
                  child: const Center(
                    child: Text(
                      'By Date',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => context.read<DvrMenuCubit>().sortListByTime(),
                child: Container(
                  height: 30,
                  color: state.isNavigatingSortDrawer &&
                      state.currentSortSelected == 2 &&
                      state.isNavigatingSortDrawer
                      ? Colors.blue
                      : null,
                  child: const Center(
                    child: Text(
                      'By Time',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.fromLTRB(
                  60,
                  0,
                  0,
                  0,
                ),
                child: DvrPercentageWidget(),
              ),
            ],
          ),
        );
      },)
    ],
  );
}
