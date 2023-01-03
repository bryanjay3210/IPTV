part of 'dvr_stream_cubit.dart';

class DvrStreamState extends Equatable {
  const DvrStreamState({
    this.isControlsActive = false,
    this.controlColumn = 0,
    this.controlRow = 0,
    this.isScrubbing = false,
    this.isSelectionPageActive = false,
    this.selectionIndex = 0,
  });

  final bool isControlsActive;
  final int controlColumn;
  final int controlRow;
  final bool isScrubbing;
  final bool isSelectionPageActive;
  final int selectionIndex;

  DvrStreamState copyWith({
    bool? isControlsActive,
    int? controlColumn,
    int? controlRow,
    bool? isScrubbing,
    bool? isSelectionPageActive,
    int? selectionIndex,
  }) {
    return DvrStreamState(
      isControlsActive: isControlsActive ?? this.isControlsActive,
      controlColumn: controlColumn ?? this.controlColumn,
      controlRow: controlRow ?? this.controlRow,
      isScrubbing: isScrubbing ?? this.isScrubbing,
      isSelectionPageActive:
          isSelectionPageActive ?? this.isSelectionPageActive,
      selectionIndex: selectionIndex ?? this.selectionIndex,
    );
  }

  @override
  List<Object?> get props => [
        isControlsActive,
        controlColumn,
        controlRow,
        isScrubbing,
        isSelectionPageActive,
        selectionIndex,
      ];
}
