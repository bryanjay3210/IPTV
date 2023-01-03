import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iptv/core/models/channel.dart';

part 'channel_menu_state.dart';

class ChannelMenuCubit extends Cubit<ChannelMenuState> {
  ChannelMenuCubit()
      : super(
          const ChannelMenuState(
            currentGenreSelected: 0,
            currentChannelSelected: 0,
            isNavigatingThroughDrawer: true,
          ),
        ) {
    emit(
      state.copyWith(
        currentGenreSelected: 0,
        currentChannelSelected: 0,
        isNavigatingThroughDrawer: true,
      ),
    );
  }

  void changeGenre(int data) {
    emit(
      state.copyWith(
        currentGenreSelected: data,
        currentChannelSelected: 0,
      ),
    );
  }

  void handleKeyUp() {
    if (state.isNavigatingThroughDrawer) {
      if (state.currentGenreSelected == 0) return;

      changeGenre(state.currentGenreSelected - 1);
    } else {
      if (state.currentChannelSelected == 0) {
        emit(state.copyWith(isNavigatingThroughDrawer: true));
        return;
      }

      var newIndex = state.currentChannelSelected - 6;

      if (newIndex < 0) newIndex = 0;

      emit(state.copyWith(currentChannelSelected: newIndex));
    }
  }

  void handleKeyDown(int genresLength, int channelsLength) {
    if (state.isNavigatingThroughDrawer) {
      if (state.currentGenreSelected == genresLength - 1) return;

      changeGenre(state.currentGenreSelected + 1);
    } else {
      var newIndex = state.currentChannelSelected + 6;

      if (newIndex > channelsLength - 1) {
        newIndex = channelsLength - 1;
      }

      emit(state.copyWith(currentChannelSelected: newIndex));
    }
  }

  void handleKeyLeft() {
    if (state.isNavigatingThroughDrawer) return;

    if (state.currentChannelSelected == 0 ||
        (state.currentChannelSelected + 1) % 6 == 1) {
      emit(state.copyWith(isNavigatingThroughDrawer: true));
      return;
    }

    emit(
      state.copyWith(
        currentChannelSelected: state.currentChannelSelected - 1,
      ),
    );
  }

  void handleKeyRight(int channelsLength) {
    if (state.isNavigatingThroughDrawer) {
      emit(state.copyWith(isNavigatingThroughDrawer: false));
      return;
    }

    if (state.currentChannelSelected == channelsLength - 1) return;

    emit(
      state.copyWith(
        currentChannelSelected: state.currentChannelSelected + 1,
      ),
    );
  }
}
