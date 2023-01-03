part of 'dvr_search_result_cubit.dart';

class DvrSearchResultState extends Equatable {
  const DvrSearchResultState({
    required this.episodeList,
    required this.isLoading,
    required this.filterBy,
    required this.inFilter,
    required this.currentIndex,
    required this.filterIndex,
    required this.inDialog,
    required this.inCancelDialog,
    required this.dialogIndex,
    required this.btnLoading,
    required this.seriesId,
    required this.cancelDialogIndex
  });

  final List<ChannelAndProgram> episodeList;
  final bool isLoading;
  final String filterBy;
  final bool inFilter;
  final int filterIndex;
  final int currentIndex;
  final bool inDialog;
  final bool inCancelDialog;
  final int dialogIndex;
  final bool btnLoading;
  final String seriesId;
  final int cancelDialogIndex;

  DvrSearchResultState copyWith({
    List<ChannelAndProgram>? episodeList,
    bool? isLoading,
    String? filterBy,
    bool? inFilter,
    int? currentIndex,
    int? filterIndex,
    bool? inDialog,
    bool? inCancelDialog,
    int? dialogIndex,
    bool? btnLoading,
    String? seriesId,
    int? cancelDialogIndex,
  }) {
    return DvrSearchResultState(
      episodeList: episodeList ?? this.episodeList,
      isLoading: isLoading ?? this.isLoading,
      filterBy: filterBy ?? this.filterBy,
      inFilter: inFilter ?? this.inFilter,
      currentIndex: currentIndex ?? this.currentIndex,
      filterIndex: filterIndex ?? this.filterIndex,
      inDialog: inDialog ?? this.inDialog,
      inCancelDialog: inCancelDialog ?? this.inCancelDialog,
      dialogIndex: dialogIndex ?? this.dialogIndex,
      btnLoading: btnLoading ?? this.btnLoading,
      seriesId: seriesId ?? this.seriesId,
      cancelDialogIndex: cancelDialogIndex ?? this.cancelDialogIndex,
    );
  }

  @override
  List<Object?> get props => [
    episodeList,
    isLoading,
    filterBy,
    inFilter,
    currentIndex,
    filterIndex,
    inDialog,
    inCancelDialog,
    dialogIndex,
    btnLoading,
    seriesId,
    cancelDialogIndex,
  ];
}
