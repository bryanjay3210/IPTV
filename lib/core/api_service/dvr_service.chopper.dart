// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dvr_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$DVRService extends DVRService {
  _$DVRService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = DVRService;

  @override
  Future<Response<Map<String, dynamic>>> getRecordingList(
      {String command = 'PVRList'}) {
    final $url = '';
    final $params = <String, dynamic>{'cmd': command};
    final $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getSeriesRecordingList({
    String command = 'ListSeries',
    String series = '',
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'Series': series,
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
  Future<Response<Map<String, dynamic>>> recordProgram({
    String command = 'RecordNow',
    required String channel,
    required String epgShowId,
    required String timecode,
    String keepuntil = '1',
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'Channel': channel,
      'Showid': epgShowId,
      'timecode': timecode,
      'keepuntil': keepuntil,
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
  Future<Response<Map<String, dynamic>>> recordSeries({
    String command = 'RecSeries',
    required String epgSeriesId,
    required String epgShowId,
    required String epgChannelId,
    String onlyNew = 'Y',
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'SeriesID': epgSeriesId,
      'Showid': epgShowId,
      'EpgChannelID': epgChannelId,
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
  Future<Response<Map<String, dynamic>>> stopRecordingProgram({
    String command = 'DontRecordPend',
    required String epgChannelId,
    required String epgShowId,
    required String timecode,
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'Channel': epgChannelId,
      'Showid': epgShowId,
      'timecode': timecode,
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
  Future<Response<Map<String, dynamic>>> stopRecordingSeries({
    String command = 'DontRecordSeries',
    required String epgSeriesId,
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'Series': epgSeriesId,
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
  Future<Response<Map<String, dynamic>>> deleteRecording({
    String command = 'RemoveNow',
    required String channelTblRowId,
    required String epgShowId,
    required String timecode,
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'Channel': channelTblRowId,
      'Showid': epgShowId,
      'timecode': timecode,
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
  Future<Response<Map<String, dynamic>>> storageStats(
      {String command = 'Stats'}) {
    final $url = '';
    final $params = <String, dynamic>{'cmd': command};
    final $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getPlaybackRecording({
    String command = 'PlayBack',
    required String channelTblRowId,
    required String epgShowId,
    required String timecode,
  }) {
    final $url = '';
    final $params = <String, dynamic>{
      'cmd': command,
      'Channel': channelTblRowId,
      'Showid': epgShowId,
      'timecode': timecode,
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
