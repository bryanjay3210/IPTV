part of 'app_brightness_cubit.dart';

class AppBrightnessState extends Equatable {
  const AppBrightnessState({
    this.isVideoOn = true,
  });

  final bool isVideoOn;

  AppBrightnessState copyWith({bool? isVideoOn}) {
    return AppBrightnessState(isVideoOn: isVideoOn ?? this.isVideoOn);
  }

  @override
  List<Object?> get props => [isVideoOn];
}
