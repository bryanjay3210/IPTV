part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class InitiateLogin extends LoginEvent {}

class RegisterDevice extends LoginEvent {}

class CheckForRegistration extends LoginEvent {}
