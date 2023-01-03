part of 'mosquitto_bloc.dart';

@freezed
class MosquittoEvent with _$MosquittoEvent {
  const factory MosquittoEvent.started(
    UserData user,
  ) = _Started;
  const factory MosquittoEvent.check() = _Check;
}
