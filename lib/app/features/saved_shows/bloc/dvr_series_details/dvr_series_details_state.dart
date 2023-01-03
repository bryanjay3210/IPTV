part of 'dvr_series_details_cubit.dart';

class DvrSeriesDetailsState extends Equatable {
  const DvrSeriesDetailsState({
    required this.columnIndexSelected,
    required this.rowIndexSelected,
    required this.recordSettingsValue,
    required this.keepUntilSettingsValue,
    required this.isLoading,
  });

  final int columnIndexSelected;
  final int rowIndexSelected;
  final String recordSettingsValue;
  final String keepUntilSettingsValue;
  final bool isLoading;

  DvrSeriesDetailsState copyWith({
    int? columnIndexSelected,
    int? rowIndexSelected,
    String? recordSettingsValue,
    String? keepUntilSettingsValue,
    String? seriesId,
    bool? isLoading,
  }) {
    return DvrSeriesDetailsState(
      columnIndexSelected: columnIndexSelected ?? this.columnIndexSelected,
      rowIndexSelected: rowIndexSelected ?? this.rowIndexSelected,
      recordSettingsValue: recordSettingsValue ?? this.recordSettingsValue,
      keepUntilSettingsValue: keepUntilSettingsValue ?? this.keepUntilSettingsValue,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    columnIndexSelected,
    rowIndexSelected,
    recordSettingsValue,
    keepUntilSettingsValue,
    isLoading
  ];
}
