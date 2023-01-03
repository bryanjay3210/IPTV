import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iptv/core/models/channel.dart';

part 'channel_select_state.dart';

class ChannelSelectCubit extends Cubit<ChannelSelectState> {
  ChannelSelectCubit(int initialSelectedIndex)
      : super(ChannelSelectState(selectedChannelIndex: initialSelectedIndex));

  void handleDecrement(int maxLength) {
    if (state.selectedChannelIndex == 0) {
      emit(
        state.copyWith(selectedChannelIndex: maxLength - 1),
      );
      return;
    }

    emit(state.copyWith(selectedChannelIndex: state.selectedChannelIndex - 1));
  }

  void handleIncrement(int maxLength) {
    if (state.selectedChannelIndex == maxLength - 1) {
      emit(
        state.copyWith(selectedChannelIndex: 0),
      );

      return;
    }

    emit(state.copyWith(selectedChannelIndex: state.selectedChannelIndex + 1));
  }

  void changeIndex(int data) {
    emit(state.copyWith(selectedChannelIndex: data));
  }
}
