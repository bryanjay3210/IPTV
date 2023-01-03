import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_menu/dvr_menu_cubit.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_movie/dvr_movie_cubit.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_menu/dvr_menu.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_stream_page.dart';
import 'package:iptv/core/api_service/dvr_service.dart';
import 'package:iptv/core/models/recording.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DVRMovie extends StatefulWidget {
  const DVRMovie({
    super.key,
    required this.recording,
    required this.isFinishedRecording,
  });

  final Recording recording;
  final bool isFinishedRecording;

  @override
  State<DVRMovie> createState() => _DVRMovieState();
}

String dropdownValue = 'DVR';

class _DVRMovieState extends State<DVRMovie> {
  FocusNode focusNode = FocusNode();
  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => FocusScope.of(context).requestFocus(focusNode),
    );
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);

    return WillPopScope(
      onWillPop: () async {
        await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
            builder: (context) => const DVRView(),
          ),
          (route) => false,
        );

        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF212332),
        body: BlocProvider(
          create: (context) => DvrMovieCubit(),
          child: BlocConsumer<DvrMovieCubit, DvrMovieState>(
            listener: (context, state) {
              if (itemScrollController.isAttached) {
                itemScrollController.scrollTo(
                  index: state.indexSelectedDrawer,
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
                        if (state.isNavigatingDrawer &&
                            state.indexSelectedDrawer == 4 &&
                            !widget.recording.seriesRecord) {
                          context.read<DvrMovieCubit>().subIndex();
                        }
                        context.read<DvrMovieCubit>().handleKeyUp();
                        break;
                      case 'Arrow Down':
                        final state = context.read<DvrMovieCubit>().state;
                        if (state.isNavigatingDrawer &&
                            state.indexSelectedDrawer == 2 &&
                            !widget.recording.seriesRecord) {
                          context.read<DvrMovieCubit>().addIndex();
                        }
                        context.read<DvrMovieCubit>().handleKeyDown();
                        break;
                      case 'Arrow Left':
                        context.read<DvrMovieCubit>().handleKeyLeft();
                        break;
                      // case 'Arrow Right':
                      //   context.read<DvrMovieCubit>().handleKeyRight();
                      //   break;
                      case 'Select':
                        final state = context.read<DvrMovieCubit>().state;

                        if (state.isNavigatingDrawer) {
                          switch (state.indexSelectedDrawer) {
                            case 1:
                              watch();
                              break;
                            case 2:
                              deleteProgram();
                              break;
                            case 3:
                              cancelRecording();
                              break;
                            case 4:
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute<void>(
                                  builder: (context) => const DVRView(),
                                ),
                                (route) => false,
                              );
                              break;
                          }
                        }
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
                            CachedNetworkImage(
                              imageUrl: widget.recording.channelIconURL,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: watch,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  color: state.indexSelectedDrawer == 1 &&
                                          state.isNavigatingDrawer
                                      ? Colors.blue
                                      : const Color(0xFF7E9FDB),
                                  height: 30,
                                  width: 200,
                                  child: const Center(
                                    child: Text(
                                      'Watch',
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
                              onTap: deleteProgram,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  color: state.indexSelectedDrawer == 2 &&
                                          state.isNavigatingDrawer
                                      ? Colors.blue
                                      : const Color(0xFF7E9FDB),
                                  height: 30,
                                  width: 200,
                                  child: const Center(
                                    child: Text(
                                      'Delete Show',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: widget.recording.seriesRecord,
                              child: GestureDetector(
                                onTap: cancelRecording,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    color: state.indexSelectedDrawer == 3 &&
                                            state.isNavigatingDrawer
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
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () =>
                              //     Navigator.of(context).pushAndRemoveUntil(
                              //   MaterialPageRoute<void>(
                              //     builder: (context) => const DVRView(),
                              //   ),
                              //   (route) => false,
                              // ),
                              Navigator.pop(context),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  color: state.indexSelectedDrawer == 4 &&
                                          state.isNavigatingDrawer
                                      ? Colors.blue
                                      : null,
                                  width: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.arrow_back_ios, size: 13),
                                        Text(
                                          'Back',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
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
                            Text(
                              widget.recording.programTitle,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(5),
                            //   child: Container(
                            //     height: 30,
                            //     color: !state.isNavigatingDrawer
                            //         ? Colors.blue
                            //         : const Color(0xFF7E9FDB),
                            //     child: Padding(
                            //       padding:
                            //           const EdgeInsets.symmetric(horizontal: 20),
                            //       child: DropdownButton<String>(
                            //         value: dropdownValue,
                            //         style: const TextStyle(color: Colors.white),
                            //         items: <String>[
                            //           'DVR',
                            //           'All Episodes',
                            //         ].map<DropdownMenuItem<String>>((String value) {
                            //           return DropdownMenuItem<String>(
                            //             value: value,
                            //             child: Text(value),
                            //           );
                            //         }).toList(),
                            //         onChanged: (value) {
                            //           if (value == 'All Episodes') {
                            //             Navigator.of(context).pop();
                            //             Navigator.of(context).push(
                            //               MaterialPageRoute(
                            //                 builder: (context) => const DVRSeries(),
                            //               ),
                            //             );
                            //           }
                            //         },
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(5),
                            //   child: Container(
                            //     color: Colors.blue,
                            //     height: 30,
                            //     width: double.infinity,
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //       children: const [
                            //         Text('Alien Dinner Party'),
                            //         Text('S2 | E8'),
                            //         Text('DVR 3/16'),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.recording.programDescription,
                              style: const TextStyle(fontSize: 13),
                            ),
                            const Divider(color: Colors.grey),
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
      ),
    );
  }

  Future<void> watch() async {
    unawaited(
      SmartDialog.showLoading(
        backDismiss: false,
      ),
    );

    try {
      await GetIt.I
          .get<ChopperClient>()
          .getService<DVRService>()
          .getPlaybackRecording(
            channelTblRowId: widget.recording.channelTblRowId,
            epgShowId: widget.recording.epgShowId,
            timecode: widget.recording.programStartTime,
          )
          .then((resp) {
        final parsedResp = resp.body!;

        if (parsedResp['RC'] == 'E-000') {
          // locator<CacheService>().setValue(
          //   'dvrStreamUrl',
          //   parsedResp['url'].toString(),
          // );
          // locator<CacheService>().setValue(
          //   'dvrRecording',
          //   jsonEncode(widget.recording.toJson()),
          // );

          unawaited(
            SmartDialog.dismiss(),
          );

          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) {
                return DVRStreamPage(
                  streamUrl: parsedResp['url'].toString(),
                  recording: widget.recording,
                );
              },
            ),
          );

          FocusScope.of(context).unfocus();
        } else {
          unawaited(
            SmartDialog.dismiss(),
          );

          SmartDialog.showToast(
            'Error loading stream. ${parsedResp['RC']}',
            displayTime: const Duration(seconds: 10),
          );
        }
      });
    } catch (e) {}
  }

  Future<void> deleteProgram() async {
    await GetIt.I
        .get<ChopperClient>()
        .getService<DVRService>()
        .deleteRecording(
          channelTblRowId: widget.recording.channelTblRowId,
          epgShowId: widget.recording.epgShowId,
          timecode: widget.recording.programStartTime,
        )
        .then((resp) {
      final parsedResp = resp.body!;

      if (parsedResp['RC'] == 'E-000') {
        context.read<DvrMenuCubit>().initializeCubit(context);

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
            builder: (context) => const DVRView(),
          ),
          (route) => false,
        );
      } else {
        SmartDialog.showToast(
          'Error deleting show. ${parsedResp['RC']}',
          displayTime: const Duration(seconds: 10),
        );
      }
    });
  }

  Future<void> cancelRecording() async {
    await GetIt.I
        .get<ChopperClient>()
        .getService<DVRService>()
        .stopRecordingSeries(epgSeriesId: widget.recording.epgSeriesId)
        .then((resp) {
      final parsedResp = resp.body!;

      if (parsedResp['RC'].toString().contains('E-000')) {
        SmartDialog.showToast(
          'Successfully cancelled series for recording.',
          displayTime: const Duration(seconds: 10),
        );

        context.read<DvrMenuCubit>().initializeCubit(context);
      } else {
        SmartDialog.showToast(
          'Error cancelling series. ${parsedResp['RC']}',
          displayTime: const Duration(seconds: 10),
        );
      }
    });
  }
}
