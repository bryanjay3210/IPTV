import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:iptv/app/view/navigation_service.dart';

import '../../../../../../core/models/channel.dart';
import '../../../../../../core/models/program.dart';
import '../../../../../home/bloc/channel_bloc.dart';
part 'epg_search_event.dart';
part 'epg_search_state.dart';

class EpgSearchBloc extends Bloc<ChannelEvent, ChannelState> {
  EpgSearchBloc() : super(const ChannelSuccessState(list: <Channel>[])) {
    on<TypeChannelName>(_filter);
    on<InitializeEvent>(_initialize);
    on<SelectChannelEvent>(getPrograms);
  }

  List<Channel> channels = <Channel>[];
  List<Program> programs = <Program>[];
  final searchCtrler = TextEditingController();
  final GlobalKey<FormFieldState<String>> searchFormKey =
      GlobalKey<FormFieldState<String>>();

  void _initialize(event, emit) {
    if (NavigationService.navigatorKey.currentContext != null) {
      NavigationService.navigatorKey.currentContext!
          .read<ChannelBloc>()
          .state
          .maybeMap(
              orElse: () => null,
              loaded: (state) {
                channels = state.filteredChannels;
              });
    }
  }

  void _filter(TypeChannelName event, Emitter<ChannelState> emit) {
    emit(ChannelLoadingState());
    if (event.channelName.trim().isEmpty) {
      channels = NavigationService.navigatorKey.currentContext!
          .read<ChannelBloc>()
          .state
          .maybeMap(
              orElse: () => [],
              loaded: (state) {
                return state.filteredChannels;
              });
    } else {
      channels = NavigationService.navigatorKey.currentContext!
          .read<ChannelBloc>()
          .state
          .maybeMap(
              orElse: () => [],
              loaded: (state) {
                return state.filteredChannels
                    .where(
                      (element) =>
                          element.channelName.trim().toLowerCase().contains(
                              event.channelName.trim().toLowerCase()) ||
                          element.guideChannelNum
                              .trim()
                              .contains(event.channelName.trim()),
                    )
                    .toList();
              });
    }

    emit(ChannelSuccessState(list: channels));
  }

  void getPrograms(SelectChannelEvent event, Emitter<ChannelState> emit) {
    _initialize(event, emit);

    NavigationService.navigatorKey.currentContext!
        .read<ChannelBloc>()
        .state
        .maybeMap(
            orElse: () => null,
            loaded: (state) {
              final programs =
                  state.filteredChannels[state.channelSelected].programs;
              if (programs == null || programs.isEmpty) {
                emit(ProgramEmptyState());
              } else {
                emit(ProgramSuccessState(list: programs));
              }
            });
  }
}
