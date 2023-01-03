part of 'dvr_menu_cubit.dart';

class DvrMenuState extends Equatable {
  const DvrMenuState({
    required this.isNavigatingTabDrawer,
    required this.currentRecordedSelected,
    required this.currentTabSelected,
    required this.tab,
    required this.recorded,
    required this.currentSortSelected,
    required this.isNavigatingSortDrawer,
    required this.currentManagedSelected,
    required this.isNavigatingManagedMenu,
    required this.currentScheduledSelected,
    required this.recordedPrograms,
    required this.upcomingPrograms,
    required this.isNavigatingAlertDialog,
    required this.currentAlertBoxSelected,
    required this.isLoading,
    required this.alphanumeric,
    required this.alphanumericIndex,
    required this.isNavigatingControl,
    required this.controlIndex,
    required this.textSearch,
    required this.isSearchLoading,
    required this.searchResultList,
    required this.channelAndProgramList,
    required this.inSearchList,
    required this.searchIndex,
    required this.inAlphaNumeric,
  });

  final bool isNavigatingTabDrawer;
  final int currentRecordedSelected;
  final int currentTabSelected;
  final List<dynamic> tab;
  final List<dynamic> recorded;
  final int currentSortSelected;
  final bool isNavigatingSortDrawer;
  final int currentManagedSelected;
  final bool isNavigatingManagedMenu;
  final int currentScheduledSelected;
  final String alphanumeric;
  final int alphanumericIndex;
  final bool isNavigatingControl;
  final int controlIndex;
  final String textSearch;
  final bool isSearchLoading;
  final List<ChannelAndProgram> searchResultList;
  final List<ChannelAndProgram> channelAndProgramList;
  final bool inAlphaNumeric;

  final List<Recording> recordedPrograms;
  final List<Recording> upcomingPrograms;
  final bool isNavigatingAlertDialog;
  final int currentAlertBoxSelected;
  final bool isLoading;
  final bool inSearchList;
  final int searchIndex;

  DvrMenuState copyWith({
    bool? isNavigatingTabDrawer,
    int? currentRecordedSelected,
    int? currentTabSelected,
    List<dynamic>? tab,
    List<dynamic>? recorded,
    int? currentSortSelected,
    bool? isNavigatingSortDrawer,
    int? currentManagedSelected,
    bool? isNavigatingManagedMenu,
    int? currentScheduledSelected,
    List<Recording>? recordedPrograms,
    List<Recording>? upcomingPrograms,
    bool? isNavigatingAlertDialog,
    int? currentAlertBoxSelected,
    bool? isLoading,
    String? alphanumeric,
    int? alphanumericIndex,
    bool? isNavigatingControl,
    int? controlIndex,
    String? textSearch,
    bool? isSearchLoading,
    List<ChannelAndProgram>? searchResultList,
    List<ChannelAndProgram>? channelAndProgramList,
    bool? inSearchList,
    int? searchIndex,
    bool? inAlphaNumeric,
  }) {
    return DvrMenuState(
      isNavigatingTabDrawer:
          isNavigatingTabDrawer ?? this.isNavigatingTabDrawer,
      currentRecordedSelected:
          currentRecordedSelected ?? this.currentRecordedSelected,
      currentTabSelected: currentTabSelected ?? this.currentTabSelected,
      tab: tab ?? this.tab,
      recorded: recorded ?? this.recorded,
      currentSortSelected: currentSortSelected ?? this.currentSortSelected,
      isNavigatingSortDrawer:
          isNavigatingSortDrawer ?? this.isNavigatingSortDrawer,
      currentManagedSelected:
          currentManagedSelected ?? this.currentManagedSelected,
      isNavigatingManagedMenu:
          isNavigatingManagedMenu ?? this.isNavigatingManagedMenu,
      currentScheduledSelected:
          currentScheduledSelected ?? this.currentScheduledSelected,
      recordedPrograms: recordedPrograms ?? this.recordedPrograms,
      upcomingPrograms: upcomingPrograms ?? this.upcomingPrograms,
      isNavigatingAlertDialog:
          isNavigatingAlertDialog ?? this.isNavigatingAlertDialog,
      currentAlertBoxSelected:
          currentAlertBoxSelected ?? this.currentAlertBoxSelected,
      isLoading: isLoading ?? this.isLoading,
      alphanumeric: alphanumeric ?? this.alphanumeric,
      alphanumericIndex: alphanumericIndex ?? this.alphanumericIndex,
      isNavigatingControl: isNavigatingControl ?? this.isNavigatingControl,
      controlIndex: controlIndex ?? this.controlIndex,
      textSearch: textSearch ?? this.textSearch,
      isSearchLoading: isSearchLoading ?? this.isSearchLoading,
      searchResultList: searchResultList ?? this.searchResultList,
      channelAndProgramList:
          channelAndProgramList ?? this.channelAndProgramList,
      inSearchList: inSearchList ?? this.inSearchList,
      searchIndex: searchIndex ?? this.searchIndex,
      inAlphaNumeric: inAlphaNumeric ?? this.inAlphaNumeric,
    );
  }

  @override
  List<Object?> get props => [
        isNavigatingTabDrawer,
        currentRecordedSelected,
        currentTabSelected,
        tab,
        recorded,
        currentSortSelected,
        isNavigatingSortDrawer,
        currentManagedSelected,
        isNavigatingManagedMenu,
        currentScheduledSelected,
        recordedPrograms,
        upcomingPrograms,
        isNavigatingAlertDialog,
        currentAlertBoxSelected,
        isLoading,
        alphanumeric,
        alphanumericIndex,
        isNavigatingControl,
        controlIndex,
        textSearch,
        isSearchLoading,
        channelAndProgramList,
        inSearchList,
        searchIndex,
        inAlphaNumeric,
      ];
}
