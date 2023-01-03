import 'dart:math';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_stream_page.dart';

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return '0 B';
  const suffixes = ['B', 'Kb', 'Mb', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
  final i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

String parseDataFormatTypeToString(BuildContext context, Object data) {
  if (data is BetterPlayerAsmsTrack) {
    if (data.height == 0 && data.width == 0) {
      return 'Adaptive';
    }
    return '${data.width} x ${data.height}  ${formatBytes(data.bitrate ?? 0, 2)}ps';
  } else if (data is BetterPlayerAsmsAudioTrack) {
    if (data.label!.contains('eng')) {
      return 'English ${data.label!.substring(5)}';
    } else if (data.label!.contains('spa')) {
      return 'Spanish ${data.label!.substring(5)}';
    }
    return LocaleNames.of(context)!.nameOf(data.language!.substring(0, 2)) ??
        data.language.toString();
  } else if (data is BetterPlayerSubtitlesSource) {
    return data.name ?? 'None';
  } else if (data is PlaybackSpeedSelection) {
    return '${data.speed}x';
  }

  return 'Unknown';
}
