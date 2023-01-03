import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dvr_movie_state.dart';

class DvrMovieCubit extends Cubit<DvrMovieState> {
  DvrMovieCubit()
      : super(
          const DvrMovieState(
            isNavigatingDrawer: true,
            indexSelectedDrawer: 1,
          ),
        ) {
    emit(
      state.copyWith(
        isNavigatingDrawer: true,
        indexSelectedDrawer: 1,
      ),
    );
  }

  void addIndex(){
    emit(state.copyWith(indexSelectedDrawer: state.indexSelectedDrawer + 2));
    return;
  }

  void subIndex(){
    emit(state.copyWith(indexSelectedDrawer: state.indexSelectedDrawer - 1));
    return;
  }

  void handleKeyUp() {
    if (state.isNavigatingDrawer) {
      if (state.indexSelectedDrawer == 1) return;
      emit(state.copyWith(indexSelectedDrawer: state.indexSelectedDrawer - 1));
    }
  }

  void handleKeyDown() {
    if (state.isNavigatingDrawer) {
      if (state.indexSelectedDrawer > 3) return;
      emit(state.copyWith(indexSelectedDrawer: state.indexSelectedDrawer + 1));
    }
  }

  void handleKeyLeft() {
    emit(state.copyWith(isNavigatingDrawer: true, indexSelectedDrawer: 1));
  }

  void handleKeyRight() {
    emit(state.copyWith(isNavigatingDrawer: false));
  }
}
