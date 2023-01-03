import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:iptv/app/home/bloc/channel_bloc.dart';
import 'package:iptv/core/api_service/channel_service.dart';
import 'package:iptv/core/api_service/dvr_service.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/models/channel.dart';

Future<List<Channel>?> getChannels(DateTime? timestamp) async {
  if (DeviceId.isCommunity) {
    final commonAreaListResponse = await GetIt.I<ChopperClient>()
        .getService<ChannelService>()
        .commonAreaList();

    final commonAreaListParsed = commonAreaListResponse.body!;

    final channels = <Channel>[];

    if (commonAreaListParsed['Channels'] is Map<String, dynamic>) {
      final element = commonAreaListParsed['Channels'] as Map<String, dynamic>;
      try {
        channels.add(
          Channel(
            epgChannelId: element['ID'].toString(),
            channelRowId: 'NA',
            guideChannelNum: element['Number'].toString(),
            iconUrl: element['Icon'].toString(),
            streamUrl: element['Stream'].toString(),
            dvrEnabled: false,
            isFavorite: false,
            genreName: 'Uncategorized',
            channelName: element['Name'].toString(),
            programs: [],
          ),
        );
      } catch (e) {
        // no-op
      }
    } else if (commonAreaListParsed['Channels'] is List) {
      for (final element in List<Map<String, dynamic>>.from(
        commonAreaListParsed['Channels'] as List,
      )) {
        try {
          channels.add(
            Channel(
              epgChannelId: element['ID'].toString(),
              channelRowId: 'NA',
              guideChannelNum: element['Number'].toString(),
              iconUrl: element['Icon'].toString(),
              streamUrl: element['Stream'].toString(),
              dvrEnabled: false,
              isFavorite: false,
              genreName: 'Uncategorized',
              channelName: element['Name'].toString(),
              programs: [],
            ),
          );
        } catch (e) {
          // no-op
        }
      }
      return channels;
    }
  }
  final resp =
      await GetIt.I<ChopperClient>().getService<ChannelService>().channels(
            startTimeCode: DateFormat('yyyyMMddHHmmss').format(
              timestamp ??
                  DateTime.now().toUtc().subtract(const Duration(hours: 4)),
            ),
            stopTimeCode: DateFormat('yyyyMMddHHmmss').format(
              timestamp?.add(const Duration(hours: 6)) ??
                  DateTime.now().toUtc().add(
                        const Duration(
                          hours: 6,
                        ),
                      ),
            ),
          );

  if (resp.body == null ||
      !resp.body!.containsKey('Channel') ||
      resp.body!['Channel'] is! List) {
    return null;
  }

  final beforeList = <Channel>[];

  for (final element in resp.body!['Channel'] as List) {
    final channel = Channel.fromJson(element as Map<String, dynamic>);
    if (channel.programs != null) {
      beforeList.add(channel);
    }
  }

  if (beforeList.isEmpty) {
    return null;
  }

  final now = DateTime.now();
  var minute = 0;
  if (now.minute < 30) {
    minute = 0;
  } else if (now.minute >= 30) {
    minute = 30;
  }

  final startTime = DateTime(now.year, now.month, now.day, now.hour, minute);

  for (final channel in beforeList) {
    if (channel.programs == null) break;
    channel.programs!.sort((a, b) => a.startEpoch.compareTo(b.startEpoch));

    channel.programs!.removeWhere(
      (element) {
        return !(element.stopEpoch.difference(startTime).inSeconds > 0);
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

    channel.programs!.sort((a, b) => a.startEpoch.compareTo(b.startEpoch));

    for (var i = 0; i < channel.programs!.length - 1; i++) {
      channel.programs![i] = channel.programs![i].copyWith(
        stopEpoch: channel.programs![i + 1].startEpoch,
      );
    }
  }

  beforeList.sort(
    (a, b) =>
        int.parse(a.guideChannelNum).compareTo(int.parse(b.guideChannelNum)),
  );

  return beforeList;
}

Future<DvrStats?> getDvrStats() async {
  final dvr =
      await GetIt.I<ChopperClient>().getService<DVRService>().storageStats();

  if (dvr.body != null && dvr.body!['RC'].toString().contains('E-000')) {
    final spacePurchased = num.parse(
      (dvr.body!['SpacePurchased'] is Map ? '0' : dvr.body!['SpacePurchased'])
          .toString(),
    );
    final spaceUsed = num.parse(
      (dvr.body!['SpaceUsed'] is Map ? '0' : dvr.body!['SpaceUsed']).toString(),
    );
    final spaceRemaining = num.parse(
      (dvr.body!['SpaceRemaining'] is Map ? '0' : dvr.body!['SpaceRemaining'])
          .toString(),
    );

    return DvrStats(
      spacePurchased: spacePurchased,
      spaceUsed: spaceUsed,
      spaceRemaining: spaceRemaining,
    );
  }

  return null;
}
