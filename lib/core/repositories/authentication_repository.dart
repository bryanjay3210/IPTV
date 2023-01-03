// ignore_for_file: avoid_dynamic_calls, inference_failure_on_instance_creation

import 'dart:async';

import 'package:iptv/core/models/user_data.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, isLogin }

class AuthenticationRepository {
  AuthenticationRepository([this.user]);

  UserData? user;
  String? token;

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future.delayed(const Duration(seconds: 7));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn(UserData user) async {
    this.user = user;
    _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() {
    _controller.close();
  }
}
