// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'series_recording.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SeriesRecording _$SeriesRecordingFromJson(Map<String, dynamic> json) {
  return _SeriesRecording.fromJson(json);
}

/// @nodoc
mixin _$SeriesRecording {
  @JsonKey(name: 'Name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'Episodes')
  Map<String, dynamic> get episode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SeriesRecordingCopyWith<SeriesRecording> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeriesRecordingCopyWith<$Res> {
  factory $SeriesRecordingCopyWith(
          SeriesRecording value, $Res Function(SeriesRecording) then) =
      _$SeriesRecordingCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'Name') String name,
      @JsonKey(name: 'Episodes') Map<String, dynamic> episode});
}

/// @nodoc
class _$SeriesRecordingCopyWithImpl<$Res>
    implements $SeriesRecordingCopyWith<$Res> {
  _$SeriesRecordingCopyWithImpl(this._value, this._then);

  final SeriesRecording _value;
  // ignore: unused_field
  final $Res Function(SeriesRecording) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? episode = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      episode: episode == freezed
          ? _value.episode
          : episode // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$$_SeriesRecordingCopyWith<$Res>
    implements $SeriesRecordingCopyWith<$Res> {
  factory _$$_SeriesRecordingCopyWith(
          _$_SeriesRecording value, $Res Function(_$_SeriesRecording) then) =
      __$$_SeriesRecordingCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'Name') String name,
      @JsonKey(name: 'Episodes') Map<String, dynamic> episode});
}

/// @nodoc
class __$$_SeriesRecordingCopyWithImpl<$Res>
    extends _$SeriesRecordingCopyWithImpl<$Res>
    implements _$$_SeriesRecordingCopyWith<$Res> {
  __$$_SeriesRecordingCopyWithImpl(
      _$_SeriesRecording _value, $Res Function(_$_SeriesRecording) _then)
      : super(_value, (v) => _then(v as _$_SeriesRecording));

  @override
  _$_SeriesRecording get _value => super._value as _$_SeriesRecording;

  @override
  $Res call({
    Object? name = freezed,
    Object? episode = freezed,
  }) {
    return _then(_$_SeriesRecording(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      episode: episode == freezed
          ? _value.episode
          : episode // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SeriesRecording implements _SeriesRecording {
  _$_SeriesRecording(
      {@JsonKey(name: 'Name') required this.name,
      @JsonKey(name: 'Episodes') required this.episode});

  factory _$_SeriesRecording.fromJson(Map<String, dynamic> json) =>
      _$$_SeriesRecordingFromJson(json);

  @override
  @JsonKey(name: 'Name')
  final String name;
  @override
  @JsonKey(name: 'Episodes')
  final Map<String, dynamic> episode;

  @override
  String toString() {
    return 'SeriesRecording(name: $name, episode: $episode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SeriesRecording &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.episode, episode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(episode));

  @JsonKey(ignore: true)
  @override
  _$$_SeriesRecordingCopyWith<_$_SeriesRecording> get copyWith =>
      __$$_SeriesRecordingCopyWithImpl<_$_SeriesRecording>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SeriesRecordingToJson(
      this,
    );
  }
}

abstract class _SeriesRecording implements SeriesRecording {
  factory _SeriesRecording(
      {@JsonKey(name: 'Name')
          required final String name,
      @JsonKey(name: 'Episodes')
          required final Map<String, dynamic> episode}) = _$_SeriesRecording;

  factory _SeriesRecording.fromJson(Map<String, dynamic> json) =
      _$_SeriesRecording.fromJson;

  @override
  @JsonKey(name: 'Name')
  String get name;
  @override
  @JsonKey(name: 'Episodes')
  Map<String, dynamic> get episode;
  @override
  @JsonKey(ignore: true)
  _$$_SeriesRecordingCopyWith<_$_SeriesRecording> get copyWith =>
      throw _privateConstructorUsedError;
}
