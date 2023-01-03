part of 'dvr_detete_shows_cubit.dart';

class DvrDeleteShowsState extends Equatable {
  const DvrDeleteShowsState({
    required this.indexSelected,
    required this.recordedPrograms,
    required this.isNavigatingTab,
    required this.currentTab,
    required this.isCheckAll,
    required this.checkboxList,
    required this.isLoading,
  });
  final int indexSelected;
  final List<Recording> recordedPrograms;
  final bool isNavigatingTab;
  final int currentTab;
  final bool isCheckAll;
  final List<bool>? checkboxList;
  final bool isLoading;

  DvrDeleteShowsState copyWith({
    int? indexSelected,
    List<Recording>? recordedPrograms,
    bool? isNavigatingTab,
    int? currentTab,
    bool? isCheckAll,
    List<bool>? checkboxList,
    bool? isLoading,
  }) {
    return DvrDeleteShowsState(
      indexSelected: indexSelected ?? this.indexSelected,
      recordedPrograms: recordedPrograms ?? this.recordedPrograms,
      isNavigatingTab: isNavigatingTab ?? this.isNavigatingTab,
      currentTab: currentTab ?? this.currentTab,
      isCheckAll: isCheckAll ?? this.isCheckAll,
      checkboxList: checkboxList ?? this.checkboxList,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        indexSelected,
        recordedPrograms,
        isNavigatingTab,
        currentTab,
        isCheckAll,
        checkboxList,
        isLoading,
      ];
}
