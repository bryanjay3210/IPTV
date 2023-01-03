part of 'dvr_series_manager_cubit.dart';

class DvrSeriesManagerState extends Equatable {
  const DvrSeriesManagerState({
    required this.isNavigatingTabDrawer,
    required this.currentSelected,
    required this.currentMenuSelected,
    required this.recordedSeries,
    required this.isLoading,
    required this.isOnSettings,
  });

  final bool isNavigatingTabDrawer;
  final int currentSelected;
  final int currentMenuSelected;
  final List<SeriesRecording> recordedSeries;
  final bool isLoading;
  final bool isOnSettings;

  DvrSeriesManagerState copyWith({
    bool? isNavigatingTabDrawer,
    int? currentSelected,
    int? currentMenuSelected,
    List<SeriesRecording>? recordedSeries,
    bool? isLoading,
    bool? isOnSettings,
  }){
    return DvrSeriesManagerState(
      isNavigatingTabDrawer: isNavigatingTabDrawer ?? this.isNavigatingTabDrawer,
      currentSelected: currentSelected ?? this.currentSelected,
      currentMenuSelected: currentMenuSelected ?? this.currentMenuSelected,
      recordedSeries: recordedSeries ?? this.recordedSeries,
      isLoading: isLoading ?? this.isLoading,
      isOnSettings: isOnSettings ?? this.isOnSettings,
    );
  }

  @override
  List<Object?> get props => [
    isNavigatingTabDrawer,
    currentSelected,
    currentMenuSelected,
    recordedSeries,
    isLoading,
    isOnSettings,
  ];
}
