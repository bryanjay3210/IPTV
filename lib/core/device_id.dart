import 'dart:math';

import 'package:screen_state/screen_state.dart';

class DeviceId {
  static String deviceId = '';
  static bool isStb = false;
  static bool isVLC = false;
  static bool isProduction = false;
  static bool isMqttCertLoaded = false;
  static bool ccEnabled = false;
  static bool isCommunity = false;
  static int retryTimer = 15;
  static int idleTimer = 14400;
  static Screen screenListener = Screen();
  static DateTime buildVersionDate = DateTime(2022, 12, 21, 8);

  String get uniqueCode => splitStringByLength(
        String.fromCharCodes(
          Iterable.generate(
            8,
            (_) => _chars.codeUnitAt(_random.nextInt(_chars.length)),
          ),
        ),
        4,
      );

  String splitStringByLength(String str, int length) =>
      [str.substring(0, length), str.substring(length)].join('-');

  final _chars = 'ABCDEFGHJKLMNPRSTUVWXYZ23456789';
  final _random = Random(deviceId.hashCode);
}
