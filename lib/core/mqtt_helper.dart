import 'package:iptv/core/device_id.dart';

enum MqttAction { chan, rec, prog, warning, severe }

String buildAction(
  Map<String, dynamic> data,
  MqttAction action,
) {
  final listOfCommands = <String>[];
  data.forEach((k, v) => listOfCommands.add('"$k":"$v"'));
  final postData = <String, dynamic>{
    'action': action.name,
    'id': DeviceId.deviceId,
  };
  if (!data.containsKey('time')) {
    postData.addAll({
      'time': (DateTime.now().toUtc().millisecondsSinceEpoch / 1000).round(),
    });
  }
  Map<String, dynamic>.from(postData)
      .forEach((k, v) => listOfCommands.insert(0, '"$k":"$v"'));

  return "{${listOfCommands.join(",")}}";
}
