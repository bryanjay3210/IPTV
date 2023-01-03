import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'program_guide_state.dart';

class ProgramGuideCubit extends Cubit<ProgramGuideState> {
  ProgramGuideCubit()
      : super(
          const ProgramGuideState(
            currentIndex: 0,
            isNavigatingDialog: false,
          ),
        );

  void navigateLeftAlertDialog() {
    if (!state.isNavigatingDialog) return;

    if (state.currentIndex == 0) {
      return;
    }
    emit(
      state.copyWith(
        currentIndex: state.currentIndex - 1,
      ),
    );
  }

  void navigateRightAlertDialog() {
    if (!state.isNavigatingDialog) return;

    if (state.currentIndex == 2) {
      return;
    }
    emit(
      state.copyWith(
        currentIndex: state.currentIndex + 1,
      ),
    );
  }
}
