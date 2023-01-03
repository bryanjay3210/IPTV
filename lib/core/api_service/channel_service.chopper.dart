// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$ChannelService extends ChannelService {
  _$ChannelService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ChannelService;

  @override
  Future<Response<Map<String, dynamic>>> actionFavorite({
    String command = 'favorites',
    required String action,
    required String channelId,
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'action': action,
      'channel': channelId,
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
  Future<Response<Map<String, dynamic>>> programSearch({
    String command = 'Search',
    required String title,
    String onlyNew = 'N',
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'Title': title,
      'OnlyNew': onlyNew,
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
  Future<Response<Map<String, dynamic>>> channels({
    String command = 'FetchCustomerEPG',
    required String startTimeCode,
    required String stopTimeCode,
    String startChannel = '',
    String numChans = '',
    String showPrograms = 'Y',
    String numHours = '',
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'startTimeCode': startTimeCode,
      'stopTimeCode': stopTimeCode,
      'startChannel': startChannel,
      'numChans': numChans,
      'ShowPrograms': showPrograms,
      'numHours': numHours,
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
  Future<Response<Map<String, dynamic>>> commonAreaList({
    String command = 'Channel',
    String subcommand = 'CommonAreaList',
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'Subcommand1': subcommand,
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
