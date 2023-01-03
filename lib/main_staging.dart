import 'package:iptv/app/app.dart';
import 'package:iptv/bootstrap.dart';
import 'package:iptv/core/repositories/authentication_repository.dart';

void main() {
  final authenticationRepository = AuthenticationRepository();

  bootstrap(
    () => App(authenticationRepository: authenticationRepository),
    authenticationRepository: authenticationRepository,
    url: 'http://devdvr.acebill.net:8088/api/dvrapi.php',
  );
}
