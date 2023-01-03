import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:iptv/app/dvr_service.dart';
import 'package:iptv/app/home/bloc/channel_bloc.dart';
import 'package:iptv/app/view/navigation_service.dart';
import 'package:iptv/core/api_service/dvr_service.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/models/channel_and_program.dart';
import 'package:iptv/core/models/recording.dart';
import 'package:provider/provider.dart';

part 'dvr_menu_state.dart';

class DvrMenuCubit extends Cubit<DvrMenuState> {
  DvrMenuCubit()
      : super(
          const DvrMenuState(
            isNavigatingTabDrawer: true,
            currentRecordedSelected: 0,
            currentTabSelected: 0,
            tab: ['Recorded', 'Scheduled', 'Managed'],
            recorded: [],
            currentSortSelected: 1,
            isNavigatingSortDrawer: false,
            currentManagedSelected: 0,
            isNavigatingManagedMenu: false,
            currentScheduledSelected: 0,
            recordedPrograms: [],
            upcomingPrograms: [],
            isNavigatingAlertDialog: false,
            currentAlertBoxSelected: 0,
            isLoading: false,
            alphanumeric: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
            alphanumericIndex: -1,
            isNavigatingControl: false,
            controlIndex: 0,
            textSearch: '',
            isSearchLoading: false,
            searchResultList: [],
            channelAndProgramList: [],
            inSearchList: false,
            searchIndex: 0,
            inAlphaNumeric: false,
          ),
        );

  void changeTab(int data) {
    emit(
      state.copyWith(
        currentTabSelected: data,
      ),
    );
  }

  void restartNavigation() {
    emit(
      state.copyWith(
        // isNavigatingTabDrawer: true,
        isNavigatingAlertDialog: false,
        isNavigatingManagedMenu: false,
        isNavigatingSortDrawer: false,
        currentManagedSelected: 0,
        currentSortSelected: 1,
        currentScheduledSelected: 0,
        currentRecordedSelected: 0,
        currentAlertBoxSelected: 0,
        // currentTabSelected: 0,
        isLoading: false,
        // alphanumericIndex: -1,
        // isNavigatingControl: false,
        // controlIndex: 0,
        // textSearch: '',
        // isSearchLoading: false,
        // searchResultList: [],
        // channelAndProgramList: [],
        // inSearchList: false,
        // searchIndex: 0,
        // inAlphaNumeric: false,
      ),
    );
  }

  void typeTextResult(String char) {
    emit(state.copyWith(textSearch: state.textSearch + char));
  }

  Future<void> del() async{
    emit(
      state.copyWith(
        textSearch: state.textSearch.substring(0, state.textSearch.length - 1),
      ),
    );
    if (state.textSearch.isEmpty) {
      emit(state.copyWith(textSearch: '', searchResultList: []));
    } else {
      await searchRecord(search: '');
    }
  }

  Future<void> space() async {
    emit(state.copyWith(textSearch: '${state.textSearch} '));
    await searchRecord(search: '');
  }

  void clear() {
    emit(state.copyWith(textSearch: '', searchResultList: []));
  }

  void ok() {}

  Future<void> searchRecord({required String search}) async {
    emit(state.copyWith(isSearchLoading: true, searchResultList: []));
    var programs = <ChannelAndProgram>[];
    await DvrService().fetchChannelAndProgram();
    programs = DvrService.channelsAndProgram
        .where(
          (element) => element.programTitle.toString().toLowerCase().contains(
        DeviceId.isStb
            ? state.textSearch.toLowerCase()
            : search.toLowerCase(),
      ),
    )
        .toList();
    emit(state.copyWith(searchResultList: programs, isSearchLoading: false));
  }

  void changeRecordSelected(int data) {
    emit(
      state.copyWith(
        currentRecordedSelected: data,
      ),
    );
  }

  Future<void> initializeCubit(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    final now = DateTime.now();
    final resp = await GetIt.I
        .get<ChopperClient>()
        .getService<DVRService>()
        .getRecordingList()
        .timeout(const Duration(seconds: 45));
    final parsedResp = resp.body!;
    log('Recordings:$parsedResp');
    final recordingList = <Recording>[];

    final recordedPrograms = <Recording>[];
    final upcomingPrograms = <Recording>[];
    if (parsedResp.containsKey('Recordings')) {
      final recordings = parsedResp['Recordings'] as Map<String, dynamic>;
      if (recordings.containsKey('Program')) {
        final programs = recordings['Program'];

        if (programs is List<dynamic>) {
          for (final element in programs) {
            recordingList
                .add(Recording.fromJson(element as Map<String, dynamic>));
          }
        } else if (programs is Map<String, dynamic>) {
          if (programs.isNotEmpty) {
            recordingList.add(Recording.fromJson(programs));
          }
        }
      }
    }

    recordingList.sort((a, b) {
      var epgTimeA = a.programStopTime;
      epgTimeA = '${epgTimeA.substring(0, 8)}T${epgTimeA.substring(8)}Z';
      var epgTimeB = b.programStopTime;
      epgTimeB = '${epgTimeB.substring(0, 8)}T${epgTimeB.substring(8)}Z';

      return DateTime.parse(
        epgTimeA,
      ).compareTo(
        DateTime.parse(
          epgTimeB,
        ),
      );
    });

    for (final el in recordingList) {
      var epgTime = el.programStopTime;
      epgTime = '${epgTime.substring(0, 8)}T${epgTime.substring(8)}Z';

      final isFinishedRecording = DateTime.parse(
            epgTime,
          ).compareTo(now) <
          0;

      if (isFinishedRecording) {
        if (recordedPrograms
            .where(
              (element) =>
                  element.programTitle == el.programTitle &&
                  element.programStartTime == el.programStartTime &&
                  element.programStopTime == el.programStopTime,
            )
            .isEmpty) {
          recordedPrograms.add(el);
        }
      } else {
        if (upcomingPrograms
            .where(
              (element) =>
                  element.programTitle == el.programTitle &&
                  element.programStartTime == el.programStartTime &&
                  element.programStopTime == el.programStopTime,
            )
            .isEmpty) {
          upcomingPrograms.add(el);
        }
      }
    }
    recordedPrograms.sort(
      (a, b) => b.programStartTime.compareTo(a.programStartTime),
    );
    emit(
      state.copyWith(
        recordedPrograms: recordedPrograms,
        upcomingPrograms: upcomingPrograms,
        isNavigatingAlertDialog: false,
        currentAlertBoxSelected: 0,
        currentRecordedSelected: state.currentRecordedSelected == 0
            ? 0
            : state.currentRecordedSelected - 1,
        isLoading: false,
      ),
    );
  }

  void sortListByDate() {
    emit(state.copyWith(isLoading: true));
    state.recordedPrograms.sort(
      (a, b) => b.programStartTime.compareTo(a.programStartTime),
    );
    emit(
      state.copyWith(
        recordedPrograms: state.recordedPrograms,
        isLoading: false,
      ),
    );
  }

  void sortListByTime() {
    emit(state.copyWith(isLoading: true));
    state.recordedPrograms.sort(
      (a, b) => a.programStartTime
          .substring(8, 14)
          .compareTo(b.programStartTime.substring(8, 14)),
    );
    emit(
      state.copyWith(
        recordedPrograms: state.recordedPrograms,
        isLoading: false,
      ),
    );
  }

  Future<void> deleteScheduledProgram({required BuildContext context, required int index}) async {
    final recordings = state.upcomingPrograms[DeviceId.isStb ? state.currentScheduledSelected : index];
    await GetIt.I
        .get<ChopperClient>()
        .getService<DVRService>()
        .deleteRecording(
          channelTblRowId: recordings.channelTblRowId,
          epgShowId: recordings.epgShowId,
          timecode: recordings.programStartTime,
        )
        .timeout(const Duration(seconds: 45))
        .then((resp) {
      final parsedResp = resp.body!;

      if (parsedResp['RC'] == 'E-000') {
        emit(state.copyWith(isLoading: true));
        initializeCubit(context);
        NavigationService.navigatorKey.currentContext?.read<ChannelBloc>().add(const ChannelEvent.fetch());
        DvrService().fetchChannelAndProgram().whenComplete(() => emit(state.copyWith(isLoading: false)));
      } else {
        SmartDialog.showToast(
          'Error deleting show. ${parsedResp['RC']}',
          displayTime: const Duration(seconds: 10),
        );
      }
      emit(
        state.copyWith(
          isNavigatingAlertDialog: false,
          currentAlertBoxSelected: 0,
          isNavigatingSortDrawer: false,
        ),
      );
    });

  }

  void showAlertDialog() {
    emit(state.copyWith(isNavigatingAlertDialog: true));
  }

  void hideAlertDialog() {
    emit(
      state.copyWith(
        isNavigatingAlertDialog: false,
        isNavigatingSortDrawer: false,
      ),
    );
  }

  void handleKeyUp() {
    ///Record Tab Navigation
    if (state.currentTabSelected == 0) {
      if (!state.isNavigatingTabDrawer) {
        if (state.isNavigatingSortDrawer) {
          emit(state.copyWith(currentSortSelected: 1));
        } else {
          emit(
            state.copyWith(
              currentRecordedSelected: state.currentRecordedSelected - 1,
            ),
          );
          if (state.currentRecordedSelected < 0) {
            emit(
              state.copyWith(
                isNavigatingTabDrawer: true,
                currentRecordedSelected: 0,
              ),
            );
          }
        }
      }
    }

    ///Scheduled Tab Navigation
    if (state.currentTabSelected == 1) {
      if (!state.isNavigatingTabDrawer) {
        emit(
          state.copyWith(
            currentScheduledSelected: state.currentScheduledSelected - 1,
          ),
        );
        if (state.currentScheduledSelected < 0) {
          emit(
            state.copyWith(
              isNavigatingTabDrawer: true,
              currentScheduledSelected: 0,
            ),
          );
        }
      }
    }

    ///Managed Tab Navigation
    if (state.currentTabSelected == 2) {
      if (state.currentManagedSelected < 2) {
        emit(state.copyWith(isNavigatingTabDrawer: true));
        return;
      }
      emit(
        state.copyWith(
          currentManagedSelected: state.currentManagedSelected - 1,
        ),
      );
    }

    ///Search Tab Navigation
    if (state.currentTabSelected == 3) {
      if (state.isNavigatingControl) {
        emit(state.copyWith(inAlphaNumeric: true, isNavigatingControl: false));
      }
      if (state.inAlphaNumeric) {
        emit(state.copyWith(alphanumericIndex: state.alphanumericIndex - 6));
        if (state.alphanumericIndex < 0) {
          emit(state.copyWith(isNavigatingTabDrawer: true));
          return;
        }
      }
      if (state.inSearchList) {
        if (state.searchIndex < 1) {
          emit(
            state.copyWith(isNavigatingTabDrawer: true, inSearchList: false),
          );
        } else {
          emit(state.copyWith(searchIndex: state.searchIndex - 1));
        }
      }
    }
  }

  void handleKeyDown() {
    ///Record Navigation
    if (state.currentTabSelected == 0) {
      if (state.isNavigatingTabDrawer) {
        if (state.recordedPrograms.isNotEmpty) {
          emit(state.copyWith(isNavigatingTabDrawer: false));
        }
      } else {
        if (state.isNavigatingSortDrawer) {
          emit(state.copyWith(currentSortSelected: 2));
        } else {
          if (state.currentRecordedSelected >=
              state.recordedPrograms.length - 1) return;
          emit(
            state.copyWith(
              currentRecordedSelected: state.currentRecordedSelected + 1,
            ),
          );
        }
      }
    }

    ///Scheduled Tab Navigation
    if (state.currentTabSelected == 1) {
      if (state.isNavigatingTabDrawer) {
        if (state.upcomingPrograms.isNotEmpty) {
          emit(state.copyWith(isNavigatingTabDrawer: false));
        }
      } else {
        if (state.currentScheduledSelected >=
            state.upcomingPrograms.length - 1) {
          return;
        }
        emit(
          state.copyWith(
            currentScheduledSelected: state.currentScheduledSelected + 1,
          ),
        );
      }
    }

    ///Manage Tab Navigation
    if (state.currentTabSelected == 2) {
      if (state.isNavigatingTabDrawer) {
        emit(
          state.copyWith(
            isNavigatingTabDrawer: false,
            currentManagedSelected: 1,
          ),
        );
      } else {
        emit(state.copyWith(currentManagedSelected: 2));
      }
    }

    ///Search Tab Navigation
    if (state.currentTabSelected == 3) {
      if (state.isNavigatingTabDrawer) {
        if(state.inSearchList){
          emit(state.copyWith(isNavigatingTabDrawer: false));
        } else {
          emit(
            state.copyWith(
              isNavigatingTabDrawer: false,
              inAlphaNumeric: true,
              alphanumericIndex: 0,
            ),
          );
        }
      } else {
        if (state.inAlphaNumeric) {
          emit(state.copyWith(alphanumericIndex: state.alphanumericIndex + 6));
          if (state.alphanumericIndex >
              state.alphanumeric.characters.length - 1) {
            emit(
              state.copyWith(
                isNavigatingControl: true,
                inAlphaNumeric: false,
              ),
            );
          }
        }
        if (state.inSearchList) {
          if (state.searchIndex > state.searchResultList.length - 2) return;
          emit(state.copyWith(searchIndex: state.searchIndex + 1));
        }
      }
    }
  }

  void handleKeyLeft() {
    ///Tab Navigation
    if (state.isNavigatingTabDrawer) {
      if (state.currentTabSelected < 1) return;
      emit(state.copyWith(currentTabSelected: state.currentTabSelected - 1));
    }

    ///Record Tab Navigation
    if (state.currentTabSelected == 0) {
      if (state.isNavigatingSortDrawer) {
        emit(state.copyWith(isNavigatingSortDrawer: false));
      }
    }

    ///Scheduled Tab Navigation
    if (state.currentTabSelected == 1) {
      if (state.isNavigatingAlertDialog) {
        emit(state.copyWith(currentAlertBoxSelected: 0));
      }
    }

    ///Search Tab Navigation
    if (state.currentTabSelected == 3) {
      if (state.inAlphaNumeric) {
        if (state.alphanumericIndex < 1) return;
        emit(state.copyWith(alphanumericIndex: state.alphanumericIndex - 1));
      }
      if (state.isNavigatingControl) {
        if (state.controlIndex < 1) return;
        emit(state.copyWith(controlIndex: state.controlIndex - 1));
      }
      if (state.inSearchList) {
        emit(state.copyWith(inSearchList: false, inAlphaNumeric: true));
      }
    }
  }

  void handleKeyRight() {
    ///Tab Navigation
    if (state.isNavigatingTabDrawer) {
      if (state.currentTabSelected > 2) return;
      emit(state.copyWith(currentTabSelected: state.currentTabSelected + 1));
    }

    ///Record Tab Navigation
    if (state.currentTabSelected == 0) {
      if (!state.isNavigatingTabDrawer) {
        emit(state.copyWith(isNavigatingSortDrawer: true));
      }
    }

    ///Scheduled Tab Navigation
    if (state.currentTabSelected == 1) {
      if (state.isNavigatingAlertDialog) {
        emit(state.copyWith(currentAlertBoxSelected: 1));
      }
    }

    ///Search Tab Navigation
    if (state.currentTabSelected == 3) {
      if (state.inAlphaNumeric) {
        if (state.searchResultList.isEmpty) {
          if (state.alphanumericIndex >
              state.alphanumeric.characters.length - 2) return;
          emit(state.copyWith(alphanumericIndex: state.alphanumericIndex + 1));
        } else {
          switch (state.alphanumericIndex) {
            case 5:
              canNavigateToSearchList(val: state.searchResultList.isEmpty);
              break;
            case 11:
              canNavigateToSearchList(val: state.searchResultList.isEmpty);
              break;
            case 17:
              canNavigateToSearchList(val: state.searchResultList.isEmpty);
              break;
            case 23:
              canNavigateToSearchList(val: state.searchResultList.isEmpty);
              break;
            case 29:
              canNavigateToSearchList(val: state.searchResultList.isEmpty);
              break;
            case 35:
              canNavigateToSearchList(val: state.searchResultList.isEmpty);
              break;
            default:
              emit(
                state.copyWith(
                  alphanumericIndex: state.alphanumericIndex + 1,
                ),
              );
              break;
          }
        }
      }
      if (state.isNavigatingControl) {
        if (state.controlIndex > 1) return;
        emit(state.copyWith(controlIndex: state.controlIndex + 1));
      }
    }
  }

  void canNavigateToSearchList({required bool val}) {
    switch (val) {
      case true:
        break;
      case false:
        emit(
          state.copyWith(
            inSearchList: true,
            inAlphaNumeric: false,
            searchIndex: 0,
          ),
        );
        break;
    }
  }
}
