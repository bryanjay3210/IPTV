import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_delete_shows/dvr_detete_shows_cubit.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_menu/dvr_menu.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_percentage_widget.dart';
import 'package:iptv/core/device_id.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class DVRDeleteShows extends StatefulWidget {
  const DVRDeleteShows({super.key});

  @override
  State<DVRDeleteShows> createState() => _DVRDeleteShowsState();
}

class _DVRDeleteShowsState extends State<DVRDeleteShows> {
  FocusNode focusNode = FocusNode();
  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  late NavigatorState _navigator;

  @override
  void didChangeDependencies() {
    _navigator = Navigator.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
    var isHide = false;
    return BlocProvider(
      create: (context) => DvrDeleteShowsCubit(),
      child: WillPopScope(
        onWillPop: () async{
          await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute<void>(
              builder: (context) => const DVRView(),
            ), (route) => false,
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
            title: const Text('Delete Shows'),
          ),
          backgroundColor: const Color(0xFF212332),
          body: BlocConsumer<DvrDeleteShowsCubit, DvrDeleteShowsState>(
            listener: (context, state) {
              if (itemScrollController.isAttached) {
                itemScrollController.scrollTo(
                  index: state.indexSelected,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  alignment: 0.5,
                );
              }
            },
            builder: (context, state) {
              if (state.checkboxList!
                  .where((element) => element == true)
                  .isNotEmpty) {
                isHide = true;
              } else {
                isHide = false;
              }
              if (state.checkboxList!
                  .where((element) => element == false)
                  .isNotEmpty) {
                context
                    .read<DvrDeleteShowsCubit>()
                    .allIsNotSelected(isChecked: false);
              }
              if (state.checkboxList!
                  .where((element) => element == false)
                  .isEmpty) {
                context
                    .read<DvrDeleteShowsCubit>()
                    .allIsNotSelected(isChecked: true);
              }
              return RawKeyboardListener(
                focusNode: focusNode,
                onKey: (e) {
                  FocusScope.of(context).requestFocus(focusNode);
                  if (e.runtimeType == RawKeyDownEvent) {
                    switch (e.logicalKey.keyLabel) {
                      case 'Arrow Up':
                        context.read<DvrDeleteShowsCubit>().handleKeyUp();
                        break;
                      case 'Arrow Down':
                        context.read<DvrDeleteShowsCubit>().handleKeyDown();
                        break;
                      case 'Arrow Left':
                        context.read<DvrDeleteShowsCubit>().handleKeyLeft();
                        break;
                      case 'Arrow Right':
                        context.read<DvrDeleteShowsCubit>().handleKeyRight();
                        break;
                      case 'Select':
                        setState(() {
                          context
                              .read<DvrDeleteShowsCubit>()
                              .handleSelectKey(context);
                        });
                        break;
                      default:
                    }
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            Visibility(
                              visible: DeviceId.isStb,
                              child: const Text(
                                'Delete Shows',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Visibility(
                            visible: state.recordedPrograms.isNotEmpty,
                            child: Container(
                              color:
                                  state.isNavigatingTab && state.currentTab == 0 && DeviceId.isStb
                                      ? Colors.blue
                                      : Colors.transparent,
                              width: 130,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Checkbox(
                                      value: state.isCheckAll,
                                      onChanged: (value) {
                                        context.read<DvrDeleteShowsCubit>().selectUnselectAll();
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(state.isCheckAll ? 'Unselect All' : 'Select All'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Visibility(
                            visible: isHide,
                            child: GestureDetector(
                              onTap: () => context.read<DvrDeleteShowsCubit>().handleDeleteFunc(context),
                              child: Container(
                                height: 30,
                                color:
                                    state.isNavigatingTab && state.currentTab == 1 && DeviceId.isStb
                                        ? Colors.blue
                                        : Colors.transparent,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.delete),
                                        Text(
                                          state.isCheckAll
                                              ? 'Delete All Programs'
                                              : 'Delete Program',
                                        ),
                                      ],
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
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child:
                            BlocBuilder<DvrDeleteShowsCubit, DvrDeleteShowsState>(
                          builder: (context, state) {
                            if (state.recordedPrograms.isNotEmpty &&
                                !state.isLoading) {
                              return Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 30,
                                    child: Row(
                                      children: const [
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            'Title',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
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
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Scrollbar(
                                      child: ScrollablePositionedList.builder(
                                        itemCount: state.recordedPrograms.length,
                                        itemBuilder: (context, index) {
                                          final isSelected =
                                              index == state.indexSelected &&
                                                  !state.isNavigatingTab;
                                          return Container(
                                            height: 35,
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            color: isSelected
                                                ? Colors.blue
                                                : Colors.transparent,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 30,
                                                  child: Checkbox(
                                                    checkColor: Colors.blue,
                                                    value: state
                                                        .checkboxList![index],
                                                    onChanged: (bool? value) {
                                                      context.read<DvrDeleteShowsCubit>().selectItem(index: index);
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 30,
                                                  child: Icon(Icons.movie),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    state.recordedPrograms[index]
                                                        .programTitle,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      state
                                                                  .recordedPrograms[
                                                                      index]
                                                                  .epgSeasonNum ==
                                                              '0'
                                                          ? ''
                                                          : state
                                                              .recordedPrograms[
                                                                  index]
                                                              .epgSeasonNum,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      state
                                                          .recordedPrograms[index]
                                                          .epgShowId,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    dateTimeStringConverter(
                                                      state
                                                          .recordedPrograms[index]
                                                          .programStartTime,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        itemScrollController:
                                            itemScrollController,
                                        itemPositionsListener:
                                            itemPositionsListener,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            if (state.recordedPrograms.isEmpty &&
                                !state.isLoading) {
                              return const Center(
                                child: Text('No Program as of now.'),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          },
                        ),
                      ),
                    ),
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

String dateTimeStringConverter(String date) {
  final year = int.parse(date.substring(0, 4));
  final month = int.parse(date.substring(4, 6));
  final day = int.parse(date.substring(6, 8));
  final hour = int.parse(date.substring(8, 10));
  final minute = int.parse(date.substring(10, 12));

  final dt = DateTime(year, month, day, hour, minute);
  final time = DateFormat.jm();
  final result = '$year/$month/$day ${time.format(dt)}';

  return result;
}
