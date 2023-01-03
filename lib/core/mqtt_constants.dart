import 'package:flutter/material.dart';

// connection succeeded
void onConnected() {
  debugPrint('Connected');
}

// unconnected
void onDisconnected() {
  debugPrint('Disconnected');
}

// subscribe to topic succeeded
void onSubscribed(String topic) {
  debugPrint('Subscribed topic: $topic');
}

// subscribe to topic failed
void onSubscribeFail(String topic) {
  debugPrint('Failed to subscribe $topic');
}

// unsubscribe succeeded
void onUnsubscribed(String? topic) {
  debugPrint('Unsubscribed topic: $topic');
}

// PING response received
void pong() {
  debugPrint('Ping response client callback invoked');
}
