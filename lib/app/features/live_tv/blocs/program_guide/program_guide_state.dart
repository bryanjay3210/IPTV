part of 'program_guide_cubit.dart';

class ProgramGuideState extends Equatable {
  const ProgramGuideState({
    required this.currentIndex,
    required this.isNavigatingDialog,
  });

  final int currentIndex;
  final bool isNavigatingDialog;

  ProgramGuideState copyWith({
    int? currentIndex,
    bool? isNavigatingDialog,
  }) {
    return ProgramGuideState(
      currentIndex: currentIndex ?? this.currentIndex,
      isNavigatingDialog: isNavigatingDialog ?? this.isNavigatingDialog,
    );
  }

  @override
  List<Object?> get props => [
        currentIndex,
        isNavigatingDialog,
      ];
}
