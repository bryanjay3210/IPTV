// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'program.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Program _$ProgramFromJson(Map<String, dynamic> json) {
  return _Program.fromJson(json);
}

/// @nodoc
mixin _$Program {
  @JsonKey(name: 'EPGShowID')
  String get epgShowId => throw _privateConstructorUsedError;
  @JsonKey(name: 'EPGSeriesID')
  String get epgSeriesId => throw _privateConstructorUsedError;
  @JsonKey(name: 'EPGSeasonID')
  String get epgSeasonId => throw _privateConstructorUsedError;
  @JsonKey(name: 'EPGSeasonNum')
  String get epgSeasonNum => throw _privateConstructorUsedError;
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramTitle')
  String get programTitle => throw _privateConstructorUsedError;
  @EmptyMapToStringConverter()
  @JsonKey(name: 'PreviousRun')
  String get previousRun => throw _privateConstructorUsedError;
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramLang')
  String get programLang => throw _privateConstructorUsedError;
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramDesc')
  String get programDesc => throw _privateConstructorUsedError;
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramRating')
  String get programRating => throw _privateConstructorUsedError;
  @YNConverter()
  @JsonKey(name: 'IsCurrentlyRecording')
  bool get isCurrentlyRecording => throw _privateConstructorUsedError;
  @EpochConverter()
  @JsonKey(name: 'StartEpoch')
  DateTime get startEpoch => throw _privateConstructorUsedError;
  @EpochConverter()
  @JsonKey(name: 'StopEpoch')
  DateTime get stopEpoch => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProgramCopyWith<Program> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramCopyWith<$Res> {
  factory $ProgramCopyWith(Program value, $Res Function(Program) then) =
      _$ProgramCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'EPGShowID')
          String epgShowId,
      @JsonKey(name: 'EPGSeriesID')
          String epgSeriesId,
      @JsonKey(name: 'EPGSeasonID')
          String epgSeasonId,
      @JsonKey(name: 'EPGSeasonNum')
          String epgSeasonNum,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramTitle')
          String programTitle,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'PreviousRun')
          String previousRun,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramLang')
          String programLang,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramDesc')
          String programDesc,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramRating')
          String programRating,
      @YNConverter()
      @JsonKey(name: 'IsCurrentlyRecording')
          bool isCurrentlyRecording,
      @EpochConverter()
      @JsonKey(name: 'StartEpoch')
          DateTime startEpoch,
      @EpochConverter()
      @JsonKey(name: 'StopEpoch')
          DateTime stopEpoch});
}

/// @nodoc
class _$ProgramCopyWithImpl<$Res> implements $ProgramCopyWith<$Res> {
  _$ProgramCopyWithImpl(this._value, this._then);

  final Program _value;
  // ignore: unused_field
  final $Res Function(Program) _then;

  @override
  $Res call({
    Object? epgShowId = freezed,
    Object? epgSeriesId = freezed,
    Object? epgSeasonId = freezed,
    Object? epgSeasonNum = freezed,
    Object? programTitle = freezed,
    Object? previousRun = freezed,
    Object? programLang = freezed,
    Object? programDesc = freezed,
    Object? programRating = freezed,
    Object? isCurrentlyRecording = freezed,
    Object? startEpoch = freezed,
    Object? stopEpoch = freezed,
  }) {
    return _then(_value.copyWith(
      epgShowId: epgShowId == freezed
          ? _value.epgShowId
          : epgShowId // ignore: cast_nullable_to_non_nullable
              as String,
      epgSeriesId: epgSeriesId == freezed
          ? _value.epgSeriesId
          : epgSeriesId // ignore: cast_nullable_to_non_nullable
              as String,
      epgSeasonId: epgSeasonId == freezed
          ? _value.epgSeasonId
          : epgSeasonId // ignore: cast_nullable_to_non_nullable
              as String,
      epgSeasonNum: epgSeasonNum == freezed
          ? _value.epgSeasonNum
          : epgSeasonNum // ignore: cast_nullable_to_non_nullable
              as String,
      programTitle: programTitle == freezed
          ? _value.programTitle
          : programTitle // ignore: cast_nullable_to_non_nullable
              as String,
      previousRun: previousRun == freezed
          ? _value.previousRun
          : previousRun // ignore: cast_nullable_to_non_nullable
              as String,
      programLang: programLang == freezed
          ? _value.programLang
          : programLang // ignore: cast_nullable_to_non_nullable
              as String,
      programDesc: programDesc == freezed
          ? _value.programDesc
          : programDesc // ignore: cast_nullable_to_non_nullable
              as String,
      programRating: programRating == freezed
          ? _value.programRating
          : programRating // ignore: cast_nullable_to_non_nullable
              as String,
      isCurrentlyRecording: isCurrentlyRecording == freezed
          ? _value.isCurrentlyRecording
          : isCurrentlyRecording // ignore: cast_nullable_to_non_nullable
              as bool,
      startEpoch: startEpoch == freezed
          ? _value.startEpoch
          : startEpoch // ignore: cast_nullable_to_non_nullable
              as DateTime,
      stopEpoch: stopEpoch == freezed
          ? _value.stopEpoch
          : stopEpoch // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$$_ProgramCopyWith<$Res> implements $ProgramCopyWith<$Res> {
  factory _$$_ProgramCopyWith(
          _$_Program value, $Res Function(_$_Program) then) =
      __$$_ProgramCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'EPGShowID')
          String epgShowId,
      @JsonKey(name: 'EPGSeriesID')
          String epgSeriesId,
      @JsonKey(name: 'EPGSeasonID')
          String epgSeasonId,
      @JsonKey(name: 'EPGSeasonNum')
          String epgSeasonNum,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramTitle')
          String programTitle,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'PreviousRun')
          String previousRun,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramLang')
          String programLang,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramDesc')
          String programDesc,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramRating')
          String programRating,
      @YNConverter()
      @JsonKey(name: 'IsCurrentlyRecording')
          bool isCurrentlyRecording,
      @EpochConverter()
      @JsonKey(name: 'StartEpoch')
          DateTime startEpoch,
      @EpochConverter()
      @JsonKey(name: 'StopEpoch')
          DateTime stopEpoch});
}

/// @nodoc
class __$$_ProgramCopyWithImpl<$Res> extends _$ProgramCopyWithImpl<$Res>
    implements _$$_ProgramCopyWith<$Res> {
  __$$_ProgramCopyWithImpl(_$_Program _value, $Res Function(_$_Program) _then)
      : super(_value, (v) => _then(v as _$_Program));

  @override
  _$_Program get _value => super._value as _$_Program;

  @override
  $Res call({
    Object? epgShowId = freezed,
    Object? epgSeriesId = freezed,
    Object? epgSeasonId = freezed,
    Object? epgSeasonNum = freezed,
    Object? programTitle = freezed,
    Object? previousRun = freezed,
    Object? programLang = freezed,
    Object? programDesc = freezed,
    Object? programRating = freezed,
    Object? isCurrentlyRecording = freezed,
    Object? startEpoch = freezed,
    Object? stopEpoch = freezed,
  }) {
    return _then(_$_Program(
      epgShowId: epgShowId == freezed
          ? _value.epgShowId
          : epgShowId // ignore: cast_nullable_to_non_nullable
              as String,
      epgSeriesId: epgSeriesId == freezed
          ? _value.epgSeriesId
          : epgSeriesId // ignore: cast_nullable_to_non_nullable
              as String,
      epgSeasonId: epgSeasonId == freezed
          ? _value.epgSeasonId
          : epgSeasonId // ignore: cast_nullable_to_non_nullable
              as String,
      epgSeasonNum: epgSeasonNum == freezed
          ? _value.epgSeasonNum
          : epgSeasonNum // ignore: cast_nullable_to_non_nullable
              as String,
      programTitle: programTitle == freezed
          ? _value.programTitle
          : programTitle // ignore: cast_nullable_to_non_nullable
              as String,
      previousRun: previousRun == freezed
          ? _value.previousRun
          : previousRun // ignore: cast_nullable_to_non_nullable
              as String,
      programLang: programLang == freezed
          ? _value.programLang
          : programLang // ignore: cast_nullable_to_non_nullable
              as String,
      programDesc: programDesc == freezed
          ? _value.programDesc
          : programDesc // ignore: cast_nullable_to_non_nullable
              as String,
      programRating: programRating == freezed
          ? _value.programRating
          : programRating // ignore: cast_nullable_to_non_nullable
              as String,
      isCurrentlyRecording: isCurrentlyRecording == freezed
          ? _value.isCurrentlyRecording
          : isCurrentlyRecording // ignore: cast_nullable_to_non_nullable
              as bool,
      startEpoch: startEpoch == freezed
          ? _value.startEpoch
          : startEpoch // ignore: cast_nullable_to_non_nullable
              as DateTime,
      stopEpoch: stopEpoch == freezed
          ? _value.stopEpoch
          : stopEpoch // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Program implements _Program {
  _$_Program(
      {@JsonKey(name: 'EPGShowID')
          required this.epgShowId,
      @JsonKey(name: 'EPGSeriesID')
          required this.epgSeriesId,
      @JsonKey(name: 'EPGSeasonID')
          required this.epgSeasonId,
      @JsonKey(name: 'EPGSeasonNum')
          required this.epgSeasonNum,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramTitle')
          required this.programTitle,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'PreviousRun')
          required this.previousRun,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramLang')
          required this.programLang,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramDesc')
          required this.programDesc,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramRating')
          required this.programRating,
      @YNConverter()
      @JsonKey(name: 'IsCurrentlyRecording')
          required this.isCurrentlyRecording,
      @EpochConverter()
      @JsonKey(name: 'StartEpoch')
          required this.startEpoch,
      @EpochConverter()
      @JsonKey(name: 'StopEpoch')
          required this.stopEpoch});

  factory _$_Program.fromJson(Map<String, dynamic> json) =>
      _$$_ProgramFromJson(json);

  @override
  @JsonKey(name: 'EPGShowID')
  final String epgShowId;
  @override
  @JsonKey(name: 'EPGSeriesID')
  final String epgSeriesId;
  @override
  @JsonKey(name: 'EPGSeasonID')
  final String epgSeasonId;
  @override
  @JsonKey(name: 'EPGSeasonNum')
  final String epgSeasonNum;
  @override
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramTitle')
  final String programTitle;
  @override
  @EmptyMapToStringConverter()
  @JsonKey(name: 'PreviousRun')
  final String previousRun;
  @override
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramLang')
  final String programLang;
  @override
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramDesc')
  final String programDesc;
  @override
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramRating')
  final String programRating;
  @override
  @YNConverter()
  @JsonKey(name: 'IsCurrentlyRecording')
  final bool isCurrentlyRecording;
  @override
  @EpochConverter()
  @JsonKey(name: 'StartEpoch')
  final DateTime startEpoch;
  @override
  @EpochConverter()
  @JsonKey(name: 'StopEpoch')
  final DateTime stopEpoch;

  @override
  String toString() {
    return 'Program(epgShowId: $epgShowId, epgSeriesId: $epgSeriesId, epgSeasonId: $epgSeasonId, epgSeasonNum: $epgSeasonNum, programTitle: $programTitle, previousRun: $previousRun, programLang: $programLang, programDesc: $programDesc, programRating: $programRating, isCurrentlyRecording: $isCurrentlyRecording, startEpoch: $startEpoch, stopEpoch: $stopEpoch)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Program &&
            const DeepCollectionEquality().equals(other.epgShowId, epgShowId) &&
            const DeepCollectionEquality()
                .equals(other.epgSeriesId, epgSeriesId) &&
            const DeepCollectionEquality()
                .equals(other.epgSeasonId, epgSeasonId) &&
            const DeepCollectionEquality()
                .equals(other.epgSeasonNum, epgSeasonNum) &&
            const DeepCollectionEquality()
                .equals(other.programTitle, programTitle) &&
            const DeepCollectionEquality()
                .equals(other.previousRun, previousRun) &&
            const DeepCollectionEquality()
                .equals(other.programLang, programLang) &&
            const DeepCollectionEquality()
                .equals(other.programDesc, programDesc) &&
            const DeepCollectionEquality()
                .equals(other.programRating, programRating) &&
            const DeepCollectionEquality()
                .equals(other.isCurrentlyRecording, isCurrentlyRecording) &&
            const DeepCollectionEquality()
                .equals(other.startEpoch, startEpoch) &&
            const DeepCollectionEquality().equals(other.stopEpoch, stopEpoch));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(epgShowId),
      const DeepCollectionEquality().hash(epgSeriesId),
      const DeepCollectionEquality().hash(epgSeasonId),
      const DeepCollectionEquality().hash(epgSeasonNum),
      const DeepCollectionEquality().hash(programTitle),
      const DeepCollectionEquality().hash(previousRun),
      const DeepCollectionEquality().hash(programLang),
      const DeepCollectionEquality().hash(programDesc),
      const DeepCollectionEquality().hash(programRating),
      const DeepCollectionEquality().hash(isCurrentlyRecording),
      const DeepCollectionEquality().hash(startEpoch),
      const DeepCollectionEquality().hash(stopEpoch));

  @JsonKey(ignore: true)
  @override
  _$$_ProgramCopyWith<_$_Program> get copyWith =>
      __$$_ProgramCopyWithImpl<_$_Program>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProgramToJson(
      this,
    );
  }
}

abstract class _Program implements Program {
  factory _Program(
      {@JsonKey(name: 'EPGShowID')
          required final String epgShowId,
      @JsonKey(name: 'EPGSeriesID')
          required final String epgSeriesId,
      @JsonKey(name: 'EPGSeasonID')
          required final String epgSeasonId,
      @JsonKey(name: 'EPGSeasonNum')
          required final String epgSeasonNum,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramTitle')
          required final String programTitle,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'PreviousRun')
          required final String previousRun,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramLang')
          required final String programLang,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramDesc')
          required final String programDesc,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramRating')
          required final String programRating,
      @YNConverter()
      @JsonKey(name: 'IsCurrentlyRecording')
          required final bool isCurrentlyRecording,
      @EpochConverter()
      @JsonKey(name: 'StartEpoch')
          required final DateTime startEpoch,
      @EpochConverter()
      @JsonKey(name: 'StopEpoch')
          required final DateTime stopEpoch}) = _$_Program;

  factory _Program.fromJson(Map<String, dynamic> json) = _$_Program.fromJson;

  @override
  @JsonKey(name: 'EPGShowID')
  String get epgShowId;
  @override
  @JsonKey(name: 'EPGSeriesID')
  String get epgSeriesId;
  @override
  @JsonKey(name: 'EPGSeasonID')
  String get epgSeasonId;
  @override
  @JsonKey(name: 'EPGSeasonNum')
  String get epgSeasonNum;
  @override
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramTitle')
  String get programTitle;
  @override
  @EmptyMapToStringConverter()
  @JsonKey(name: 'PreviousRun')
  String get previousRun;
  @override
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramLang')
  String get programLang;
  @override
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramDesc')
  String get programDesc;
  @override
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramRating')
  String get programRating;
  @override
  @YNConverter()
  @JsonKey(name: 'IsCurrentlyRecording')
  bool get isCurrentlyRecording;
  @override
  @EpochConverter()
  @JsonKey(name: 'StartEpoch')
  DateTime get startEpoch;
  @override
  @EpochConverter()
  @JsonKey(name: 'StopEpoch')
  DateTime get stopEpoch;
  @override
  @JsonKey(ignore: true)
  _$$_ProgramCopyWith<_$_Program> get copyWith =>
      throw _privateConstructorUsedError;
}
