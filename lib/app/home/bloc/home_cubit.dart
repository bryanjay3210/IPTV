import 'package:bloc/bloc.dart';
import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:iptv/app/features/apps/pages/apps_page.dart';
import 'package:iptv/app/features/live_tv/pages/live_tv_page.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_menu/dvr_menu.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void handleLeft() {
    if (state.selectedIndex == 0) return;

    emit(
      state.copyWith(
        selectedIndex: state.selectedIndex - 1,
      ),
    );
  }

  void handleRight({bool isBeta = false}) {
    if (isBeta) {
      if (state.selectedIndex == 4) return;
    } else {
      if (state.selectedIndex == 3) return;
    }

    emit(
      state.copyWith(
        selectedIndex: state.selectedIndex + 1,
      ),
    );
  }

  void handleSelect(BuildContext context) {
    switch (state.selectedIndex) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const LiveTvPage(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const DVRView(),
          ),
        );
        break;
      case 2:
        try {
          DeviceApps.openApp('com.droidlogic.tv.settings').then((value) {
            if (!value) {
              // AppSettings.openAppSettings();
            }
          });
        } catch (e) {
          // AppSettings.openAppSettings();
        }
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const AppsPage(),
          ),
        );
        break;
      default:
        break;
    }
  }
}
