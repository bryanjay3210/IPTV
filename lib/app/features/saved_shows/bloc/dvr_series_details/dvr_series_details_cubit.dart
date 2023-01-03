import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_menu/dvr_menu_cubit.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_series_manager/dvr_series_manager_cubit.dart';
import 'package:iptv/app/home/bloc/channel_bloc.dart';
import 'package:iptv/core/api_service/dvr_service.dart';
import 'package:iptv/core/api_service/settings_service.dart';

part 'dvr_series_details_state.dart';

class DvrSeriesDetailsCubit extends Cubit<DvrSeriesDetailsState> {
  DvrSeriesDetailsCubit()
      : super(
          const DvrSeriesDetailsState(
            columnIndexSelected: 0,
            rowIndexSelected: 0,
            recordSettingsValue: 'Y',
            keepUntilSettingsValue: '1',
            isLoading: false,
          ),
        );

  void initializeCubit() {
    emit(
      state.copyWith(
        columnIndexSelected: 0,
        rowIndexSelected: 0,
        recordSettingsValue: 'Y',
        keepUntilSettingsValue: '1',
        isLoading: false,
      ),
    );
  }

  Future<void> fetchSettings(BuildContext context, String seriesId) async {
    final resp = await GetIt.I<ChopperClient>()
        .getService<SettingsService>()
        .getSeriesSettings(seriesId: seriesId)
        .timeout(const Duration(seconds: 45));
    final parsedResp = resp.body!;
    if (parsedResp.containsKey('OnlyNew') &&
        parsedResp.containsKey('KeepUntil')) {
      emit(
        state.copyWith(
          columnIndexSelected: 0,
          rowIndexSelected: 0,
          recordSettingsValue: parsedResp['OnlyNew'].toString(),
          keepUntilSettingsValue: parsedResp['KeepUntil'].toString(),
          isLoading: false,
        ),
      );
    }
  }

  void changeRecordSettings(String value) {
    emit(state.copyWith(recordSettingsValue: value));
  }

  void changeKeepUntilSettings(String value) {
    emit(state.copyWith(keepUntilSettingsValue: value));
  }

  Future<void> handleKeySelect(BuildContext context, String seriesId) async {
    if (state.rowIndexSelected == 0 && state.columnIndexSelected == 0) {
      await saveSettings(context, seriesId);
    } else if (state.rowIndexSelected == 1 && state.columnIndexSelected == 0) {
      context
          .read<DvrSeriesManagerCubit>()
          .isOnSettingsChangeValue(value: false);
      Navigator.of(context).pop();
    } else if (state.rowIndexSelected == 0 && state.columnIndexSelected == 1) {
      emit(state.copyWith(recordSettingsValue: 'Y'));
    } else if (state.rowIndexSelected == 1 && state.columnIndexSelected == 1) {
      emit(state.copyWith(recordSettingsValue: 'N'));
    } else if (state.rowIndexSelected == 0 && state.columnIndexSelected == 2) {
      emit(state.copyWith(keepUntilSettingsValue: '1'));
    } else if (state.rowIndexSelected == 1 && state.columnIndexSelected == 2) {
      emit(state.copyWith(keepUntilSettingsValue: '2'));
    } else if (state.columnIndexSelected == 3) {
      await cancelSeries(context, seriesId);
      await context.read<DvrMenuCubit>().initializeCubit(context);
    }
  }

  Future<void> cancelSeries(BuildContext context, String seriesId) async {
    emit(state.copyWith(isLoading: true));
    await GetIt.I<ChopperClient>()
        .getService<DVRService>()
        .stopRecordingSeries(
          epgSeriesId: seriesId,
        )
        .then((value) {
      Navigator.of(context).pop();

      context.read<DvrSeriesManagerCubit>().reloadList(context);

      context
          .read<ChannelBloc>()
          .add(ChannelEvent.updateProgramRecordStatus(epgSeriesId: seriesId));
    });
    emit(state.copyWith(isLoading: false));
  }

  Future<void> saveSettings(BuildContext context, String seriesId) async {
    await GetIt.I<ChopperClient>()
        .getService<SettingsService>()
        .setSeriesSettings(
          series: seriesId,
          onlyNew: state.recordSettingsValue,
          keepUntil: state.keepUntilSettingsValue,
        )
        .timeout(const Duration(seconds: 45))
        .then((value) {
      Navigator.of(context).pop();
      context
          .read<DvrSeriesManagerCubit>()
          .isOnSettingsChangeValue(value: false);
    });
  }

  void handleKeyUp() {
    if (state.columnIndexSelected == 0) return;
    emit(state.copyWith(columnIndexSelected: state.columnIndexSelected - 1));
  }

  void handleKeyDown() {
    if (state.columnIndexSelected == 3) return;
    emit(state.copyWith(columnIndexSelected: state.columnIndexSelected + 1));
  }

  void handleKeyLeft() {
    if (state.rowIndexSelected == 0) return;
    emit(state.copyWith(rowIndexSelected: state.rowIndexSelected - 1));
  }

  void handleKeyRight() {
    if (state.rowIndexSelected == 1) return;
    emit(state.copyWith(rowIndexSelected: state.rowIndexSelected + 1));
  }
}
