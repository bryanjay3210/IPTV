part of 'dvr_movie_cubit.dart';

class DvrMovieState extends Equatable {
  const DvrMovieState({
    required this.isNavigatingDrawer,
    required this.indexSelectedDrawer,
  });

  final bool isNavigatingDrawer;
  final int indexSelectedDrawer;

  DvrMovieState copyWith({
    bool? isNavigatingDrawer,
    int? indexSelectedDrawer,
  }) {
    return DvrMovieState(
      isNavigatingDrawer: isNavigatingDrawer ?? this.isNavigatingDrawer,
      indexSelectedDrawer: indexSelectedDrawer ?? this.indexSelectedDrawer,
    );
  }

  @override
  List<Object?> get props => [
        isNavigatingDrawer,
        indexSelectedDrawer,
      ];
}
