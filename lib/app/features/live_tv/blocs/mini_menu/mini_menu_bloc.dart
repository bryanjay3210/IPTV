import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:iptv/core/models/channel.dart';
import 'package:iptv/core/models/program.dart';

part 'mini_menu_event.dart';
part 'mini_menu_state.dart';

class MiniMenuBloc extends Bloc<MiniMenuEvent, MiniMenuState> {
  MiniMenuBloc() : super(MiniMenuInitial()) {
    on<FetchMiniMenuData>((event, emit) async {
      try {
        emit(MiniMenuLoading());

        final now = DateTime.now();

        Program? program;
        Program? nextProgram;

        final programIndex = event.currentChannel.programs!.indexWhere(
          (currentEpg) =>
              (now.isAfter(
                    currentEpg.startEpoch,
                  ) ||
                  now.isAtSameMomentAs(
                    currentEpg.startEpoch,
                  )) &&
              now.isBefore(currentEpg.stopEpoch),
        );

        if (programIndex != -1) {
          program = event.currentChannel.programs![programIndex];

          final nextProgramIndex = programIndex + 1;

          if (nextProgramIndex >= 0 &&
              nextProgramIndex < event.currentChannel.programs!.length) {
            nextProgram = event.currentChannel.programs![nextProgramIndex];
          }
        }

        emit(
          MiniMenuLoaded(
            data: program,
            nextData: nextProgram,
            isRecording: program?.isCurrentlyRecording ?? false,
            isFavorite: event.isFavoriteState,
          ),
        );
      } on TimeoutException {
        log('EPG timed out.');

        emit(const MiniMenuLoaded());
      } catch (e, st) {
        log(e.toString(), error: st);

        emit(MiniMenuFailure());
        rethrow;
      }
    });

    on<AddToFavorites>((event, emit) async {
      final currentState = state as MiniMenuLoaded;
      emit(
        MiniMenuLoaded(
          data: currentState.data,
          nextData: currentState.nextData,
          isRecording: currentState.isRecording,
          isFavorite: true,
        ),
      );
    });

    on<RemoveToFavorites>((event, emit) async {
      final currentState = state as MiniMenuLoaded;
      emit(
        MiniMenuLoaded(
          data: currentState.data,
          nextData: currentState.nextData,
          isRecording: currentState.isRecording,
        ),
      );
    });

    on<StartRecording>((event, emit) async {
      final currentState = state as MiniMenuLoaded;
      emit(
        MiniMenuLoaded(
          data: currentState.data,
          nextData: currentState.nextData,
          isRecording: true,
          isFavorite: currentState.isFavorite,
        ),
      );
    });

    on<StopRecording>((event, emit) async {
      final currentState = state as MiniMenuLoaded;
      emit(
        MiniMenuLoaded(
          data: currentState.data,
          nextData: currentState.nextData,
          isFavorite: currentState.isFavorite,
        ),
      );
    });
  }
}
