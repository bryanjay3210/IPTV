import 'package:chopper/chopper.dart';

part 'settings_service.chopper.dart';

@ChopperApi()
abstract class SettingsService extends ChopperService {
  static SettingsService create([ChopperClient? client]) =>
      _$SettingsService(client);

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> setSeriesSettings({
    @Query('cmd') String command = 'ChangeSeriesFlags',
    @Query('Series') required String series,
    @Query('OnlyNew') required String onlyNew,
    @Query('keepuntil') required String keepUntil,
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> getSeriesSettings({
    @Query('cmd') String command = 'FetchSeriesFlags',
    @Query('Series') required String seriesId,
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> setStatus({
    @Query('cmd') String command = 'Function',
    @Query('Subcommand1') String subcommand = 'UpdateSTBActive',
    @Query('data') required String data,
  });
}
