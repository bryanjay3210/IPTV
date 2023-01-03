import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_brightness_state.dart';

class AppBrightnessCubit extends Cubit<AppBrightnessState> {
  AppBrightnessCubit() : super(const AppBrightnessState());

  void turnOn() {
    emit(state.copyWith(isVideoOn: true));
  }

  void turnOff() {
    emit(state.copyWith(isVideoOn: false));
  }
}
