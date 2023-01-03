part of 'mosquitto_bloc.dart';

@freezed
class MosquittoState with _$MosquittoState {
  const factory MosquittoState.initial() = _Initial;
  const factory MosquittoState.loading() = _Loading;
  const factory MosquittoState.error(String error) = _Error;
  const factory MosquittoState.loaded() = _Loaded;
}
