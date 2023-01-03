import 'package:chopper/chopper.dart';

part 'channel_service.chopper.dart';

@ChopperApi()
abstract class ChannelService extends ChopperService {
  static ChannelService create([ChopperClient? client]) =>
      _$ChannelService(client);

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> actionFavorite({
    @Query('cmd') String command = 'favorites',
    @Query('action') required String action, // Possible values: A, R
    @Query('channel') required String channelId,
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> programSearch({
    @Query('cmd') String command = 'Search',
    @Query('Title') required String title,
    @Query('OnlyNew') String onlyNew = 'N',
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> channels({
    @Query('cmd') String command = 'FetchCustomerEPG',
    @Query() required String startTimeCode,
    @Query() required String stopTimeCode,
    @Query() String startChannel = '',
    @Query() String numChans = '',
    @Query('ShowPrograms') String showPrograms = 'Y',
    @Query() String numHours = '',
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> commonAreaList({
    @Query('cmd') String command = 'Channel',
    @Query('Subcommand1') String subcommand = 'CommonAreaList',
  });
}
