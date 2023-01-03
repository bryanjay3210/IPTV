import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vlc_player_status_state.dart';

class VlcPlayerStatusCubit extends Cubit<VlcPlayerStatusState> {
  VlcPlayerStatusCubit() : super(const VlcPlayerStatusState(status: true)) {
    emit(state.copyWith(true));
  }

  bool hasStarted = false;
  bool manuallyStopped = false;

  void refresh() {
    emit(state.copyWith(!state.status));
  }

  void changeStarted(bool value) {
    hasStarted = value;
    emit(state.copyWith(!state.status));
  }
}
