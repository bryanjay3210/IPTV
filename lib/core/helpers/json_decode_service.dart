import 'dart:async';
import 'dart:convert' show json;

import 'package:iptv/core/helpers/json_decode_service.activator.g.dart';
import 'package:squadron/squadron.dart';
import 'package:squadron/squadron_annotations.dart';

part 'json_decode_service.worker.g.dart';

@SquadronService(web: false)
class JsonDecodeService extends WorkerService
    with $JsonDecodeServiceOperations {
  @SquadronMethod()
  Future<dynamic> jsonDecode(String source) async => json.decode(source);
}
