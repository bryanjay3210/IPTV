import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_recording_log/dvr_recording_log_cubit.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DVRRecordingLog extends StatefulWidget {
  const DVRRecordingLog({super.key});

  @override
  State<DVRRecordingLog> createState() => _DVRRecordingLogState();
}

class _DVRRecordingLogState extends State<DVRRecordingLog> {
  FocusNode focusNode = FocusNode();
  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
    return Scaffold(
      backgroundColor: const Color(0xFF212332),
      body: BlocProvider(
        create: (context) => DvrRecordingLogCubit(),
        child: BlocConsumer<DvrRecordingLogCubit, DvrRecordingLogState>(
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
            return RawKeyboardListener(
              focusNode: focusNode,
              onKey: (e) {
                FocusScope.of(context).requestFocus(focusNode);
                if (e.runtimeType == RawKeyDownEvent) {
                  switch (e.logicalKey.keyLabel) {
                    case 'Arrow Up':
                      context.read<DvrRecordingLogCubit>().handleKeyUp();
                      break;
                    case 'Arrow Down':
                      context.read<DvrRecordingLogCubit>().handleKeyDown();
                      break;
                    case 'Arrow Left':
                      context.read<DvrRecordingLogCubit>().handleKeyLeft();
                      break;
                    case 'Arrow Right':
                      context.read<DvrRecordingLogCubit>().handleKeyRight();
                      break;
                    case 'Select':
                      // Navigator.of(context).pop();
                      break;
                    default:
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Recording Log',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                              ),
                              Spacer(),
                              Text('3:33 AM'),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * .75,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Scrollbar(
                                    child: ScrollablePositionedList.builder(
                                      itemCount: 10,
                                      itemBuilder: (context, index) {
                                        final isSelected =
                                            index == state.indexSelected;
                                        return ListTile(
                                          tileColor: isSelected &&
                                                  !state.isNavigatingDrawer
                                              ? Colors.blue
                                              : null,
                                          title: Text('Title $index'),
                                          trailing: const Text('3/12 300AM'),
                                        );
                                      },
                                      itemScrollController:
                                          itemScrollController,
                                      itemPositionsListener:
                                          itemPositionsListener,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        Container(
                                          color: state.isNavigatingDrawer
                                              ? Colors.blue
                                              : null,
                                          child: const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                              20,
                                              10,
                                              0,
                                              10,
                                            ),
                                            child: Text(
                                              'Delete to make room for a new episode (30)',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
