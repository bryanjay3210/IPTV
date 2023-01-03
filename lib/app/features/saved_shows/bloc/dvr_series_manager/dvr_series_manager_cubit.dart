import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:iptv/core/api_service/dvr_service.dart';
import 'package:iptv/core/models/series_recording.dart';

part 'dvr_series_manager_state.dart';

class DvrSeriesManagerCubit extends Cubit<DvrSeriesManagerState> {
  DvrSeriesManagerCubit()
      : super(
          const DvrSeriesManagerState(
            isNavigatingTabDrawer: false,
            currentSelected: 0,
            currentMenuSelected: 0,
            recordedSeries: [],
            isLoading: false,
            isOnSettings: false,
          ),
        );

  Future<void> initializeCubit(BuildContext context) async {
    emit(
      state.copyWith(
        isLoading: true,
        recordedSeries: [],
        isOnSettings: false,
      ),
    );

    final resp = await GetIt.I
        .get<ChopperClient>()
        .getService<DVRService>()
        .getSeriesRecordingList()
        .timeout(const Duration(seconds: 45));
    final parsedResp = resp.body!;
    var uniqueRecordedSeries = <SeriesRecording>[];
    try {
      final recordedSeries = <SeriesRecording>[];
      final seriesList = parsedResp['Series'] as List<dynamic>;
      for (final element in seriesList) {
        try {
          recordedSeries
              .add(SeriesRecording.fromJson(element as Map<String, dynamic>));
        } catch (e) {
          final name = element['Name'];
          final episode = element['Episodes'] as List<dynamic>;
          for (final ep in episode) {
            recordedSeries.add(
              SeriesRecording(
                name: name.toString(),
                episode: ep as Map<String, dynamic>,
              ),
            );
          }
        }
      }
      final seen = <String>{};
      uniqueRecordedSeries = recordedSeries
          .where((recordedSeries) => seen.add(recordedSeries.name))
          .toList();
    } catch (e) {
      emit(state.copyWith(isLoading: false, recordedSeries: []));
    }

    emit(
      state.copyWith(
        isNavigatingTabDrawer: false,
        currentSelected: 0,
        currentMenuSelected: 0,
        recordedSeries: uniqueRecordedSeries,
        isLoading: false,
      ),
    );
  }

  Future<void> reloadList(BuildContext context) async {
    emit(
      state.copyWith(
        isLoading: true,
        recordedSeries: [],
        isOnSettings: false,
      ),
    );

    final resp = await GetIt.I
        .get<ChopperClient>()
        .getService<DVRService>()
        .getSeriesRecordingList()
        .timeout(const Duration(seconds: 45));
    final parsedResp = resp.body!;
    var uniqueRecordedSeries = <SeriesRecording>[];
    try {
      final recordedSeries = <SeriesRecording>[];
      final seriesList = parsedResp['Series'] as List<dynamic>;
      for (final element in seriesList) {
        try {
          recordedSeries
              .add(SeriesRecording.fromJson(element as Map<String, dynamic>));
        } catch (e) {
          final name = element['Name'];
          final episode = element['Episodes'] as List<dynamic>;
          for (final ep in episode) {
            recordedSeries.add(
              SeriesRecording(
                name: name.toString(),
                episode: ep as Map<String, dynamic>,
              ),
            );
          }
        }
      }
      final seen = <String>{};
      uniqueRecordedSeries = recordedSeries
          .where((recordedSeries) => seen.add(recordedSeries.name))
          .toList();
    } catch (e) {
      emit(state.copyWith(isLoading: false, recordedSeries: []));
    }

    emit(
      state.copyWith(
        isNavigatingTabDrawer: false,
        currentSelected: 0,
        currentMenuSelected: 0,
        recordedSeries: uniqueRecordedSeries,
        isLoading: false,
      ),
    );
  }

  void isOnSettingsChangeValue({
    required bool value,
  }) {
    emit(state.copyWith(isOnSettings: value));
  }

  void handleKeyUp() {
    if (state.isNavigatingTabDrawer) {
      if (state.currentMenuSelected < 0) return;
      emit(state.copyWith(currentMenuSelected: state.currentMenuSelected - 1));
    } else {
      if (state.currentSelected < 1) return;
      emit(state.copyWith(currentSelected: state.currentSelected - 1));
    }
  }

  void handleKeyDown() {
    if (state.isNavigatingTabDrawer) {
      if (state.currentMenuSelected > 2) return;
      emit(state.copyWith(currentMenuSelected: state.currentMenuSelected + 1));
    } else {
      if (state.currentSelected >= state.recordedSeries.length - 1) return;
      emit(state.copyWith(currentSelected: state.currentSelected + 1));
    }
  }

  void handleKeyLeft() {
    emit(
      state.copyWith(
        isNavigatingTabDrawer: false,
      ),
    );
  }

  void handleKeyRight() {
    emit(
      state.copyWith(
        isNavigatingTabDrawer: true,
      ),
    );
  }
}
