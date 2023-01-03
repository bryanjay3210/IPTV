import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:iptv/app/dvr_service.dart';
import 'package:iptv/app/features/live_tv/blocs/epg/epg_cubit.dart';
import 'package:iptv/app/features/live_tv/blocs/mini_menu/mini_menu_bloc.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_menu/dvr_menu_cubit.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_series_manager/dvr_series_manager_cubit.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_movie.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_search_result.dart';
import 'package:iptv/app/home/bloc/channel_bloc.dart';
import 'package:iptv/app/view/navigation_service.dart';
import 'package:iptv/core/api_service/dvr_service.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/models/channel_and_program.dart';
import 'package:iptv/core/models/recording.dart';

part 'dvr_search_result_state.dart';

class DvrSearchResultCubit extends Cubit<DvrSearchResultState> {
  DvrSearchResultCubit()
      : super(
    const DvrSearchResultState(
      episodeList: [],
      isLoading: false,
      filterBy: 'AllEpisode',
      inFilter: true,
      currentIndex: 0,
      filterIndex: 0,
      inDialog: false,
      dialogIndex: 0,
      btnLoading: false,
      seriesId: '',
      inCancelDialog: false,
      cancelDialogIndex: 0,
    ),
  );


  void initializeCubit(ChannelAndProgram searchResult) {
    emit(state.copyWith(isLoading: true, episodeList: [], inFilter: true));
    final episodeList = DvrService.channelsAndProgram
        .where((element) => element.seriesId == searchResult.seriesId)
        .toSet()
        .toList();
    emit(state.copyWith(isLoading: false, episodeList: episodeList, seriesId: searchResult.seriesId.toString()));
  }

  void hideDialog(){
    emit(state.copyWith(inDialog: false, inCancelDialog: false));
  }

  void changeFilter(String filter) {
    emit(state.copyWith(filterBy: filter));
  }

  void disableDialogControl(){
    emit(state.copyWith(inDialog: false, inCancelDialog: false));
  }

  void showDialog(BuildContext context) {
    emit(state.copyWith(inDialog: true, dialogIndex: 0));
    recordDialog(state: state, context: context, index: 0);
  }

  void handleUpKey() {
    if (!state.inDialog && !state.inCancelDialog) {
      if (state.currentIndex < 1) {
        emit(state.copyWith(inFilter: true, filterBy: 'AllEpisode'));
      } else {
        emit(state.copyWith(currentIndex: state.currentIndex - 1));
      }
    }
  }

  void handleDownKey() {
    if (!state.inDialog && !state.inCancelDialog) {
      if (state.inFilter) {
        emit(state.copyWith(currentIndex: 0, inFilter: false));
      } else {
        if (state.currentIndex >= state.episodeList.length - 1) return;
        emit(
          state.copyWith(
            inFilter: false,
            currentIndex: state.currentIndex + 1,
          ),
        );
      }
    }
  }

  void handleLeftKey() {
    if (state.inFilter) {
      switch (state.filterIndex) {
        case 0:
          break;
        default:
          emit(state.copyWith(filterIndex: state.filterIndex - 1));
      }
    }
    if (state.inDialog) {
      if (state.dialogIndex < 1) {
        return;
      } else {
        emit(state.copyWith(dialogIndex: state.dialogIndex - 1));
      }
    }
    if(state.inCancelDialog){
      switch(state.cancelDialogIndex){
        case 0:
          break;
        default:
          emit(state.copyWith(cancelDialogIndex: state.cancelDialogIndex - 1));
          break;
      }
    }
  }

  void handleRightKey() {
    if (state.inFilter) {
      switch (state.filterIndex) {
        case 2:
          break;
        default:
          emit(state.copyWith(filterIndex: state.filterIndex + 1));
      }
    }
    if (state.inDialog) {
      if (state.dialogIndex > 1) {
        return;
      } else {
        emit(state.copyWith(dialogIndex: state.dialogIndex + 1));
      }
    }
    if(state.inCancelDialog){
      switch(state.cancelDialogIndex){
        case 2:
          break;
        default:
          emit(state.copyWith(cancelDialogIndex: state.cancelDialogIndex + 1));
          break;
      }
    }
  }

  Future<void> handleSelectKey(
      ChannelAndProgram searchResult,
      BuildContext context,
      FocusNode focusNode,
      ) async {
    if (state.inFilter) {
      if (state.filterIndex == 0) {
        emit(state.copyWith(filterBy: 'AllEpisode'));
        filterEpisode(searchResult);
      } else if (state.filterIndex == 1) {
        emit(state.copyWith(filterBy: 'NewEpisode'));
        filterEpisode(searchResult);
      } else if (state.filterIndex == 2) {
        emit(state.copyWith(filterBy: 'DVR'));
        filterEpisode(searchResult);
      }
    }
    if (!state.inFilter) {
      if (state.episodeList.isNotEmpty) {
        if (state.episodeList[state.currentIndex].isRecorded == 'Y') {
          await playInDVR(context: context, focusNode: focusNode);
        } else if(state.episodeList[state.currentIndex].isCurrentlyRecording == true){
          if(!state.inCancelDialog){
            emit(state.copyWith(inCancelDialog: true, cancelDialogIndex: 0));
            await cancelRecordDialog(context: context, index: state.currentIndex, state: state);
          } else {
            switch(state.cancelDialogIndex){
              case 0:
                await cancelRecording(context: context,).then((_) {
                  hideDialog();
                });
                break;
              case 1:
                await cancelRecording(context: context, isSeries: true).then((value) {
                  hideDialog();
                });
                break;
              case 2:
                Navigator.pop(context);
                hideDialog();
                break;
            }
          }

        } else {
          if (!state.inDialog) {
            showDialog(context);
          } else {
            switch (state.dialogIndex) {
              case 0:
                await startRecording(context: context);
                break;
              case 1:
                await startRecording(context: context, isSeries: true);
                break;
              case 2:
                Navigator.pop(context);
                emit(state.copyWith(inDialog: false));
             break;
            }
          }
        }
      }
    }
  }

  // Future<void> cancelRecording({required BuildContext context}) async {
  //   emit(state.copyWith(btnLoading: true));
  //   final program = state.episodeList[state.currentIndex];
  //   final upcoming = context.read<DvrMenuCubit>().state.upcomingPrograms.where((element) => element.channelTblRowId == program.channelId && element.epgShowId == program.showId).toList();
  //   if(upcoming.isNotEmpty){
  //     await GetIt.I
  //         .get<ChopperClient>()
  //         .getService<DVRService>()
  //         .deleteRecording(
  //       channelTblRowId: upcoming[0].channelTblRowId,
  //       epgShowId:upcoming[0].epgShowId,
  //       timecode: upcoming[0].programStartTime,
  //     )
  //         .timeout(const Duration(seconds: 45))
  //         .then((resp) async {
  //       final parsedResp = resp.body!;
  //
  //       if (parsedResp['RC'] == 'E-000') {
  //         updateProgram(index: state.currentIndex, fromRecording: false, context: context);
  //         await SmartDialog.showToast('Successfully cancel recordings.');
  //       } else {
  //         await SmartDialog.showToast(
  //           'Error deleting show. ${parsedResp['RC']}',
  //           displayTime: const Duration(seconds: 10),
  //         );
  //       }
  //     });
  //   }
  //   emit(state.copyWith(btnLoading: false, inDialog: false, inCancelDialog: false));
  //   Navigator.pop(context);
  // }
  //
  // Future<void> cancelSeries({required BuildContext context}) async {
  //   emit(state.copyWith(isLoading: true));
  //   final seriesId = state.episodeList[state.currentIndex].seriesId.toString();
  //   await GetIt.I<ChopperClient>()
  //       .getService<DVRService>()
  //       .stopRecordingSeries(
  //     epgSeriesId: seriesId,
  //   )
  //       .then((value) async{
  //     Navigator.of(context).pop();
  //     context
  //         .read<ChannelBloc>()
  //         .add(ChannelEvent.updateProgramRecordStatus(epgSeriesId: seriesId));
  //     await DvrService().fetchChannelAndProgram();
  //   });
  //   emit(state.copyWith(isLoading: false, inCancelDialog: false));
  // }

  Future<void> startRecording({
    bool isSeries = false,
    required BuildContext context,
    int index = 0
  }) async {
    emit(state.copyWith(btnLoading: true));
    final recIndex = DeviceId.isStb ? state.currentIndex : index;
    await NavigationService.navigatorKey.currentContext!
        .read<ChannelBloc>()
        .state
        .mapOrNull(
        loaded: (loaded) async {
          final channel = loaded.channels.firstWhere(
                (element) =>
            element.epgChannelId ==
                state.episodeList[recIndex].channelId,
          );
          if(!channel.dvrEnabled){
            Navigator.pop(context);
            unawaited(SmartDialog.showToast('Unable to record program.'));
            emit(state.copyWith(inDialog: false));
            return;
          }

          final channelIndex = loaded.channels.indexWhere((element) => element.epgChannelId ==  state.episodeList[recIndex].channelId);
          final programIndex = loaded.filteredChannels[channelIndex].programs!.indexWhere((element) => element.epgShowId == state.episodeList[recIndex].showId,);

          if (channelIndex == -1 ||
              programIndex == -1) {
            return;
          }

          if (!isSeries) {
            context.read<ChannelBloc>().add(
              ChannelEvent.recordProgram(
                channelIndex,
                programIndex,
                    (channels) async {
                  await context.read<ChannelBloc>().state.maybeMap(
                    loaded: (channelState) async {
                      context.read<EpgCubit>().handleStartRecording(
                        channelState.filteredChannels,
                      );
                      // await DvrService().fetchChannelAndProgram().then((value) {
                      //   emit(state.copyWith(isLoading: false, episodeList: value.where((element) => element.seriesId == seriesId).toList()));
                      // });
                    },
                    orElse: () => null,
                  );
                },
              ),
            );
            updateProgram(context: context);
          } else {
            context.read<ChannelBloc>().add(
              ChannelEvent.recordSeries(
                  channelIndex,
                  programIndex,
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
            final episodeList = DvrService.channelsAndProgram
                .where((element) => element.seriesId == state.seriesId)
                .toSet()
                .toList();
            episodeList[DeviceId.isStb ? state.currentIndex : index] = episodeList[DeviceId.isStb ? state.currentIndex : index].copyWith(isCurrentlyRecording: true);
            emit(state.copyWith(episodeList: episodeList));
          }
        },);
    emit(state.copyWith(btnLoading: false));
    Navigator.pop(context);
  }

  Future<void> cancelRecording({required BuildContext context, bool isSeries = false, int index = 0}) async {
    emit(state.copyWith(isLoading: true));
    await NavigationService.navigatorKey.currentContext!
        .read<ChannelBloc>()
        .state
        .mapOrNull(
        loaded: (loaded) async {
          final channel = loaded.channels.firstWhere(
                (element) =>
            element.epgChannelId ==
                state.episodeList[DeviceId.isStb ? state.currentIndex : index].channelId,
          );
          if (!channel.dvrEnabled) {
            Navigator.pop(context);
            unawaited(SmartDialog.showToast('Unable to record program.'));
            emit(state.copyWith(inDialog: false));
            return;
          }

          final channelIndex = loaded.channels.indexWhere((element) =>
          element.epgChannelId ==
              state.episodeList[DeviceId.isStb ? state.currentIndex : index].channelId);
          final programIndex = loaded.filteredChannels[channelIndex].programs!
              .indexWhere((element) =>
          element.epgShowId == state.episodeList[DeviceId.isStb ? state.currentIndex : index].showId,);
          final seriesId = state.episodeList[DeviceId.isStb ? state.currentIndex : index].seriesId.toString();

          if (channelIndex == -1 ||
              programIndex == -1) {
            return;
          }
          if(!isSeries){
            context.read<ChannelBloc>().add(
              ChannelEvent.stopRecordingProgram(
                channelIndex,
                programIndex,
                    (channels) async {
                  await context.read<ChannelBloc>().state.maybeMap(
                    loaded: (channelState) async {
                      context
                          .read<EpgCubit>()
                          .handleStopRecording(channels);
                      await DvrService().fetchChannelAndProgram().then((value) {
                        emit(state.copyWith(isLoading: false, episodeList: value.where((element) => element.seriesId == seriesId).toList()));
                      });
                    },
                    orElse: () => null,
                  );
                },
              ),
            );
            updateProgram(context: context, fromRecording: false);
          } else {
            await GetIt.I<ChopperClient>()
                .getService<DVRService>()
                .stopRecordingSeries(
              epgSeriesId: seriesId,
            )
                .then((value) {
              context.read<DvrSeriesManagerCubit>().reloadList(context);
              context
                  .read<ChannelBloc>()
                  .add(ChannelEvent.updateProgramRecordStatus(epgSeriesId: seriesId));
              DvrService().fetchChannelAndProgram().then((value) {
                emit(state.copyWith(isLoading: false, episodeList: value.where((element) => element.seriesId == seriesId).toList()));
              });
              SmartDialog.showToast('Successfully stop recording.');
            });
            updateProgram(context: context, fromRecording: false);
          }
        },);
    Navigator.pop(context);
  }

  void updateProgram({int index = 0, bool fromRecording = true, required BuildContext context}) {
    emit(state.copyWith(isLoading: true));
    context.read<ChannelBloc>().add(const ChannelEvent.fetch());
    DvrService().fetchChannelAndProgram().then((_) {
      final episodeList = DvrService.channelsAndProgram
          .where((element) => element.seriesId == state.seriesId)
          .toSet()
          .toList();
      episodeList[DeviceId.isStb ? state.currentIndex : index] = episodeList[DeviceId.isStb ? state.currentIndex : index].copyWith(isCurrentlyRecording: fromRecording);
      // DvrService.channelsAndProgram[DvrService.channelsAndProgram.indexWhere((element) => element.programTblRowId == episodeList[index].programTblRowId)] =
      //     DvrService.channelsAndProgram[DvrService.channelsAndProgram.indexWhere((element) => element.programTblRowId == episodeList[index].programTblRowId)].copyWith(isCurrentlyRecording: fromRecording);
      emit(state.copyWith(episodeList: episodeList, isLoading: false));
    });
  }

  Future<void> playInDVR({required BuildContext context, required FocusNode focusNode,}) async{
    final rec = context
        .read<DvrMenuCubit>()
        .state
        .recordedPrograms
        .firstWhere(
          (element) =>
      element.epgSeriesId ==
          state.episodeList[state.currentIndex].seriesId &&
          element.programTblRowId ==
              state.episodeList[state.currentIndex].programTblRowId,
    );
    await Navigator.of(context)
        .push(
      MaterialPageRoute<void>(
        builder: (context) => DVRMovie(
          recording: rec,
          isFinishedRecording: false,
        ),
      ),
    )
        .then((value) => focusNode.nextFocus());
  }

  void filterEpisode(ChannelAndProgram searchResult) {
    switch (state.filterIndex) {
      case 0:
        allEpisodeFilter(searchResult);
        break;
      case 1:
        newEpisodeFilter(searchResult);
        break;
      case 2:
        dvrFilter(searchResult);
        break;
      default:
    }
  }

  void allEpisodeFilter(ChannelAndProgram searchResult){
    emit(
      state.copyWith(
        isLoading: true,
        currentIndex: 0,
        inFilter: true,
        episodeList: [],
      ),
    );
    final filtered = DvrService.channelsAndProgram
        .where((element) => element.seriesId == searchResult.seriesId)
        .toList();
    emit(
      state.copyWith(
        currentIndex: 0,
        episodeList: filtered,
        isLoading: false,
      ),
    );
  }

  void newEpisodeFilter(ChannelAndProgram searchResult){
    try {
      emit(
        state.copyWith(
          isLoading: true,
          currentIndex: 0,
          inFilter: true,
          episodeList: [],
        ),
      );
      final filtered = DvrService.channelsAndProgram
          .where(
            (element) =>
        element.seriesId == searchResult.seriesId &&
            DateTime.now()
                .isAfter(DateTime.parse(element.showDate.toString())),
      )
          .toList();
      emit(state.copyWith(episodeList: filtered, isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(episodeList: [], isLoading: false, currentIndex: 0),
      );
    }
  }

  void dvrFilter(ChannelAndProgram searchResult){
    emit(
      state.copyWith(
        isLoading: true,
        currentIndex: 0,
        inFilter: true,
        episodeList: [],
      ),
    );
    final filtered = DvrService.channelsAndProgram
        .where(
          (element) =>
      element.seriesId == searchResult.seriesId &&
          element.isRecorded == 'Y',
    )
        .toList();
    emit(
      state.copyWith(
        episodeList: filtered,
        isLoading: false,
        currentIndex: 0,
      ),
    );
  }
}
