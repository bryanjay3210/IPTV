import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dvr_stream_state.dart';

class DvrStreamCubit extends Cubit<DvrStreamState> {
  DvrStreamCubit() : super(const DvrStreamState()) {
    hideControls();
  }

  void handleKeyUp() {
    if (state.controlColumn == 0) return;
    emit(
      state.copyWith(
        controlColumn: state.controlColumn - 1,
        controlRow: 0,
      ),
    );
  }

  void handleKeyDown() {
    if (state.controlColumn == 2) return;
    emit(
      state.copyWith(
        controlColumn: state.controlColumn + 1,
        controlRow: 0,
      ),
    );
  }

  void handleKeyLeft() {
    if (state.controlRow == 0) return;
    emit(
      state.copyWith(
        controlRow: state.controlRow - 1,
      ),
    );
  }

  void handleKeyRight() {
    switch (state.controlColumn) {
      case 0:
      case 1:
        if (state.controlRow == 1) return;
        emit(
          state.copyWith(
            controlRow: state.controlRow + 1,
          ),
        );
        break;
      case 2:
        if (state.controlRow == 3) return;
        emit(
          state.copyWith(
            controlRow: state.controlRow + 1,
          ),
        );
        break;
      default:
    }
  }

  void showControls() {
    emit(
      state.copyWith(
        isControlsActive: true,
      ),
    );
  }

  void hideControls() {
    emit(
      state.copyWith(
        isControlsActive: false,
      ),
    );
  }

  void toggleScrubbing() {
    emit(
      state.copyWith(
        isScrubbing: !state.isScrubbing,
      ),
    );
  }

  void toggleSelectionPage() {
    emit(
      state.copyWith(
        isSelectionPageActive: !state.isSelectionPageActive,
        isControlsActive: false,
        selectionIndex: 0,
      ),
    );
  }

  void changeSelectionIndex(int number) {
    emit(
      state.copyWith(
        selectionIndex: number,
      ),
    );
  }

  void changeControlRowForButtons(int number) {
    emit(
      state.copyWith(
        controlRow: number,
        controlColumn: 2,
      ),
    );
  }
}
