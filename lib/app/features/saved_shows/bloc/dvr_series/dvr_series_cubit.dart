import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dvr_series_state.dart';

class DvrSeriesCubit extends Cubit<DvrSeriesState> {
  DvrSeriesCubit()
      : super(
          const DvrSeriesState(
            isNavigatingDrawer: true,
            indexSelectedDrawer: 1,
            indexSelectedEpisode: 0,
            indexSelectedSeason: 0,
            isNavigatingComboBox: false,
          ),
        ) {
    emit(
      state.copyWith(
        isNavigatingDrawer: true,
        indexSelectedDrawer: 1,
        indexSelectedSeason: 0,
        indexSelectedEpisode: 0,
        isNavigatingComboBox: false,
      ),
    );
  }

  void handleKeyUp() {
    if (state.isNavigatingDrawer) {
      if (state.indexSelectedDrawer < 1) return;
      emit(state.copyWith(indexSelectedDrawer: state.indexSelectedDrawer - 1));
    }

    if (!state.isNavigatingDrawer) {
      if (state.indexSelectedSeason < 1 && state.indexSelectedEpisode < 0) {
        return;
      }
      if (state.indexSelectedEpisode < 1) {
        if (state.indexSelectedSeason < 1) {
          emit(state.copyWith(indexSelectedEpisode: -1));
          return;
        }
        emit(
          state.copyWith(
            indexSelectedSeason: state.indexSelectedSeason - 1,
            indexSelectedEpisode: 9,
          ),
        );
      } else {
        emit(
          state.copyWith(
            indexSelectedEpisode: state.indexSelectedEpisode - 1,
          ),
        );
      }
    }
  }

  void handleKeyDown() {
    if (state.isNavigatingDrawer) {
      if (state.indexSelectedDrawer > 2) return;
      emit(state.copyWith(indexSelectedDrawer: state.indexSelectedDrawer + 1));
    }

    if (!state.isNavigatingDrawer) {
      if (state.indexSelectedSeason > 8) return;
      if (state.indexSelectedEpisode > 8) {
        emit(
          state.copyWith(
            indexSelectedSeason: state.indexSelectedSeason + 1,
            indexSelectedEpisode: 0,
          ),
        );
      } else {
        emit(
          state.copyWith(
            indexSelectedEpisode: state.indexSelectedEpisode + 1,
          ),
        );
      }
    }
  }

  void handleKeyLeft() {
    emit(state.copyWith(isNavigatingDrawer: true, isNavigatingComboBox: false));
  }

  void handleKeyRight() {
    emit(
      state.copyWith(
        isNavigatingDrawer: false,
        isNavigatingComboBox: true,
        indexSelectedEpisode: -1,
      ),
    );
  }
}
