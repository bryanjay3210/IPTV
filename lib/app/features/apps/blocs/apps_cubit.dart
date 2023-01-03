import 'package:bloc/bloc.dart';
import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';

part 'apps_state.dart';

class AppsCubit extends Cubit<AppsState> {
  AppsCubit() : super(const AppsState()) {
    DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    ).then((value) {
      value.sort((a, b) => a.appName.compareTo(b.appName));
      emit(
        state.copyWith(
          applications: value,
          selectedIndex: 0,
        ),
      );
    });
  }

  void handleKeyUp() {
    var newIndex = (state.selectedIndex ?? 0) - 7;

    if ((state.selectedIndex ?? 0) <= 6) {
      newIndex = (state.selectedIndex ?? 0) - 1;
    }

    if (newIndex < 0) newIndex = 0;

    emit(state.copyWith(selectedIndex: newIndex));
  }

  void handleKeyDown() {
    if (state.applications == null) return;

    var newIndex = (state.selectedIndex ?? 0) + 7;

    if (newIndex > (state.applications!.length - 1)) {
      newIndex = state.applications!.length - 1;
    }

    emit(state.copyWith(selectedIndex: newIndex));
  }

  void handleKeyLeft() {
    if (state.selectedIndex == 0) return;
    emit(
      state.copyWith(selectedIndex: (state.selectedIndex ?? 0) - 1),
    );
  }

  void handleKeyRight() {
    if (state.applications == null) return;
    if (state.selectedIndex == (state.applications!.length - 1)) return;
    emit(
      state.copyWith(selectedIndex: (state.selectedIndex ?? 0) + 1),
    );
  }
}
