// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$SettingsService extends SettingsService {
  _$SettingsService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = SettingsService;

  @override
  Future<Response<Map<String, dynamic>>> setSeriesSettings({
    String command = 'ChangeSeriesFlags',
    required String series,
    required String onlyNew,
    required String keepUntil,
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'Series': series,
      'OnlyNew': onlyNew,
      'keepuntil': keepUntil,
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
  Future<Response<Map<String, dynamic>>> getSeriesSettings({
    String command = 'FetchSeriesFlags',
    required String seriesId,
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'Series': seriesId,
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
  Future<Response<Map<String, dynamic>>> setStatus({
    String command = 'Function',
    String subcommand = 'UpdateSTBActive',
    required String data,
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'Subcommand1': subcommand,
      'data': data,
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
