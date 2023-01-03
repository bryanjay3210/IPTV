import 'package:chopper/chopper.dart';

part 'auth_service.chopper.dart';

@ChopperApi()
abstract class AuthService extends ChopperService {
  static AuthService create([ChopperClient? client]) => _$AuthService(client);

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> authenticate({
    @Query('cmd') String command = 'auth',
    @Query() required String username,
    @Query() required String password,
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> registrationCheck({
    @Query('cmd') String command = 'STBRegCheck',
    @Query('MAC') required String id,
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> registerOauth({
    @Query('cmd') String command = 'STBRegOauth',
    @Query('MAC') required String id,
    @Query('Hash') required String hash,
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> sendCode({
    @Query('cmd') String command = 'STBStore4-4',
    @Query('MAC') required String id,
    @Query('4-4') required String code,
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> bindCodeToUser({
    @Query('cmd') String command = 'STBBind',
    @Query('4-4') required String code,
    @Query('cid') required String customerId,
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> fetchLastKnownStatus({
    @Query('cmd') String command = 'Function',
    @Query('Subcommand1') String subcommand = 'Status',
    @Query('androidID') required String id,
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> sendDeviceStatus({
    @Query('cmd') String command = 'Function',
    @Query('Subcommand1') String subcommand = 'UpdateSTBStatus',
    @Query('PublicIP') required String publicIp,
    @Query('PrivateIP') required String privateIp,
    @Query('Interface') required String interface,
    @Query('Ver') required String version,
    @Query('CC') required String closedCaptions,
    @Query('ID') required String deviceId,
    @Query('DNS0') required String dns0,
    @Query('DNS1') required String dns1,
    @Query('Gateway') required String gateway,
    @Query('Mask') required String mask,
    @Query('Type') required String type,
    @Query('Frequency') required String frequency,
    @Query('LinkSpeed') required String linkSpeed,
    @Query('RSSI') required String rssi,
  });

  @Post(optionalBody: true)
  Future<Response<Map<String, dynamic>>> updateCCFlag({
    @Query('cmd') String command = 'Function',
    @Query('Subcommand1') String subcommand = 'UpdateCCstatus',
    @Query('CC') required String closedCaptions,
  });
}
