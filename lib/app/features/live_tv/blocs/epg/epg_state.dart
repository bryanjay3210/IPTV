part of 'epg_cubit.dart';

class EpgState extends Equatable {
  const EpgState({
    this.currChanSel = 0,
    this.currProgSel = 0,
    this.cachedNavigationDates = const [],
    this.isInfoSheet = false,
    this.goLiveSelected = false,
    this.recordSelected = false,
    this.seriesSelected = false,
    this.stopSelected = false,
    this.horizontalPaginationIndex = 0,
    this.isPaginationLoading = false,
    this.channels = const [],
  });

  final int currChanSel;
  final int currProgSel;
  final List<DateTime> cachedNavigationDates;
  final bool isInfoSheet;
  final bool goLiveSelected;
  final bool recordSelected;
  final bool seriesSelected;
  final bool stopSelected;
  final int horizontalPaginationIndex;
  final bool isPaginationLoading;
  final List<Channel> channels;

  EpgState copyWith({
    int? currChanSel,
    int? currProgSel,
    List<DateTime>? cachedNavigationDates,
    bool? isInfoSheet,
    bool? goLiveSelected,
    bool? recordSelected,
    bool? seriesSelected,
    bool? stopSelected,
    int? horizontalPaginationIndex,
    bool? isPaginationLoading,
    List<Channel>? channels,
  }) {
    return EpgState(
      currChanSel: currChanSel ?? this.currChanSel,
      currProgSel: currProgSel ?? this.currProgSel,
      cachedNavigationDates:
          cachedNavigationDates ?? this.cachedNavigationDates,
      isInfoSheet: isInfoSheet ?? this.isInfoSheet,
      goLiveSelected: goLiveSelected ?? this.goLiveSelected,
      recordSelected: recordSelected ?? this.recordSelected,
      seriesSelected: seriesSelected ?? this.seriesSelected,
      stopSelected: stopSelected ?? this.stopSelected,
      horizontalPaginationIndex:
          horizontalPaginationIndex ?? this.horizontalPaginationIndex,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
      channels: channels ?? this.channels,
    );
  }

  @override
  List<Object?> get props => [
        currChanSel,
        currProgSel,
        cachedNavigationDates,
        isInfoSheet,
        goLiveSelected,
        recordSelected,
        seriesSelected,
        stopSelected,
        horizontalPaginationIndex,
        isPaginationLoading,
      ];
}
