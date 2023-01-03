// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$AuthService extends AuthService {
  _$AuthService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AuthService;

  @override
  Future<Response<Map<String, dynamic>>> authenticate({
    String command = 'auth',
    required String username,
    required String password,
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'username': username,
      'password': password,
    };
    final $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> registrationCheck({
    String command = 'STBRegCheck',
    required String id,
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'MAC': id,
    };
    final $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> registerOauth({
    String command = 'STBRegOauth',
    required String id,
    required String hash,
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'MAC': id,
      'Hash': hash,
    };
    final $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> sendCode({
    String command = 'STBStore4-4',
    required String id,
    required String code,
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'MAC': id,
      '4-4': code,
    };
    final $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> bindCodeToUser({
    String command = 'STBBind',
    required String code,
    required String customerId,
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      '4-4': code,
      'cid': customerId,
    };
    final $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> fetchLastKnownStatus({
    String command = 'Function',
    String subcommand = 'Status',
    required String id,
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'Subcommand1': subcommand,
      'androidID': id,
    };
    final $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> sendDeviceStatus({
    String command = 'Function',
    String subcommand = 'UpdateSTBStatus',
    required String publicIp,
    required String privateIp,
    required String interface,
    required String version,
    required String closedCaptions,
    required String deviceId,
    required String dns0,
    required String dns1,
    required String gateway,
    required String mask,
    required String type,
    required String frequency,
    required String linkSpeed,
    required String rssi,
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'Subcommand1': subcommand,
      'PublicIP': publicIp,
      'PrivateIP': privateIp,
      'Interface': interface,
      'Ver': version,
      'CC': closedCaptions,
      'ID': deviceId,
      'DNS0': dns0,
      'DNS1': dns1,
      'Gateway': gateway,
      'Mask': mask,
      'Type': type,
      'Frequency': frequency,
      'LinkSpeed': linkSpeed,
      'RSSI': rssi,
    };
    final $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> updateCCFlag({
    String command = 'Function',
    String subcommand = 'UpdateCCstatus',
    required String closedCaptions,
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'Subcommand1': subcommand,
      'CC': closedCaptions,
    };
    final $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
