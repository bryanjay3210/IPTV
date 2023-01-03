part of 'mini_menu_bloc.dart';

abstract class MiniMenuState extends Equatable {
  const MiniMenuState();

  @override
  List<Object?> get props => [];
}

class MiniMenuInitial extends MiniMenuState {}

class MiniMenuLoading extends MiniMenuState {}

class MiniMenuLoaded extends MiniMenuState {
  const MiniMenuLoaded({
    this.data,
    this.nextData,
    this.isRecording = false,
    this.isFavorite = false,
  });

  final Program? data;
  final Program? nextData;
  final bool isRecording;
  final bool isFavorite;

  @override
  List<Object?> get props => [
        data,
        nextData,
        isRecording,
        isFavorite,
      ];
}

class MiniMenuFailure extends MiniMenuState {}
