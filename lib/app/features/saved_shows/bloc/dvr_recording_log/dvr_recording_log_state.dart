part of 'dvr_recording_log_cubit.dart';

class DvrRecordingLogState extends Equatable {
  const DvrRecordingLogState({
    required this.isNavigatingDrawer,
    required this.indexSelected,
  });

  final bool isNavigatingDrawer;
  final int indexSelected;

  DvrRecordingLogState copyWith({
    bool? isNavigatingDrawer,
    int? indexSelected,
  }) {
    return DvrRecordingLogState(
      isNavigatingDrawer: isNavigatingDrawer ?? this.isNavigatingDrawer,
      indexSelected: indexSelected ?? this.indexSelected,
    );
  }

  @override
  List<Object?> get props => [
        isNavigatingDrawer,
        indexSelected,
      ];
}
