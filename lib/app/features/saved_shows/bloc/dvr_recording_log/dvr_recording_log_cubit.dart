import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dvr_recording_log_state.dart';

class DvrRecordingLogCubit extends Cubit<DvrRecordingLogState> {
  DvrRecordingLogCubit()
      : super(
          const DvrRecordingLogState(
            isNavigatingDrawer: false,
            indexSelected: 0,
          ),
        ) {
    emit(
      state.copyWith(
        isNavigatingDrawer: false,
        indexSelected: 0,
      ),
    );
  }

  void handleKeyUp() {
    if (!state.isNavigatingDrawer) {
      if (state.indexSelected < 1) return;
      emit(state.copyWith(indexSelected: state.indexSelected - 1));
    }
  }

  void handleKeyDown() {
    if (!state.isNavigatingDrawer) {
      if (state.indexSelected > 8) return;
      emit(state.copyWith(indexSelected: state.indexSelected + 1));
    }
  }

  void handleKeyLeft() {
    emit(state.copyWith(isNavigatingDrawer: false));
  }

  void handleKeyRight() {
    emit(state.copyWith(isNavigatingDrawer: true));
  }
}
