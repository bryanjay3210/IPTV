import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:collection/collection.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:iptv/core/api_constants.dart';
import 'package:iptv/core/api_service/channel_service.dart';
import 'package:iptv/core/api_service/dvr_service.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/models/channel.dart';
import 'package:iptv/core/mqtt_helper.dart';
import 'package:logging/logging.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

part 'channel_bloc.freezed.dart';
part 'channel_event.dart';
part 'channel_state.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  ChannelBloc() : super(const _Initial()) {
    on<ChannelEvent>(
      (event, emit) async {
        await event.when(
          updateProgramRecordStatus: (epgSeriesId) async {
            final previousState = state;

            if (previousState is! _Loaded) {
              return;
            }

            final listOfChannels = previousState.channels.toList();

            var programIndex = 1;
            final channelIndex = listOfChannels.indexWhere((element) {
              programIndex = -1;
              final prog = element.programs!.firstWhereOrNull((element) {
                programIndex = programIndex + 1;
                return element.epgSeriesId == epgSeriesId;
              });
              return prog != null;
            });
            if (channelIndex != -1) {
              final channel = listOfChannels[channelIndex];
              final programs = channel.programs;
              final program = programs![programIndex];

              programs[programIndex] =
                  program.copyWith(isCurrentlyRecording: false);
              listOfChannels[channelIndex] =
                  channel.copyWith(programs: programs);

              final genre =
                  previousState.genres.elementAt(previousState.genreSelected);
              var filteredChannels = <Channel>[];
              if (genre.contains('All Channels')) {
                filteredChannels = listOfChannels;
              } else if (genre.contains('Favorites')) {
                filteredChannels = listOfChannels
                    .where((element) => element.isFavorite)
                    .toList();
              } else if (genre.contains('DVR')) {
                filteredChannels = listOfChannels
                    .where((element) => element.dvrEnabled)
                    .toList();
              } else {
                filteredChannels = listOfChannels
                    .where((element) => element.genreName == genre)
                    .toList();
              }

              emit(
                previousState.copyWith(
                  channels: listOfChannels,
                  filteredChannels: filteredChannels,
                ),
              );
            }
          },
          changeChannelAndGenre: (
            channelIndex,
            genreIndex,
          ) async {
            final previousState = state;

            if (previousState is! _Loaded) {
              return;
            }

            final genre = previousState.genres.elementAt(genreIndex);
            var filteredChannels = <Channel>[];
            if (genre.contains('All Channels')) {
              filteredChannels = previousState.channels;
            } else if (genre.contains('Favorites')) {
              filteredChannels = previousState.channels
                  .where((element) => element.isFavorite)
                  .toList();
            } else if (genre.contains('DVR')) {
              filteredChannels = previousState.channels
                  .where((element) => element.dvrEnabled)
                  .toList();
            } else {
              filteredChannels = previousState.channels
                  .where((element) => element.genreName == genre)
                  .toList();
            }

            emit(
              previousState.copyWith(
                genreSelected: genreIndex,
                filteredChannels: filteredChannels,
                channelSelected: channelIndex,
              ),
            );
          },
          fetch: (timestamp) async {
            emit(const _Loading());

            try {
              final channels = await getChannels(timestamp);
              final dvrStats = await getDvrStats();
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

              final genre = genres.elementAt(0);
              var filteredChannels = <Channel>[];
              if (genre.contains('All Channels')) {
                filteredChannels = channels ?? [];
              } else if (genre.contains('Favorites')) {
                filteredChannels = (channels ?? [])
                    .where((element) => element.isFavorite)
                    .toList();
              } else if (genre.contains('DVR')) {
                filteredChannels = (channels ?? [])
                    .where((element) => element.dvrEnabled)
                    .toList();
              } else {
                filteredChannels = (channels ?? [])
                    .where((element) => element.genreName == genre)
                    .toList();
              }

              _refetchTimer ??=
                  Stream.periodic(const Duration(hours: 4), (x) => x).listen(
                (_) => add(const ChannelEvent.reloadChannels()),
                onError: (dynamic error, StackTrace stackTrace) =>
                    GetIt.I.get<Logger>().severe(
                          'Error refetching channels',
                          error,
                          stackTrace,
                        ),
              );

              // ignore: inference_failure_on_function_invocation
              final box = await Hive.openBox('tv_cache');
              final cachedGenre =
                  int.parse(box.get('genre', defaultValue: 0).toString());
              final cachedChannel =
                  int.parse(box.get('channel', defaultValue: 0).toString());

              emit(
                _Loaded(
                  channels: channels ?? [],
                  genres: genres,
                  spacePurchased: dvrStats?.spacePurchased ?? 0,
                  spaceRemaining: dvrStats?.spaceRemaining ?? 0,
                  spaceUsed: dvrStats?.spaceUsed ?? 0,
                  filteredChannels: filteredChannels,
                ),
              );

              add(_ChangeGenre(cachedGenre));
              add(_ChangeChannel(cachedChannel));
            } catch (e, st) {
              emit(_Error('[500] [Channels] Unexpected error! $e'));

              await Future.delayed(Duration(seconds: DeviceId.retryTimer));

              try {
                GetIt.I.get<Logger>().severe(
                      '[500] [Channels] Unexpected error!',
                      e,
                      st,
                    );
              } catch (e) {
                // no-op
              }

              add(const ChannelEvent.fetch());

              rethrow;
            }
          },
          reloadChannels: () async {
            final previousState = state;

            if (previousState is! _Loaded) {
              return;
            }

            try {
              final channels = await getChannels(null);
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
              final genre = genres.elementAt(0);
              var filteredChannels = <Channel>[];
              if (genre.contains('All Channels')) {
                filteredChannels = channels ?? [];
              } else if (genre.contains('Favorites')) {
                filteredChannels = (channels ?? [])
                    .where((element) => element.isFavorite)
                    .toList();
              } else if (genre.contains('DVR')) {
                filteredChannels = (channels ?? [])
                    .where((element) => element.dvrEnabled)
                    .toList();
              } else {
                filteredChannels = (channels ?? [])
                    .where((element) => element.genreName == genre)
                    .toList();
              }

              emit(
                previousState.copyWith(
                  channels: channels ?? [],
                  genres: genres,
                  filteredChannels: filteredChannels,
                ),
              );
            } catch (e, st) {
              emit(
                _Error(
                  '[500] [Channels] There was a problem refreshing channel guide. $e',
                ),
              );

              try {
                GetIt.I.get<Logger>().severe(
                      '[500] [Channels] There was a problem refreshing channel guide.',
                      e,
                      st,
                    );
              } catch (e) {
                // no-op
              }

              rethrow;
            }
          },
          reloadDvr: () async {
            final previousState = state;

            if (previousState is! _Loaded) {
              return;
            }

            emit(const _Loading());

            try {
              final dvrStats = await getDvrStats();

              emit(
                previousState.copyWith(
                  spacePurchased: dvrStats?.spacePurchased ?? 0,
                  spaceRemaining: dvrStats?.spaceRemaining ?? 0,
                  spaceUsed: dvrStats?.spaceUsed ?? 0,
                ),
              );
            } catch (e, st) {
              emit(
                _Error(
                  '[500] [Channels] There was a problem refreshing DVR. $e',
                ),
              );

              try {
                GetIt.I.get<Logger>().severe(
                      '[500] [Channels] There was a problem refreshing DVR.',
                      e,
                      st,
                    );
              } catch (e) {
                // no-op
              }

              rethrow;
            }
          },
          changeChannel: (index) async {
            final previousState = state;

            if (previousState is! _Loaded) {
              return;
            }

            if (index >= 0 && index < previousState.filteredChannels.length) {
              emit(
                previousState.copyWith(
                  channelSelected: index,
                ),
              );

              // ignore: inference_failure_on_function_invocation
              final box = await Hive.openBox('tv_cache');
              unawaited(box.put('channel', index));
              final builder = MqttClientPayloadBuilder()
                ..addString(
                  buildAction(
                    {
                      'oldchan': previousState
                          .filteredChannels[previousState.channelSelected]
                          .epgChannelId,
                      'newchan':
                          previousState.filteredChannels[index].epgChannelId,
                    },
                    MqttAction.chan,
                  ),
                );

              try {
                final client = GetIt.I.get<MqttServerClient>();

                if (client.connectionStatus?.state ==
                        MqttConnectionState.connected &&
                    builder.payload != null) {
                  client.publishMessage(
                    'statlog',
                    MqttQos.atLeastOnce,
                    builder.payload!,
                  );
                }
              } catch (e) {
                // no-op: could fail on first boot
              }
            }
          },
          changeGenre: (index) async {
            final previousState = state;

            if (previousState is! _Loaded) {
              return;
            }

            if (index >= 0 && index < previousState.genres.length) {
              final genre = previousState.genres.elementAt(index);
              var filteredChannels = <Channel>[];
              if (genre.contains('All Channels')) {
                filteredChannels = previousState.channels;
              } else if (genre.contains('Favorites')) {
                filteredChannels = previousState.channels
                    .where((element) => element.isFavorite)
                    .toList();
              } else if (genre.contains('DVR')) {
                filteredChannels = previousState.channels
                    .where((element) => element.dvrEnabled)
                    .toList();
              } else {
                filteredChannels = previousState.channels
                    .where((element) => element.genreName == genre)
                    .toList();
              }

              if (filteredChannels.isEmpty) {
                index = 0;
                filteredChannels = previousState.channels;
              }

              emit(
                previousState.copyWith(
                  genreSelected: index,
                  filteredChannels: filteredChannels,
                ),
              );

              // ignore: inference_failure_on_function_invocation
              final box = await Hive.openBox('tv_cache');
              await box.put('genre', index);
            }
          },
          traverseChannel: (increment) {
            final previousState = state;

            if (previousState is! _Loaded) {
              return;
            }

            if (increment) {
              final newIndex = previousState.channelSelected + 1;
              if (newIndex < previousState.filteredChannels.length) {
                add(
                  ChannelEvent.changeChannel(
                    newIndex,
                  ),
                );
              } else {
                add(const ChannelEvent.changeChannel(0));
              }
            } else {
              final newIndex = previousState.channelSelected - 1;
              if (newIndex < 0) {
                add(
                  ChannelEvent.changeChannel(
                    previousState.filteredChannels.length - 1,
                  ),
                );
              } else {
                add(
                  ChannelEvent.changeChannel(
                    newIndex,
                  ),
                );
              }
            }
          },
          forceUpdateFilteredChannels: (channels) {
            final previousState = state;

            if (previousState is! _Loaded) {
              return;
            }

            emit(
              previousState.copyWith(
                filteredChannels: channels,
              ),
            );
          },
          recordProgram: (
            int channelIndex,
            int programIndex,
            callback,
          ) async {
            final previousState = state;

            if (previousState is! _Loaded) {
              return;
            }

            if (!(previousState.spaceRemaining > 0)) {
              unawaited(
                SmartDialog.showToast(
                  'You do not have enough storage recording this show.',
                ),
              );
              return;
            }

            final channel = previousState.filteredChannels[channelIndex];
            final now = DateTime.now();
            final program = channel.programs![programIndex];
            if (program.stopEpoch.difference(now).inMinutes.isNegative) {
              await SmartDialog.showToast(
                'You cannot record a program in the past.',
              );
              return;
            }

            final value = await GetIt.I<ChopperClient>()
                .getService<DVRService>()
                .recordProgram(
                  channel: channel.epgChannelId,
                  epgShowId: program.epgShowId,
                  timecode: DateFormat('yyyyMMddHHmmss').format(
                    program.startEpoch.toUtc(),
                  ),
                );

            final parsedResp = value.body!;
            if (parsedResp['RC'].toString().contains('E-000')) {
              final listOfChannels = previousState.filteredChannels.toList();
              final myChannel = listOfChannels.indexWhere(
                (element) => element.epgChannelId == channel.epgChannelId,
              );
              final listOfPrograms = channel.programs;
              final myProgram = channel.programs!.indexWhere(
                (element) => element.epgShowId == program.epgShowId,
              );
              listOfPrograms![myProgram] =
                  program.copyWith(isCurrentlyRecording: true);

              listOfChannels[myChannel] =
                  channel.copyWith(programs: listOfPrograms);

              emit(
                previousState.copyWith(
                  filteredChannels: listOfChannels,
                ),
              );

              callback(listOfChannels);

              await SmartDialog.showToast(
                'Successfully started recording.',
              );
            } else if (parsedResp['RC'].toString().contains('E-206')) {
              final listOfChannels = previousState.filteredChannels.toList();
              final myChannel = listOfChannels.indexWhere(
                (element) => element.epgChannelId == channel.epgChannelId,
              );
              final listOfPrograms = channel.programs;
              final myProgram = channel.programs!.indexWhere(
                (element) => element.epgShowId == program.epgShowId,
              );
              listOfPrograms![myProgram] =
                  program.copyWith(isCurrentlyRecording: true);

              listOfChannels[myChannel] =
                  channel.copyWith(programs: listOfPrograms);

              emit(
                previousState.copyWith(
                  filteredChannels: listOfChannels,
                ),
              );

              callback(listOfChannels);

              await SmartDialog.showToast(
                'Successfully started recording.',
              );
            } else if (parsedResp['RC'].toString().contains('W-101')) {
              final listOfChannels = previousState.filteredChannels.toList();
              final myChannel = listOfChannels.indexWhere(
                (element) => element.epgChannelId == channel.epgChannelId,
              );
              final listOfPrograms = channel.programs;
              final myProgram = channel.programs!.indexWhere(
                (element) => element.epgShowId == program.epgShowId,
              );
              listOfPrograms![myProgram] =
                  program.copyWith(isCurrentlyRecording: true);
              listOfChannels[myChannel] =
                  channel.copyWith(programs: listOfPrograms);

              emit(
                previousState.copyWith(
                  filteredChannels: listOfChannels,
                ),
              );

              callback(listOfChannels);

              await SmartDialog.showToast(
                'Successfully started recording.',
              );
            } else {
              unawaited(
                SmartDialog.showToast(
                  'Error recording program! ${parsedResp['RC']}',
                ),
              );
              return;
            }

            final builder = MqttClientPayloadBuilder()
              ..addString(
                buildAction(
                  {
                    'chan': channel.epgChannelId,
                    'prog': program.epgShowId,
                    'time': (program.startEpoch.toUtc().millisecondsSinceEpoch /
                            1000)
                        .round()
                        .toString(),
                  },
                  MqttAction.rec,
                ),
              );

            final client = GetIt.I.get<MqttServerClient>();

            if (client.connectionStatus?.state ==
                    MqttConnectionState.connected &&
                builder.payload != null) {
              client.publishMessage(
                'statlog',
                MqttQos.atLeastOnce,
                builder.payload!,
              );
            }
          },
          recordSeries: (
            int channelIndex,
            int programIndex,
            callback,
          ) async {
            final previousState = state;

            if (previousState is! _Loaded) {
              return;
            }

            if (!(previousState.spaceRemaining > 0)) {
              unawaited(
                SmartDialog.showToast(
                  'You do not have enough storage recording this show.',
                ),
              );
              return;
            }

            final channel = previousState.filteredChannels[channelIndex];
            final now = DateTime.now();
            final program = channel.programs![programIndex];
            if (program.stopEpoch.difference(now).inMinutes.isNegative) {
              await SmartDialog.showToast(
                'You cannot record a program in the past.',
              );
              return;
            }

            final value = await GetIt.I<ChopperClient>()
                .getService<DVRService>()
                .recordSeries(
                  epgSeriesId: program.epgSeriesId,
                  epgShowId: program.epgShowId,
                  epgChannelId: channel.epgChannelId,
                );

            final parsedResp = value.body!;
            if (parsedResp['RC'].toString().contains('E-000')) {
              final listOfChannels = previousState.filteredChannels.toList();
              final myChannel = listOfChannels.indexWhere(
                (element) => element.epgChannelId == channel.epgChannelId,
              );
              final listOfPrograms = channel.programs;
              final myProgram = channel.programs!.indexWhere(
                (element) => element.epgShowId == program.epgShowId,
              );
              listOfPrograms![myProgram] =
                  program.copyWith(isCurrentlyRecording: true);

              final seriesId = program.epgSeriesId;
              for (var i = 0; i < listOfPrograms.length; i++) {
                if (listOfPrograms[i].epgSeriesId == seriesId &&
                    listOfPrograms[i].previousRun.isEmpty) {
                  listOfPrograms[i] = listOfPrograms[i].copyWith(
                    isCurrentlyRecording: true,
                  );
                }
              }

              listOfChannels[myChannel] =
                  channel.copyWith(programs: listOfPrograms);

              emit(
                previousState.copyWith(
                  filteredChannels: listOfChannels,
                ),
              );

              callback(listOfChannels);

              await SmartDialog.showToast(
                'Successfully started recording.',
              );
            } else if (parsedResp['RC'].toString().contains('E-206')) {
              final listOfChannels = previousState.filteredChannels.toList();
              final myChannel = listOfChannels.indexWhere(
                (element) => element.epgChannelId == channel.epgChannelId,
              );
              final listOfPrograms = channel.programs;
              final myProgram = channel.programs!.indexWhere(
                (element) => element.epgShowId == program.epgShowId,
              );
              listOfPrograms![myProgram] =
                  program.copyWith(isCurrentlyRecording: true);

              final seriesId = program.epgSeriesId;
              for (var i = 0; i < listOfPrograms.length; i++) {
                if (listOfPrograms[i].epgSeriesId == seriesId &&
                    listOfPrograms[i].previousRun.isEmpty) {
                  listOfPrograms[i] = listOfPrograms[i].copyWith(
                    isCurrentlyRecording: true,
                  );
                }
              }

              listOfChannels[myChannel] =
                  channel.copyWith(programs: listOfPrograms);

              emit(
                previousState.copyWith(
                  filteredChannels: listOfChannels,
                ),
              );

              callback(listOfChannels);

              await SmartDialog.showToast(
                'Successfully started recording.',
              );
            } else if (parsedResp['RC'].toString().contains('W-101')) {
              final listOfChannels = previousState.filteredChannels.toList();
              final myChannel = listOfChannels.indexWhere(
                (element) => element.epgChannelId == channel.epgChannelId,
              );
              final listOfPrograms = channel.programs;
              final myProgram = channel.programs!.indexWhere(
                (element) => element.epgShowId == program.epgShowId,
              );
              listOfPrograms![myProgram] =
                  program.copyWith(isCurrentlyRecording: true);
              listOfChannels[myChannel] =
                  channel.copyWith(programs: listOfPrograms);

              emit(
                previousState.copyWith(
                  filteredChannels: listOfChannels,
                ),
              );

              callback(listOfChannels);

              await SmartDialog.showToast(
                'Successfully started recording.',
              );
            } else {
              await SmartDialog.showToast(
                'Error recording program! ${parsedResp['RC']}',
              );
            }
          },
          stopRecordingProgram: (
            int channelIndex,
            int programIndex,
            callback,
          ) async {
            final previousState = state;

            if (previousState is! _Loaded) {
              return;
            }

            final channel = previousState.filteredChannels[channelIndex];
            final program = channel.programs![programIndex];

            await GetIt.I<ChopperClient>()
                .getService<DVRService>()
                .stopRecordingProgram(
                  epgChannelId: channel.epgChannelId,
                  epgShowId: program.epgShowId,
                  timecode: DateFormat('yyyyMMddHHmmss').format(
                    program.startEpoch.toUtc(),
                  ),
                )
                .then((value) {
              final parsedResp = value.body!;
              if (parsedResp['RC'].toString().contains('E-000')) {
                final listOfChannels = previousState.filteredChannels.toList();
                final myChannel = listOfChannels.indexWhere(
                  (element) => element.epgChannelId == channel.epgChannelId,
                );
                final listOfPrograms = channel.programs;
                final myProgram = channel.programs!.indexWhere(
                  (element) => element.epgShowId == program.epgShowId,
                );
                listOfPrograms![myProgram] =
                    program.copyWith(isCurrentlyRecording: false);
                listOfChannels[myChannel] =
                    channel.copyWith(programs: listOfPrograms);

                emit(
                  previousState.copyWith(
                    filteredChannels: listOfChannels,
                  ),
                );

                callback(listOfChannels);

                SmartDialog.showToast(
                  'Successfully stopped recording.',
                );
              } else {
                SmartDialog.showToast(
                  'Error stopping recording program! ${parsedResp['RC']}',
                );
              }
            });
          },
          addFavoriteChannel: (epgChannelId, callback) async {
            try {
              final previousState = state;

              if (previousState is! _Loaded) {
                return;
              }

              unawaited(SmartDialog.showLoading(backDismiss: false));

              await GetIt.I<ChopperClient>()
                  .getService<ChannelService>()
                  .actionFavorite(
                    action: 'A',
                    channelId: epgChannelId,
                  );

              final listOfChannels = previousState.filteredChannels.toList();
              final myChannel = listOfChannels.indexWhere(
                (element) => element.epgChannelId == epgChannelId,
              );
              listOfChannels[myChannel] = listOfChannels[myChannel].copyWith(
                isFavorite: true,
              );

              final listOfChannels2 = previousState.channels.toList();
              final myChannel2 = listOfChannels2.indexWhere(
                (element) => element.epgChannelId == epgChannelId,
              );
              listOfChannels2[myChannel2] =
                  listOfChannels2[myChannel2].copyWith(
                isFavorite: true,
              );

              unawaited(SmartDialog.dismiss());
              emit(
                previousState.copyWith(
                  filteredChannels: listOfChannels,
                  channels: listOfChannels2,
                ),
              );

              callback();
            } catch (e) {
              unawaited(SmartDialog.dismiss());
            }
          },
          removeFavoriteChannel: (epgChannelId, callback) async {
            try {
              final previousState = state;

              if (previousState is! _Loaded) {
                return;
              }

              unawaited(SmartDialog.showLoading(backDismiss: false));

              await GetIt.I<ChopperClient>()
                  .getService<ChannelService>()
                  .actionFavorite(
                    action: 'R',
                    channelId: epgChannelId,
                  );

              final listOfChannels = previousState.filteredChannels.toList();
              final myChannel = listOfChannels.indexWhere(
                (element) => element.epgChannelId == epgChannelId,
              );
              listOfChannels[myChannel] = listOfChannels[myChannel].copyWith(
                isFavorite: false,
              );

              final listOfChannels2 = previousState.channels.toList();
              final myChannel2 = listOfChannels2.indexWhere(
                (element) => element.epgChannelId == epgChannelId,
              );
              listOfChannels2[myChannel2] =
                  listOfChannels2[myChannel2].copyWith(
                isFavorite: false,
              );

              unawaited(SmartDialog.dismiss());
              emit(
                previousState.copyWith(
                  filteredChannels: listOfChannels,
                  channels: listOfChannels2,
                ),
              );

              callback();
            } catch (e) {
              unawaited(SmartDialog.dismiss());
            }
          },
          clean: (callback) {
            final previousState = state;

            if (previousState is! _Loaded) {
              return;
            }

            final now = DateTime.now();
            var minute = 0;
            if (now.minute < 30) {
              minute = 0;
            } else if (now.minute >= 30) {
              minute = 30;
            }

            final startTime =
                DateTime(now.year, now.month, now.day, now.hour, minute);

            final beforeList = previousState.channels;

            for (final channel in beforeList) {
              if (channel.programs == null) break;
              channel.programs!
                  .sort((a, b) => a.startEpoch.compareTo(b.startEpoch));

              channel.programs!.removeWhere(
                (element) {
                  return !(element.stopEpoch.difference(startTime).inSeconds >
                      0);
                },
              );
              for (var i = 0; i < channel.programs!.length; i++) {
                final program = channel.programs![i];

                if (channel.programs!
                        .where(
                          (element) => element.startEpoch == program.startEpoch,
                        )
                        .length >
                    1) {
                  channel.programs!.removeAt(i);
                }
              }

              channel.programs!
                  .sort((a, b) => a.startEpoch.compareTo(b.startEpoch));

              for (var i = 0; i < channel.programs!.length - 1; i++) {
                channel.programs![i] = channel.programs![i].copyWith(
                  stopEpoch: channel.programs![i + 1].startEpoch,
                );
              }
            }

            beforeList.sort(
              (a, b) => int.parse(a.guideChannelNum)
                  .compareTo(int.parse(b.guideChannelNum)),
            );

            emit(
              previousState.copyWith(
                channels: beforeList,
              ),
            );

            add(ChannelEvent.changeGenre(previousState.genreSelected));

            if (callback != null) {
              callback();
            }
          },
        );
      },

      // transformer: sequential(),
    );
  }

  StreamSubscription<dynamic>? _refetchTimer;
}

class DvrStats {
  DvrStats({
    this.spacePurchased = 0,
    this.spaceUsed = 0,
    this.spaceRemaining = 0,
  });

  final num spacePurchased;
  final num spaceUsed;
  final num spaceRemaining;
}
