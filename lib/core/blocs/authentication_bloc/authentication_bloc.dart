import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:iptv/core/models/user_data.dart';
import 'package:iptv/core/repositories/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription =
        _authenticationRepository.status.listen((status) async {
      // const storage = FlutterSecureStorage();

      // final dynamic profile =
      //     HydratedBlocOverrides.current?.storage.read('ProfileBloc');

      // final token = await storage.read(key: 'tokenAuth');

      // ignore: avoid_dynamic_calls
      // if (profile != null && (profile.isNotEmpty == true) && token != null) {
      //   profile = profile as Map;
      //   add(const AuthenticationStatusChanged(AuthenticationStatus.isLogin));
      // } else {
      add(
        AuthenticationStatusChanged(
          status,
          user: _authenticationRepository.user,
          token: _authenticationRepository.token,
        ),
      );
      // }
    });

    on<AuthenticationStatusChanged>((event, emit) async {
      emit(await _mapAuthenticationStatusChangedToState(event));
    });

    on<AuthenticationLogoutRequested>((event, emit) async {
      try {
        await HydratedBlocOverrides.current?.storage.delete('ProfileBloc');
        _authenticationRepository.logOut();
      } catch (e) {
        throw Exception(e);
      }
    });

    on<ProfileUpdated>((event, emit) async {
      try {
        _authenticationRepository.user = event.userData;
      } catch (e) {
        throw Exception(e);
      }
    });
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<AuthenticationStatus>? _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription?.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        try {
          await HydratedBlocOverrides.current?.storage.delete('ProfileBloc');
        } catch (e) {
          // no-op
        }

        return const AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        return AuthenticationState.authenticated(event.user!);
      case AuthenticationStatus.isLogin:
        return const AuthenticationState.isLogin();
      case AuthenticationStatus.unknown:
        return const AuthenticationState.unknown();
    }
  }
}
