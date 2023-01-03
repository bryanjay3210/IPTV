import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:iptv/core/models/user_data.dart';
import 'package:iptv/core/repositories/authentication_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends HydratedBloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(ProfileEmpty()) {
    on<ProfileStore>((event, emit) {
      hydrate();

      emit(ProfileUser(event.user));
    });
  }
  final AuthenticationRepository _authenticationRepository;

  @override
  ProfileState fromJson(Map<String, dynamic> json) {
    try {
      final user = ProfileUser(UserData.fromJson(json));

      return user;
    } catch (e) {
      _authenticationRepository.logOut();
      HydratedBlocOverrides.current?.storage
          .delete('ProfileBloc')
          .then((value) {
        throw Exception(e);
      });
      throw Exception(e);
    }
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) {
    try {
      if (state is ProfileUser) {
        return state.user.toJson();
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }
}
