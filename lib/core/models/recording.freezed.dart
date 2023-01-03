// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'recording.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Recording _$RecordingFromJson(Map<String, dynamic> json) {
  return _Recording.fromJson(json);
}

/// @nodoc
mixin _$Recording {
  @JsonKey(name: 'ProgramTblRowID')
  String get programTblRowId => throw _privateConstructorUsedError;
  @JsonKey(name: 'ChannelTblRowID')
  String get channelTblRowId =>
      throw _privateConstructorUsedError; // @JsonKey(name: 'GuideChannel') required String guideChannel,
  @JsonKey(name: 'EPGShowID')
  String get epgShowId => throw _privateConstructorUsedError;
  @JsonKey(name: 'EPGSeriesID')
  String get epgSeriesId => throw _privateConstructorUsedError;
  @JsonKey(name: 'ProgramStartTime')
  String get programStartTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'ProgramStopTime')
  String get programStopTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'ProgramNew')
  String get programNew => throw _privateConstructorUsedError;
  @JsonKey(name: 'EPGChannelID')
  String get epgChannelId =>
      throw _privateConstructorUsedError; // @JsonKey(name: 'PreviousShowing') required String previousShowing,
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramTitle')
  String get programTitle => throw _privateConstructorUsedError;
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramDescription')
  String get programDescription =>
      throw _privateConstructorUsedError; // @JsonKey(name: 'ProgramRating') required dynamic programRating,
// @JsonKey(name: 'ProgramLanguage') required String programLanguage,
// @JsonKey(name: 'ProgramDescriptiveVideo')
//     required String programDescriptiveVideo,
// @JsonKey(name: 'ProgramChannel') required String programChannel,
// @JsonKey(name: 'ProgramCategory') required String programCategory,
  @JsonKey(name: 'KeepValue')
  String get keepValue => throw _privateConstructorUsedError;
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ChannelIconURL')
  String get channelIconURL => throw _privateConstructorUsedError;
  @EmptyMapToStringConverter()
  @JsonKey(name: 'EPGSeasonNum')
  String get epgSeasonNum => throw _privateConstructorUsedError;
  @YNConverter()
  @JsonKey(name: 'SeriesRecord')
  bool get seriesRecord => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecordingCopyWith<Recording> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordingCopyWith<$Res> {
  factory $RecordingCopyWith(Recording value, $Res Function(Recording) then) =
      _$RecordingCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'ProgramTblRowID')
          String programTblRowId,
      @JsonKey(name: 'ChannelTblRowID')
          String channelTblRowId,
      @JsonKey(name: 'EPGShowID')
          String epgShowId,
      @JsonKey(name: 'EPGSeriesID')
          String epgSeriesId,
      @JsonKey(name: 'ProgramStartTime')
          String programStartTime,
      @JsonKey(name: 'ProgramStopTime')
          String programStopTime,
      @JsonKey(name: 'ProgramNew')
          String programNew,
      @JsonKey(name: 'EPGChannelID')
          String epgChannelId,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramTitle')
          String programTitle,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramDescription')
          String programDescription,
      @JsonKey(name: 'KeepValue')
          String keepValue,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ChannelIconURL')
          String channelIconURL,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'EPGSeasonNum')
          String epgSeasonNum,
      @YNConverter()
      @JsonKey(name: 'SeriesRecord')
          bool seriesRecord});
}

/// @nodoc
class _$RecordingCopyWithImpl<$Res> implements $RecordingCopyWith<$Res> {
  _$RecordingCopyWithImpl(this._value, this._then);

  final Recording _value;
  // ignore: unused_field
  final $Res Function(Recording) _then;

  @override
  $Res call({
    Object? programTblRowId = freezed,
    Object? channelTblRowId = freezed,
    Object? epgShowId = freezed,
    Object? epgSeriesId = freezed,
    Object? programStartTime = freezed,
    Object? programStopTime = freezed,
    Object? programNew = freezed,
    Object? epgChannelId = freezed,
    Object? programTitle = freezed,
    Object? programDescription = freezed,
    Object? keepValue = freezed,
    Object? channelIconURL = freezed,
    Object? epgSeasonNum = freezed,
    Object? seriesRecord = freezed,
  }) {
    return _then(_value.copyWith(
      programTblRowId: programTblRowId == freezed
          ? _value.programTblRowId
          : programTblRowId // ignore: cast_nullable_to_non_nullable
              as String,
      channelTblRowId: channelTblRowId == freezed
          ? _value.channelTblRowId
          : channelTblRowId // ignore: cast_nullable_to_non_nullable
              as String,
      epgShowId: epgShowId == freezed
          ? _value.epgShowId
          : epgShowId // ignore: cast_nullable_to_non_nullable
              as String,
      epgSeriesId: epgSeriesId == freezed
          ? _value.epgSeriesId
          : epgSeriesId // ignore: cast_nullable_to_non_nullable
              as String,
      programStartTime: programStartTime == freezed
          ? _value.programStartTime
          : programStartTime // ignore: cast_nullable_to_non_nullable
              as String,
      programStopTime: programStopTime == freezed
          ? _value.programStopTime
          : programStopTime // ignore: cast_nullable_to_non_nullable
              as String,
      programNew: programNew == freezed
          ? _value.programNew
          : programNew // ignore: cast_nullable_to_non_nullable
              as String,
      epgChannelId: epgChannelId == freezed
          ? _value.epgChannelId
          : epgChannelId // ignore: cast_nullable_to_non_nullable
              as String,
      programTitle: programTitle == freezed
          ? _value.programTitle
          : programTitle // ignore: cast_nullable_to_non_nullable
              as String,
      programDescription: programDescription == freezed
          ? _value.programDescription
          : programDescription // ignore: cast_nullable_to_non_nullable
              as String,
      keepValue: keepValue == freezed
          ? _value.keepValue
          : keepValue // ignore: cast_nullable_to_non_nullable
              as String,
      channelIconURL: channelIconURL == freezed
          ? _value.channelIconURL
          : channelIconURL // ignore: cast_nullable_to_non_nullable
              as String,
      epgSeasonNum: epgSeasonNum == freezed
          ? _value.epgSeasonNum
          : epgSeasonNum // ignore: cast_nullable_to_non_nullable
              as String,
      seriesRecord: seriesRecord == freezed
          ? _value.seriesRecord
          : seriesRecord // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_RecordingCopyWith<$Res> implements $RecordingCopyWith<$Res> {
  factory _$$_RecordingCopyWith(
          _$_Recording value, $Res Function(_$_Recording) then) =
      __$$_RecordingCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'ProgramTblRowID')
          String programTblRowId,
      @JsonKey(name: 'ChannelTblRowID')
          String channelTblRowId,
      @JsonKey(name: 'EPGShowID')
          String epgShowId,
      @JsonKey(name: 'EPGSeriesID')
          String epgSeriesId,
      @JsonKey(name: 'ProgramStartTime')
          String programStartTime,
      @JsonKey(name: 'ProgramStopTime')
          String programStopTime,
      @JsonKey(name: 'ProgramNew')
          String programNew,
      @JsonKey(name: 'EPGChannelID')
          String epgChannelId,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramTitle')
          String programTitle,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramDescription')
          String programDescription,
      @JsonKey(name: 'KeepValue')
          String keepValue,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ChannelIconURL')
          String channelIconURL,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'EPGSeasonNum')
          String epgSeasonNum,
      @YNConverter()
      @JsonKey(name: 'SeriesRecord')
          bool seriesRecord});
}

/// @nodoc
class __$$_RecordingCopyWithImpl<$Res> extends _$RecordingCopyWithImpl<$Res>
    implements _$$_RecordingCopyWith<$Res> {
  __$$_RecordingCopyWithImpl(
      _$_Recording _value, $Res Function(_$_Recording) _then)
      : super(_value, (v) => _then(v as _$_Recording));

  @override
  _$_Recording get _value => super._value as _$_Recording;

  @override
  $Res call({
    Object? programTblRowId = freezed,
    Object? channelTblRowId = freezed,
    Object? epgShowId = freezed,
    Object? epgSeriesId = freezed,
    Object? programStartTime = freezed,
    Object? programStopTime = freezed,
    Object? programNew = freezed,
    Object? epgChannelId = freezed,
    Object? programTitle = freezed,
    Object? programDescription = freezed,
    Object? keepValue = freezed,
    Object? channelIconURL = freezed,
    Object? epgSeasonNum = freezed,
    Object? seriesRecord = freezed,
  }) {
    return _then(_$_Recording(
      programTblRowId: programTblRowId == freezed
          ? _value.programTblRowId
          : programTblRowId // ignore: cast_nullable_to_non_nullable
              as String,
      channelTblRowId: channelTblRowId == freezed
          ? _value.channelTblRowId
          : channelTblRowId // ignore: cast_nullable_to_non_nullable
              as String,
      epgShowId: epgShowId == freezed
          ? _value.epgShowId
          : epgShowId // ignore: cast_nullable_to_non_nullable
              as String,
      epgSeriesId: epgSeriesId == freezed
          ? _value.epgSeriesId
          : epgSeriesId // ignore: cast_nullable_to_non_nullable
              as String,
      programStartTime: programStartTime == freezed
          ? _value.programStartTime
          : programStartTime // ignore: cast_nullable_to_non_nullable
              as String,
      programStopTime: programStopTime == freezed
          ? _value.programStopTime
          : programStopTime // ignore: cast_nullable_to_non_nullable
              as String,
      programNew: programNew == freezed
          ? _value.programNew
          : programNew // ignore: cast_nullable_to_non_nullable
              as String,
      epgChannelId: epgChannelId == freezed
          ? _value.epgChannelId
          : epgChannelId // ignore: cast_nullable_to_non_nullable
              as String,
      programTitle: programTitle == freezed
          ? _value.programTitle
          : programTitle // ignore: cast_nullable_to_non_nullable
              as String,
      programDescription: programDescription == freezed
          ? _value.programDescription
          : programDescription // ignore: cast_nullable_to_non_nullable
              as String,
      keepValue: keepValue == freezed
          ? _value.keepValue
          : keepValue // ignore: cast_nullable_to_non_nullable
              as String,
      channelIconURL: channelIconURL == freezed
          ? _value.channelIconURL
          : channelIconURL // ignore: cast_nullable_to_non_nullable
              as String,
      epgSeasonNum: epgSeasonNum == freezed
          ? _value.epgSeasonNum
          : epgSeasonNum // ignore: cast_nullable_to_non_nullable
              as String,
      seriesRecord: seriesRecord == freezed
          ? _value.seriesRecord
          : seriesRecord // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Recording implements _Recording {
  _$_Recording(
      {@JsonKey(name: 'ProgramTblRowID')
          required this.programTblRowId,
      @JsonKey(name: 'ChannelTblRowID')
          required this.channelTblRowId,
      @JsonKey(name: 'EPGShowID')
          required this.epgShowId,
      @JsonKey(name: 'EPGSeriesID')
          required this.epgSeriesId,
      @JsonKey(name: 'ProgramStartTime')
          required this.programStartTime,
      @JsonKey(name: 'ProgramStopTime')
          required this.programStopTime,
      @JsonKey(name: 'ProgramNew')
          required this.programNew,
      @JsonKey(name: 'EPGChannelID')
          required this.epgChannelId,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramTitle')
          required this.programTitle,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramDescription')
          required this.programDescription,
      @JsonKey(name: 'KeepValue')
          required this.keepValue,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ChannelIconURL')
          required this.channelIconURL,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'EPGSeasonNum')
          required this.epgSeasonNum,
      @YNConverter()
      @JsonKey(name: 'SeriesRecord')
          required this.seriesRecord});

  factory _$_Recording.fromJson(Map<String, dynamic> json) =>
      _$$_RecordingFromJson(json);

  @override
  @JsonKey(name: 'ProgramTblRowID')
  final String programTblRowId;
  @override
  @JsonKey(name: 'ChannelTblRowID')
  final String channelTblRowId;
// @JsonKey(name: 'GuideChannel') required String guideChannel,
  @override
  @JsonKey(name: 'EPGShowID')
  final String epgShowId;
  @override
  @JsonKey(name: 'EPGSeriesID')
  final String epgSeriesId;
  @override
  @JsonKey(name: 'ProgramStartTime')
  final String programStartTime;
  @override
  @JsonKey(name: 'ProgramStopTime')
  final String programStopTime;
  @override
  @JsonKey(name: 'ProgramNew')
  final String programNew;
  @override
  @JsonKey(name: 'EPGChannelID')
  final String epgChannelId;
// @JsonKey(name: 'PreviousShowing') required String previousShowing,
  @override
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramTitle')
  final String programTitle;
  @override
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramDescription')
  final String programDescription;
// @JsonKey(name: 'ProgramRating') required dynamic programRating,
// @JsonKey(name: 'ProgramLanguage') required String programLanguage,
// @JsonKey(name: 'ProgramDescriptiveVideo')
//     required String programDescriptiveVideo,
// @JsonKey(name: 'ProgramChannel') required String programChannel,
// @JsonKey(name: 'ProgramCategory') required String programCategory,
  @override
  @JsonKey(name: 'KeepValue')
  final String keepValue;
  @override
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ChannelIconURL')
  final String channelIconURL;
  @override
  @EmptyMapToStringConverter()
  @JsonKey(name: 'EPGSeasonNum')
  final String epgSeasonNum;
  @override
  @YNConverter()
  @JsonKey(name: 'SeriesRecord')
  final bool seriesRecord;

  @override
  String toString() {
    return 'Recording(programTblRowId: $programTblRowId, channelTblRowId: $channelTblRowId, epgShowId: $epgShowId, epgSeriesId: $epgSeriesId, programStartTime: $programStartTime, programStopTime: $programStopTime, programNew: $programNew, epgChannelId: $epgChannelId, programTitle: $programTitle, programDescription: $programDescription, keepValue: $keepValue, channelIconURL: $channelIconURL, epgSeasonNum: $epgSeasonNum, seriesRecord: $seriesRecord)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Recording &&
            const DeepCollectionEquality()
                .equals(other.programTblRowId, programTblRowId) &&
            const DeepCollectionEquality()
                .equals(other.channelTblRowId, channelTblRowId) &&
            const DeepCollectionEquality().equals(other.epgShowId, epgShowId) &&
            const DeepCollectionEquality()
                .equals(other.epgSeriesId, epgSeriesId) &&
            const DeepCollectionEquality()
                .equals(other.programStartTime, programStartTime) &&
            const DeepCollectionEquality()
                .equals(other.programStopTime, programStopTime) &&
            const DeepCollectionEquality()
                .equals(other.programNew, programNew) &&
            const DeepCollectionEquality()
                .equals(other.epgChannelId, epgChannelId) &&
            const DeepCollectionEquality()
                .equals(other.programTitle, programTitle) &&
            const DeepCollectionEquality()
                .equals(other.programDescription, programDescription) &&
            const DeepCollectionEquality().equals(other.keepValue, keepValue) &&
            const DeepCollectionEquality()
                .equals(other.channelIconURL, channelIconURL) &&
            const DeepCollectionEquality()
                .equals(other.epgSeasonNum, epgSeasonNum) &&
            const DeepCollectionEquality()
                .equals(other.seriesRecord, seriesRecord));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(programTblRowId),
      const DeepCollectionEquality().hash(channelTblRowId),
      const DeepCollectionEquality().hash(epgShowId),
      const DeepCollectionEquality().hash(epgSeriesId),
      const DeepCollectionEquality().hash(programStartTime),
      const DeepCollectionEquality().hash(programStopTime),
      const DeepCollectionEquality().hash(programNew),
      const DeepCollectionEquality().hash(epgChannelId),
      const DeepCollectionEquality().hash(programTitle),
      const DeepCollectionEquality().hash(programDescription),
      const DeepCollectionEquality().hash(keepValue),
      const DeepCollectionEquality().hash(channelIconURL),
      const DeepCollectionEquality().hash(epgSeasonNum),
      const DeepCollectionEquality().hash(seriesRecord));

  @JsonKey(ignore: true)
  @override
  _$$_RecordingCopyWith<_$_Recording> get copyWith =>
      __$$_RecordingCopyWithImpl<_$_Recording>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecordingToJson(
      this,
    );
  }
}

abstract class _Recording implements Recording {
  factory _Recording(
      {@JsonKey(name: 'ProgramTblRowID')
          required final String programTblRowId,
      @JsonKey(name: 'ChannelTblRowID')
          required final String channelTblRowId,
      @JsonKey(name: 'EPGShowID')
          required final String epgShowId,
      @JsonKey(name: 'EPGSeriesID')
          required final String epgSeriesId,
      @JsonKey(name: 'ProgramStartTime')
          required final String programStartTime,
      @JsonKey(name: 'ProgramStopTime')
          required final String programStopTime,
      @JsonKey(name: 'ProgramNew')
          required final String programNew,
      @JsonKey(name: 'EPGChannelID')
          required final String epgChannelId,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramTitle')
          required final String programTitle,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ProgramDescription')
          required final String programDescription,
      @JsonKey(name: 'KeepValue')
          required final String keepValue,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'ChannelIconURL')
          required final String channelIconURL,
      @EmptyMapToStringConverter()
      @JsonKey(name: 'EPGSeasonNum')
          required final String epgSeasonNum,
      @YNConverter()
      @JsonKey(name: 'SeriesRecord')
          required final bool seriesRecord}) = _$_Recording;

  factory _Recording.fromJson(Map<String, dynamic> json) =
      _$_Recording.fromJson;

  @override
  @JsonKey(name: 'ProgramTblRowID')
  String get programTblRowId;
  @override
  @JsonKey(name: 'ChannelTblRowID')
  String get channelTblRowId;
  @override // @JsonKey(name: 'GuideChannel') required String guideChannel,
  @JsonKey(name: 'EPGShowID')
  String get epgShowId;
  @override
  @JsonKey(name: 'EPGSeriesID')
  String get epgSeriesId;
  @override
  @JsonKey(name: 'ProgramStartTime')
  String get programStartTime;
  @override
  @JsonKey(name: 'ProgramStopTime')
  String get programStopTime;
  @override
  @JsonKey(name: 'ProgramNew')
  String get programNew;
  @override
  @JsonKey(name: 'EPGChannelID')
  String get epgChannelId;
  @override // @JsonKey(name: 'PreviousShowing') required String previousShowing,
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramTitle')
  String get programTitle;
  @override
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ProgramDescription')
  String get programDescription;
  @override // @JsonKey(name: 'ProgramRating') required dynamic programRating,
// @JsonKey(name: 'ProgramLanguage') required String programLanguage,
// @JsonKey(name: 'ProgramDescriptiveVideo')
//     required String programDescriptiveVideo,
// @JsonKey(name: 'ProgramChannel') required String programChannel,
// @JsonKey(name: 'ProgramCategory') required String programCategory,
  @JsonKey(name: 'KeepValue')
  String get keepValue;
  @override
  @EmptyMapToStringConverter()
  @JsonKey(name: 'ChannelIconURL')
  String get channelIconURL;
  @override
  @EmptyMapToStringConverter()
  @JsonKey(name: 'EPGSeasonNum')
  String get epgSeasonNum;
  @override
  @YNConverter()
  @JsonKey(name: 'SeriesRecord')
  bool get seriesRecord;
  @override
  @JsonKey(ignore: true)
  _$$_RecordingCopyWith<_$_Recording> get copyWith =>
      throw _privateConstructorUsedError;
}
