// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'channel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Channel _$ChannelFromJson(Map<String, dynamic> json) {
  return _Channel.fromJson(json);
}

/// @nodoc
mixin _$Channel {
  @JsonKey(name: 'EPGChannelID')
  String get epgChannelId => throw _privateConstructorUsedError;
  @JsonKey(name: 'ChannelRowID')
  String get channelRowId => throw _privateConstructorUsedError;
  @JsonKey(name: 'GuideChannelNum')
  String get guideChannelNum => throw _privateConstructorUsedError;
  @JsonKey(name: 'IconURL')
  String get iconUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'StreamURL')
  String get streamUrl => throw _privateConstructorUsedError;
  @TFConverter()
  @JsonKey(name: 'DVREnabled')
  bool get dvrEnabled => throw _privateConstructorUsedError;
  @YNConverter()
  @JsonKey(name: 'IsFavorite')
  bool get isFavorite => throw _privateConstructorUsedError;
  @GenreConverter()
  @JsonKey(name: 'GenreName')
  String get genreName => throw _privateConstructorUsedError;
  @JsonKey(name: 'ChannelName')
  String get channelName => throw _privateConstructorUsedError;
  @EmptyMapToSingleProgramListConverter()
  @JsonKey(name: 'Programs')
  List<Program>? get programs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChannelCopyWith<Channel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelCopyWith<$Res> {
  factory $ChannelCopyWith(Channel value, $Res Function(Channel) then) =
      _$ChannelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'EPGChannelID')
          String epgChannelId,
      @JsonKey(name: 'ChannelRowID')
          String channelRowId,
      @JsonKey(name: 'GuideChannelNum')
          String guideChannelNum,
      @JsonKey(name: 'IconURL')
          String iconUrl,
      @JsonKey(name: 'StreamURL')
          String streamUrl,
      @TFConverter()
      @JsonKey(name: 'DVREnabled')
          bool dvrEnabled,
      @YNConverter()
      @JsonKey(name: 'IsFavorite')
          bool isFavorite,
      @GenreConverter()
      @JsonKey(name: 'GenreName')
          String genreName,
      @JsonKey(name: 'ChannelName')
          String channelName,
      @EmptyMapToSingleProgramListConverter()
      @JsonKey(name: 'Programs')
          List<Program>? programs});
}

/// @nodoc
class _$ChannelCopyWithImpl<$Res> implements $ChannelCopyWith<$Res> {
  _$ChannelCopyWithImpl(this._value, this._then);

  final Channel _value;
  // ignore: unused_field
  final $Res Function(Channel) _then;

  @override
  $Res call({
    Object? epgChannelId = freezed,
    Object? channelRowId = freezed,
    Object? guideChannelNum = freezed,
    Object? iconUrl = freezed,
    Object? streamUrl = freezed,
    Object? dvrEnabled = freezed,
    Object? isFavorite = freezed,
    Object? genreName = freezed,
    Object? channelName = freezed,
    Object? programs = freezed,
  }) {
    return _then(_value.copyWith(
      epgChannelId: epgChannelId == freezed
          ? _value.epgChannelId
          : epgChannelId // ignore: cast_nullable_to_non_nullable
              as String,
      channelRowId: channelRowId == freezed
          ? _value.channelRowId
          : channelRowId // ignore: cast_nullable_to_non_nullable
              as String,
      guideChannelNum: guideChannelNum == freezed
          ? _value.guideChannelNum
          : guideChannelNum // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: iconUrl == freezed
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      streamUrl: streamUrl == freezed
          ? _value.streamUrl
          : streamUrl // ignore: cast_nullable_to_non_nullable
              as String,
      dvrEnabled: dvrEnabled == freezed
          ? _value.dvrEnabled
          : dvrEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavorite: isFavorite == freezed
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      genreName: genreName == freezed
          ? _value.genreName
          : genreName // ignore: cast_nullable_to_non_nullable
              as String,
      channelName: channelName == freezed
          ? _value.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
              as String,
      programs: programs == freezed
          ? _value.programs
          : programs // ignore: cast_nullable_to_non_nullable
              as List<Program>?,
    ));
  }
}

/// @nodoc
abstract class _$$_ChannelCopyWith<$Res> implements $ChannelCopyWith<$Res> {
  factory _$$_ChannelCopyWith(
          _$_Channel value, $Res Function(_$_Channel) then) =
      __$$_ChannelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'EPGChannelID')
          String epgChannelId,
      @JsonKey(name: 'ChannelRowID')
          String channelRowId,
      @JsonKey(name: 'GuideChannelNum')
          String guideChannelNum,
      @JsonKey(name: 'IconURL')
          String iconUrl,
      @JsonKey(name: 'StreamURL')
          String streamUrl,
      @TFConverter()
      @JsonKey(name: 'DVREnabled')
          bool dvrEnabled,
      @YNConverter()
      @JsonKey(name: 'IsFavorite')
          bool isFavorite,
      @GenreConverter()
      @JsonKey(name: 'GenreName')
          String genreName,
      @JsonKey(name: 'ChannelName')
          String channelName,
      @EmptyMapToSingleProgramListConverter()
      @JsonKey(name: 'Programs')
          List<Program>? programs});
}

/// @nodoc
class __$$_ChannelCopyWithImpl<$Res> extends _$ChannelCopyWithImpl<$Res>
    implements _$$_ChannelCopyWith<$Res> {
  __$$_ChannelCopyWithImpl(_$_Channel _value, $Res Function(_$_Channel) _then)
      : super(_value, (v) => _then(v as _$_Channel));

  @override
  _$_Channel get _value => super._value as _$_Channel;

  @override
  $Res call({
    Object? epgChannelId = freezed,
    Object? channelRowId = freezed,
    Object? guideChannelNum = freezed,
    Object? iconUrl = freezed,
    Object? streamUrl = freezed,
    Object? dvrEnabled = freezed,
    Object? isFavorite = freezed,
    Object? genreName = freezed,
    Object? channelName = freezed,
    Object? programs = freezed,
  }) {
    return _then(_$_Channel(
      epgChannelId: epgChannelId == freezed
          ? _value.epgChannelId
          : epgChannelId // ignore: cast_nullable_to_non_nullable
              as String,
      channelRowId: channelRowId == freezed
          ? _value.channelRowId
          : channelRowId // ignore: cast_nullable_to_non_nullable
              as String,
      guideChannelNum: guideChannelNum == freezed
          ? _value.guideChannelNum
          : guideChannelNum // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: iconUrl == freezed
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      streamUrl: streamUrl == freezed
          ? _value.streamUrl
          : streamUrl // ignore: cast_nullable_to_non_nullable
              as String,
      dvrEnabled: dvrEnabled == freezed
          ? _value.dvrEnabled
          : dvrEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavorite: isFavorite == freezed
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      genreName: genreName == freezed
          ? _value.genreName
          : genreName // ignore: cast_nullable_to_non_nullable
              as String,
      channelName: channelName == freezed
          ? _value.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
              as String,
      programs: programs == freezed
          ? _value.programs
          : programs // ignore: cast_nullable_to_non_nullable
              as List<Program>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Channel implements _Channel {
  _$_Channel(
      {@JsonKey(name: 'EPGChannelID')
          required this.epgChannelId,
      @JsonKey(name: 'ChannelRowID')
          required this.channelRowId,
      @JsonKey(name: 'GuideChannelNum')
          required this.guideChannelNum,
      @JsonKey(name: 'IconURL')
          required this.iconUrl,
      @JsonKey(name: 'StreamURL')
          required this.streamUrl,
      @TFConverter()
      @JsonKey(name: 'DVREnabled')
          required this.dvrEnabled,
      @YNConverter()
      @JsonKey(name: 'IsFavorite')
          required this.isFavorite,
      @GenreConverter()
      @JsonKey(name: 'GenreName')
          required this.genreName,
      @JsonKey(name: 'ChannelName')
          required this.channelName,
      @EmptyMapToSingleProgramListConverter()
      @JsonKey(name: 'Programs')
          required this.programs});

  factory _$_Channel.fromJson(Map<String, dynamic> json) =>
      _$$_ChannelFromJson(json);

  @override
  @JsonKey(name: 'EPGChannelID')
  final String epgChannelId;
  @override
  @JsonKey(name: 'ChannelRowID')
  final String channelRowId;
  @override
  @JsonKey(name: 'GuideChannelNum')
  final String guideChannelNum;
  @override
  @JsonKey(name: 'IconURL')
  final String iconUrl;
  @override
  @JsonKey(name: 'StreamURL')
  final String streamUrl;
  @override
  @TFConverter()
  @JsonKey(name: 'DVREnabled')
  final bool dvrEnabled;
  @override
  @YNConverter()
  @JsonKey(name: 'IsFavorite')
  final bool isFavorite;
  @override
  @GenreConverter()
  @JsonKey(name: 'GenreName')
  final String genreName;
  @override
  @JsonKey(name: 'ChannelName')
  final String channelName;
  @override
  @EmptyMapToSingleProgramListConverter()
  @JsonKey(name: 'Programs')
  final List<Program>? programs;

  @override
  String toString() {
    return 'Channel(epgChannelId: $epgChannelId, channelRowId: $channelRowId, guideChannelNum: $guideChannelNum, iconUrl: $iconUrl, streamUrl: $streamUrl, dvrEnabled: $dvrEnabled, isFavorite: $isFavorite, genreName: $genreName, channelName: $channelName, programs: $programs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Channel &&
            const DeepCollectionEquality()
                .equals(other.epgChannelId, epgChannelId) &&
            const DeepCollectionEquality()
                .equals(other.channelRowId, channelRowId) &&
            const DeepCollectionEquality()
                .equals(other.guideChannelNum, guideChannelNum) &&
            const DeepCollectionEquality().equals(other.iconUrl, iconUrl) &&
            const DeepCollectionEquality().equals(other.streamUrl, streamUrl) &&
            const DeepCollectionEquality()
                .equals(other.dvrEnabled, dvrEnabled) &&
            const DeepCollectionEquality()
                .equals(other.isFavorite, isFavorite) &&
            const DeepCollectionEquality().equals(other.genreName, genreName) &&
            const DeepCollectionEquality()
                .equals(other.channelName, channelName) &&
            const DeepCollectionEquality().equals(other.programs, programs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(epgChannelId),
      const DeepCollectionEquality().hash(channelRowId),
      const DeepCollectionEquality().hash(guideChannelNum),
      const DeepCollectionEquality().hash(iconUrl),
      const DeepCollectionEquality().hash(streamUrl),
      const DeepCollectionEquality().hash(dvrEnabled),
      const DeepCollectionEquality().hash(isFavorite),
      const DeepCollectionEquality().hash(genreName),
      const DeepCollectionEquality().hash(channelName),
      const DeepCollectionEquality().hash(programs));

  @JsonKey(ignore: true)
  @override
  _$$_ChannelCopyWith<_$_Channel> get copyWith =>
      __$$_ChannelCopyWithImpl<_$_Channel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChannelToJson(
      this,
    );
  }
}

abstract class _Channel implements Channel {
  factory _Channel(
      {@JsonKey(name: 'EPGChannelID')
          required final String epgChannelId,
      @JsonKey(name: 'ChannelRowID')
          required final String channelRowId,
      @JsonKey(name: 'GuideChannelNum')
          required final String guideChannelNum,
      @JsonKey(name: 'IconURL')
          required final String iconUrl,
      @JsonKey(name: 'StreamURL')
          required final String streamUrl,
      @TFConverter()
      @JsonKey(name: 'DVREnabled')
          required final bool dvrEnabled,
      @YNConverter()
      @JsonKey(name: 'IsFavorite')
          required final bool isFavorite,
      @GenreConverter()
      @JsonKey(name: 'GenreName')
          required final String genreName,
      @JsonKey(name: 'ChannelName')
          required final String channelName,
      @EmptyMapToSingleProgramListConverter()
      @JsonKey(name: 'Programs')
          required final List<Program>? programs}) = _$_Channel;

  factory _Channel.fromJson(Map<String, dynamic> json) = _$_Channel.fromJson;

  @override
  @JsonKey(name: 'EPGChannelID')
  String get epgChannelId;
  @override
  @JsonKey(name: 'ChannelRowID')
  String get channelRowId;
  @override
  @JsonKey(name: 'GuideChannelNum')
  String get guideChannelNum;
  @override
  @JsonKey(name: 'IconURL')
  String get iconUrl;
  @override
  @JsonKey(name: 'StreamURL')
  String get streamUrl;
  @override
  @TFConverter()
  @JsonKey(name: 'DVREnabled')
  bool get dvrEnabled;
  @override
  @YNConverter()
  @JsonKey(name: 'IsFavorite')
  bool get isFavorite;
  @override
  @GenreConverter()
  @JsonKey(name: 'GenreName')
  String get genreName;
  @override
  @JsonKey(name: 'ChannelName')
  String get channelName;
  @override
  @EmptyMapToSingleProgramListConverter()
  @JsonKey(name: 'Programs')
  List<Program>? get programs;
  @override
  @JsonKey(ignore: true)
  _$$_ChannelCopyWith<_$_Channel> get copyWith =>
      throw _privateConstructorUsedError;
}
