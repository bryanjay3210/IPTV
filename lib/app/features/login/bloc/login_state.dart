part of 'login_bloc.dart';

class LoginState {}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class UnregisteredLoginState extends LoginState {}

class SuspendedLoginState extends LoginState {
  SuspendedLoginState(
    this.customerId,
    this.user,
  );

  final String customerId;
  final UserData user;
}

class WaitingLoginState extends LoginState {
  WaitingLoginState(this.code);

  final String code;
}

class ErrorLoginState extends LoginState {
  ErrorLoginState(this.message);

  final String message;
}
