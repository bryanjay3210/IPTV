import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_menu/dvr_menu_cubit.dart';
import 'package:iptv/core/api_service/dvr_service.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/models/recording.dart';
import 'package:provider/provider.dart';

part 'dvr_detete_shows_state.dart';

class DvrDeleteShowsCubit extends Cubit<DvrDeleteShowsState> {
  DvrDeleteShowsCubit()
      : super(
          const DvrDeleteShowsState(
            indexSelected: -1,
            recordedPrograms: [],
            currentTab: 0,
            isNavigatingTab: true,
            isCheckAll: false,
            checkboxList: [],
            isLoading: false,
          ),
        ) {
    initializeCubit();
  }

  List<String> errorMessage = [];
  String programTitle = '';

  Future<void> initializeCubit() async {
    emit(state.copyWith(isLoading: true));
    final now = DateTime.now();

    final resp = await GetIt.I
        .get<ChopperClient>()
        .getService<DVRService>()
        .getRecordingList()
        .timeout(const Duration(seconds: 45));
    final parsedResp = resp.body!;
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
        recordedPrograms.add(el);
      } else {
        upcomingPrograms.add(el);
      }
    }

    final checkBoxList = <bool>[];

    for (var i = 0; i < recordedPrograms.length; i++) {
      checkBoxList.add(false);
    }

    emit(
      state.copyWith(
        indexSelected: 0,
        recordedPrograms: recordedPrograms,
        checkboxList: checkBoxList,
        isCheckAll: false,
        isLoading: false,
      ),
    );
  }

  Future<void> handleSelectKey(BuildContext context) async {
    errorMessage = [];
    programTitle = '';
    if (state.currentTab == 0 && state.isNavigatingTab) {
      selectUnselectAll();
    }
    if (state.currentTab == 1 && state.isNavigatingTab) {
     await handleDeleteFunc(context);
    }
    if (!state.isNavigatingTab) {
     selectItem(index: 0);
    }
  }

  Future<void> handleDeleteFunc(BuildContext context) async {
    final cblIndices = [];
    for (var i = 0; i < state.checkboxList!.length; i++) {
      if (state.checkboxList![i] == true) {
        cblIndices.add(i);
      }
    }
    final deleteProgramsList = <Future<dynamic>>[];
    for (var i = 0; i < cblIndices.length; i++) {
      final myIndex = cblIndices[i].toString();
      final recording = state.recordedPrograms[int.parse(myIndex)];
      deleteProgramsList
          .add(deleteProgram(context, recording, cblIndices.length));
    }
    unawaited(SmartDialog.showLoading());
    await Future.wait(deleteProgramsList);
    await initializeCubit();
    unawaited(SmartDialog.dismiss());
    if (errorMessage.isNotEmpty && state.isCheckAll) {
      await SmartDialog.showToast(
        'There was a problem deleting all selected programs',
        displayTime: const Duration(seconds: 10),
      );
    }
    if (errorMessage.isNotEmpty && cblIndices.length == 1) {
      await SmartDialog.showToast(
        'There was a problem deleting $programTitle $errorMessage',
        displayTime: const Duration(seconds: 10),
      );
    }
    if (errorMessage.length > 1 && !state.isCheckAll) {
      await SmartDialog.showToast(
        'There was a problem deleting some of the selected programs $errorMessage',
        builder: (_) => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(1),
                ),
                child: Text(
                  'There was a problem deleting some of the selected programs $errorMessage',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        displayTime: const Duration(seconds: 10),
      );
    }
    await context.read<DvrMenuCubit>().initializeCubit(context);
  }

  void selectItem({required int index}){
    final currentValue = state.checkboxList![DeviceId.isStb ? state.indexSelected : index];
    state.checkboxList![DeviceId.isStb ? state.indexSelected : index] = !currentValue;
    final list = state.checkboxList;
    emit(state.copyWith(checkboxList: list));
    if(state.checkboxList!.where((element) => element == false).isEmpty){
      emit(state.copyWith(isCheckAll: true));
    }
  }
  void selectUnselectAll(){
    for (var i = 0; i < state.recordedPrograms.length; i++) {
      state.checkboxList![i] = !state.isCheckAll;
    }
    final list = state.checkboxList;
    emit(state.copyWith(checkboxList: list, isCheckAll: !state.isCheckAll));
  }

  void allIsNotSelected({
    required bool isChecked,
  }) {
    emit(state.copyWith(isCheckAll: isChecked));
  }

  Future<dynamic> deleteProgram(
    BuildContext context,
    Recording recordings,
    int count,
  ) async {
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
      if (!parsedResp['RC'].toString().contains('E-000')) {
        if (count == 1) {
          programTitle = recordings.programTitle;
          errorMessage.add(parsedResp['RC'].toString());
        } else {
          errorMessage.add(parsedResp['RC'].toString());
        }
      }
      return parsedResp;
    });
  }

  void handleKeyUp() {
    if (state.indexSelected == 0) {
      emit(state.copyWith(isNavigatingTab: true, currentTab: 0));
    }

    if (state.indexSelected < 1) return;
    emit(state.copyWith(indexSelected: state.indexSelected - 1));
  }

  void handleKeyDown() {
    if (!state.isNavigatingTab) {
      if (state.indexSelected == state.recordedPrograms.length - 1) return;
      emit(state.copyWith(indexSelected: state.indexSelected + 1));
    }
    emit(state.copyWith(isNavigatingTab: false));
  }

  void handleKeyRight() {
    final hasSelected =
        state.checkboxList!.where((element) => element == true).isEmpty;
    if (state.isNavigatingTab) {
      if (state.currentTab == 1) {
        return;
      }
      if (hasSelected) {
        return;
      }
      emit(state.copyWith(currentTab: state.currentTab + 1));
    }
  }

  void handleKeyLeft() {
    if (state.isNavigatingTab) {
      if (state.currentTab == 0) {
        return;
      }
      emit(state.copyWith(currentTab: state.currentTab - 1));
    }
  }
}
