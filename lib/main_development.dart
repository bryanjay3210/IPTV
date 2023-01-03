import 'package:iptv/app/app.dart';
import 'package:iptv/bootstrap.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/repositories/authentication_repository.dart';

void main() {
  DeviceId.isProduction = true;

  final authenticationRepository = AuthenticationRepository();

  bootstrap(
    () => App(authenticationRepository: authenticationRepository),
    authenticationRepository: authenticationRepository,
  );
}
