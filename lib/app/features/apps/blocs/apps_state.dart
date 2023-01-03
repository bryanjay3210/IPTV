part of 'apps_cubit.dart';

class AppsState extends Equatable {
  const AppsState({
    this.applications,
    this.selectedIndex,
  });

  final List<Application>? applications;
  final int? selectedIndex;

  AppsState copyWith({
    List<Application>? applications,
    int? selectedIndex,
  }) {
    return AppsState(
      applications: applications ?? this.applications,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [
        applications,
        selectedIndex,
      ];
}
