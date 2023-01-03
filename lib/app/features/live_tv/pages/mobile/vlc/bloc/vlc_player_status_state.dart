part of 'vlc_player_status_cubit.dart';

class VlcPlayerStatusState extends Equatable {
  const VlcPlayerStatusState({
    required this.status,
  });

  final bool status;

  VlcPlayerStatusState copyWith(bool value) {
    return VlcPlayerStatusState(status: value);
  }

  @override
  List<Object?> get props => [status];
}
