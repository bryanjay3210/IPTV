import 'package:chopper/chopper.dart';

part 'dvr_service.chopper.dart';

@ChopperApi()
abstract class DVRService extends ChopperService {
  static DVRService create([ChopperClient? client]) => _$DVRService(client);

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> getRecordingList({
    @Query('cmd') String command = 'PVRList',
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> getSeriesRecordingList({
    @Query('cmd') String command = 'ListSeries',
    @Query('Series') String series = '',
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> recordProgram({
    @Query('cmd') String command = 'RecordNow',
    @Query('Channel') required String channel,
    @Query('Showid') required String epgShowId,
    @Query() required String timecode,
    @Query() String keepuntil = '1',
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> recordSeries({
    @Query('cmd') String command = 'RecSeries',
    @Query('SeriesID') required String epgSeriesId,
    @Query('Showid') required String epgShowId,
    @Query('EpgChannelID') required String epgChannelId,
    @Query('OnlyNew') String onlyNew = 'Y',
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> stopRecordingProgram({
    @Query('cmd') String command = 'DontRecordPend',
    @Query('Channel') required String epgChannelId,
    @Query('Showid') required String epgShowId,
    @Query('timecode') required String timecode,
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> stopRecordingSeries({
    @Query('cmd') String command = 'DontRecordSeries',
    @Query('Series') required String epgSeriesId,
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> deleteRecording({
    @Query('cmd') String command = 'RemoveNow',
    @Query('Channel') required String channelTblRowId,
    @Query('Showid') required String epgShowId,
    @Query() required String timecode,
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> storageStats({
    @Query('cmd') String command = 'Stats',
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> getPlaybackRecording({
    @Query('cmd') String command = 'PlayBack',
    @Query('Channel') required String channelTblRowId,
    @Query('Showid') required String epgShowId,
    @Query() required String timecode,
  });
}
