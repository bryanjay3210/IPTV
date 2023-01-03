import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:iptv/core/api_constants.dart';
import 'package:iptv/core/models/channel.dart';
import 'package:iptv/core/models/program.dart';

part 'epg_state.dart';

class EpgCubit extends Cubit<EpgState> {
  EpgCubit({
    required this.genreSelected,
    required this.channelSelected,
    required this.channels,
  }) : super(const EpgState()) {
    emit(
      state.copyWith(
        currChanSel: channelSelected,
        channels: channels,
      ),
    );

    cacheNavigationDates(channels);
  }

  final int genreSelected;
  final int channelSelected;
  final List<Channel> channels;

  List<String> enabledButtons = [];

  void handleKeyUp(List<Channel> channels) {
    final newChannelSelected = state.currChanSel - 1;
    var newIndex = 0;
    if (state.currProgSel <= 3) {
      newIndex = state.currProgSel;
    } else {
      newIndex = (channels[newChannelSelected].programs ?? [])
          .indexWhere(verticalNavigationTest);
    }

    if (newIndex == -1) {
      newIndex = state.currProgSel;
      if (newIndex > (channels[newChannelSelected].programs ?? []).length - 1) {
        newIndex = (channels[newChannelSelected].programs ?? []).length - 1;
      }
    }

    emit(
      state.copyWith(
        currChanSel: newChannelSelected,
        currProgSel: newIndex,
      ),
    );
  }

  void handleKeyDown(List<Channel> channels) {
    final newChannelSelected = state.currChanSel + 1;
    var newIndex = 0;
    if (state.currProgSel <= 3) {
      newIndex = state.currProgSel;
    } else {
      newIndex = (channels[newChannelSelected].programs ?? [])
          .indexWhere(verticalNavigationTest);
    }

    if (newIndex == -1) {
      newIndex = state.currProgSel;
      if (newIndex > (channels[newChannelSelected].programs?.length ?? 0) - 1) {
        newIndex = (channels[newChannelSelected].programs?.length ?? 0) - 1;
      }
    }

    emit(
      state.copyWith(
        currChanSel: newChannelSelected,
        currProgSel: newIndex,
      ),
    );
  }

  void handleStartRecording(List<Channel> channels) {
    fetchButtons(channels);
    unselectButton('series');
    unselectButton('record');
    selectButton('stop');
    fetchButtons(channels);
    disableInfoSheet();
  }

  void handleStopRecording(List<Channel> channels) {
    fetchButtons(channels);
    unselectButton('stop');
    unselectButton('series');
    selectButton('record');
    fetchButtons(channels);
    disableInfoSheet();
  }

  Future<void> handleKeyLeft(List<Channel> channels) async {
    if (state.isInfoSheet) {
      final currentIndex = getIndex();
      if (currentIndex == 0) {
        return;
      }
      unselectButton(enabledButtons[currentIndex]);
      selectButton(enabledButtons[currentIndex - 1]);
      return;
    }

    if (state.currProgSel == 0) {
      if (state.horizontalPaginationIndex != 0) {
        return handleLeftPagination();
      }
      return;
    }

    emit(
      state.copyWith(
        currProgSel: state.currProgSel - 1,
      ),
    );

    cacheNavigationDates(channels);
  }

  Future<void> handleRightPagination() async {
    emit(state.copyWith(isPaginationLoading: true));
    unawaited(SmartDialog.showLoading());
    final currentChannel = state.channels[state.currChanSel].epgChannelId;

    final channels = await getChannels(
      DateTime.now().toUtc().add(
            Duration(
              hours: (state.horizontalPaginationIndex + 1) * 6,
            ),
          ),
    );
    final genres = channels != null
        ? {
            'All Channels',
            'Favorites',
            ...channels.map((e) => e.genreName).toSet(),
          }
        : {
            'All Channels',
            'Favorites',
          };
    final genre = genres.elementAt(genreSelected);
    var filteredChannels = <Channel>[];
    if (genre.contains('All Channels')) {
      filteredChannels = channels ?? [];
    } else if (genre.contains('Favorites')) {
      filteredChannels =
          (channels ?? []).where((element) => element.isFavorite).toList();
    } else if (genre.contains('DVR')) {
      filteredChannels =
          (channels ?? []).where((element) => element.dvrEnabled).toList();
    } else {
      filteredChannels = (channels ?? [])
          .where((element) => element.genreName == genre)
          .toList();
    }

    final newChannel = filteredChannels.indexWhere(
      (element) => element.epgChannelId == currentChannel,
    );
    unawaited(SmartDialog.dismiss());

    emit(
      state.copyWith(
        channels: channels,
        horizontalPaginationIndex: state.horizontalPaginationIndex + 1,
        currProgSel: 0,
        currChanSel: newChannel == -1 ? state.currChanSel : newChannel,
        isPaginationLoading: false,
      ),
    );
  }

  Future<void> handleLeftPagination() async {
    emit(state.copyWith(isPaginationLoading: true));
    unawaited(SmartDialog.showLoading());
    final currentChannel = state.channels[state.currChanSel].epgChannelId;
    final channels = await getChannels(
      state.horizontalPaginationIndex == 1
          ? null
          : DateTime.now().toUtc().add(
                Duration(
                  hours: (state.horizontalPaginationIndex - 1) * 6,
                ),
              ),
    );
    final genres = channels != null
        ? {
            'All Channels',
            'Favorites',
            ...channels.map((e) => e.genreName).toSet(),
          }
        : {
            'All Channels',
            'Favorites',
          };
    final genre = genres.elementAt(genreSelected);
    var filteredChannels = <Channel>[];
    if (genre.contains('All Channels')) {
      filteredChannels = channels ?? [];
    } else if (genre.contains('Favorites')) {
      filteredChannels =
          (channels ?? []).where((element) => element.isFavorite).toList();
    } else if (genre.contains('DVR')) {
      filteredChannels =
          (channels ?? []).where((element) => element.dvrEnabled).toList();
    } else {
      filteredChannels = (channels ?? [])
          .where((element) => element.genreName == genre)
          .toList();
    }

    unawaited(SmartDialog.dismiss());
    final newChannel = filteredChannels.indexWhere(
      (element) => element.epgChannelId == currentChannel,
    );
    final currChanSel = newChannel == -1 ? state.currChanSel : newChannel;

    emit(
      state.copyWith(
        horizontalPaginationIndex: state.horizontalPaginationIndex - 1,
        channels: filteredChannels,
        currProgSel: filteredChannels[currChanSel].programs!.length - 1,
        currChanSel: currChanSel,
        isPaginationLoading: false,
      ),
    );
  }

  Future<void> handleKeyRight(List<Channel> channels) async {
    if (state.isInfoSheet) {
      final currentIndex = getIndex();
      if (currentIndex + 1 == enabledButtons.length) {
        return;
      }
      unselectButton(enabledButtons[currentIndex]);
      selectButton(enabledButtons[currentIndex + 1]);
      return;
    }

    if (state.currProgSel ==
        (channels[state.currChanSel].programs ?? []).length - 1) {
      await handleRightPagination();

      return;
    }

    emit(
      state.copyWith(
        currProgSel: state.currProgSel + 1,
      ),
    );

    cacheNavigationDates(channels);
  }

  void cacheNavigationDates(List<Channel> channels) {
    if (channels[state.currChanSel].programs == null) return;
    final currentEpg =
        (channels[state.currChanSel].programs ?? [])[state.currProgSel];

    var currentProgramStart = currentEpg.startEpoch;
    var currentProgramEnd = currentEpg.stopEpoch;

    var startMinute = 0;
    var endMinute = 0;

    if (currentProgramStart.minute < 30) {
      startMinute = 0;
    } else if (currentProgramStart.minute >= 30) {
      startMinute = 30;
    }

    if (currentProgramEnd.minute < 30) {
      endMinute = 0;
    } else if (currentProgramEnd.minute >= 30) {
      endMinute = 30;
    }

    currentProgramStart = DateTime(
      currentProgramStart.year,
      currentProgramStart.month,
      currentProgramStart.day,
      currentProgramStart.hour,
      startMinute,
    );
    currentProgramEnd = DateTime(
      currentProgramEnd.year,
      currentProgramEnd.month,
      currentProgramEnd.day,
      currentProgramEnd.hour,
      endMinute,
    );
    emit(
      state.copyWith(
        cachedNavigationDates: [
          currentProgramStart,
          currentProgramEnd,
        ],
      ),
    );
  }

  String getButtonName() {
    if (state.goLiveSelected) {
      return 'live';
    } else if (state.recordSelected) {
      return 'record';
    } else if (state.seriesSelected) {
      return 'series';
    } else if (state.stopSelected) {
      return 'stop';
    }

    return '';
  }

  int getIndex() {
    return enabledButtons.indexOf(getButtonName());
  }

  void selectButton(String button) {
    switch (button) {
      case 'live':
        emit(state.copyWith(goLiveSelected: true));
        break;
      case 'record':
        emit(state.copyWith(recordSelected: true));
        break;
      case 'series':
        emit(state.copyWith(seriesSelected: true));
        break;
      case 'stop':
        emit(state.copyWith(stopSelected: true));
        break;
      default:
    }
  }

  void unselectButton(String button) {
    switch (button) {
      case 'live':
        emit(state.copyWith(goLiveSelected: false));
        break;
      case 'record':
        emit(state.copyWith(recordSelected: false));
        break;
      case 'series':
        emit(state.copyWith(seriesSelected: false));
        break;
      case 'stop':
        emit(state.copyWith(stopSelected: false));
        break;
      default:
    }
  }

  void disableInfoSheet() {
    if (state.isInfoSheet) {
      return emit(
        state.copyWith(
          isInfoSheet: false,
          goLiveSelected: false,
          recordSelected: false,
          seriesSelected: false,
          stopSelected: false,
        ),
      );
    }
  }

  void fetchButtons(List<Channel> channels) {
    enabledButtons = [];
    final now = DateTime.now();
    final currentEpg = channels[state.currChanSel].programs![state.currProgSel];
    final currentChannel = channels[state.currChanSel];
    final isCurrentlyPlaying = (now.isAfter(currentEpg.startEpoch) ||
            now.isAtSameMomentAs(
              currentEpg.startEpoch,
            )) &&
        now.isBefore(currentEpg.stopEpoch);

    if (isCurrentlyPlaying) {
      enabledButtons.add('live');
    }

    if (currentChannel.dvrEnabled && !currentEpg.isCurrentlyRecording) {
      // TODO: Add check if DVR is enabled
      enabledButtons
        ..add('record')
        ..add('series');
    }

    if (currentEpg.isCurrentlyRecording) {
      enabledButtons.add('stop');
    }
  }

  void enableInfoSheet(List<Channel> channels) {
    fetchButtons(channels);
    if (enabledButtons.isEmpty) return;
    selectButton(enabledButtons[0]);
    emit(
      state.copyWith(
        isInfoSheet: true,
      ),
    );

    if (enabledButtons.isEmpty) return;
  }

  bool verticalNavigationTest(Program element) {
    return state.cachedNavigationDates.first.isAtSameMomentAs(
          element.startEpoch,
        ) ||
        state.cachedNavigationDates.last.isAtSameMomentAs(
          element.stopEpoch,
        ) ||
        (state.cachedNavigationDates.first.isAfter(element.startEpoch) &&
            state.cachedNavigationDates.last.isBefore(element.stopEpoch)) ||
        (state.cachedNavigationDates.first.isAfter(element.stopEpoch) &&
            state.cachedNavigationDates.last.isBefore(element.startEpoch)) ||
        (element.stopEpoch.isBefore(state.cachedNavigationDates.last) &&
            element.startEpoch.isAfter(
              state.cachedNavigationDates.first,
            )) ||
        (state.cachedNavigationDates.first.isBefore(element.startEpoch) &&
            state.cachedNavigationDates.last.isBefore(element.stopEpoch));
  }

  void changeChannelAndProgramSelected(int channel, int program) {
    return emit(
      state.copyWith(
        currChanSel: channel,
        currProgSel: program,
      ),
    );
  }
}
