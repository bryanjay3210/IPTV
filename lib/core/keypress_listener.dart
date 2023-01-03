import 'package:flutter/services.dart';

class KeypressListener {
  static const EventChannel _channel = EventChannel('tv.mdu1.iptv/keypress');
  static Stream<dynamic> stream =
      _channel.receiveBroadcastStream().cast<bool>();
}
