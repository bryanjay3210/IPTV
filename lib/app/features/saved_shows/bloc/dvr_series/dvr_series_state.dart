part of 'dvr_series_cubit.dart';

class DvrSeriesState extends Equatable {
  const DvrSeriesState({
    required this.isNavigatingDrawer,
    required this.indexSelectedDrawer,
    required this.indexSelectedSeason,
    required this.indexSelectedEpisode,
    required this.isNavigatingComboBox,
  });

  final bool isNavigatingDrawer;
  final int indexSelectedDrawer;
  final int indexSelectedSeason;
  final int indexSelectedEpisode;
  final bool isNavigatingComboBox;

  DvrSeriesState copyWith({
    bool? isNavigatingDrawer,
    int? indexSelectedDrawer,
    int? indexSelectedSeason,
    int? indexSelectedEpisode,
    bool? isNavigatingComboBox,
  }) {
    return DvrSeriesState(
      isNavigatingDrawer: isNavigatingDrawer ?? this.isNavigatingDrawer,
      indexSelectedDrawer: indexSelectedDrawer ?? this.indexSelectedDrawer,
      indexSelectedSeason: indexSelectedSeason ?? this.indexSelectedSeason,
      indexSelectedEpisode: indexSelectedEpisode ?? this.indexSelectedEpisode,
      isNavigatingComboBox: isNavigatingComboBox ?? this.isNavigatingComboBox,
    );
  }

  @override
  List<Object?> get props => [
        isNavigatingDrawer,
        indexSelectedDrawer,
        indexSelectedSeason,
        indexSelectedEpisode,
        isNavigatingComboBox,
      ];
}
