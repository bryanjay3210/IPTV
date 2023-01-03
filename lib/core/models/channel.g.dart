// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Channel _$$_ChannelFromJson(Map<String, dynamic> json) => _$_Channel(
      epgChannelId: json['EPGChannelID'] as String,
      channelRowId: json['ChannelRowID'] as String,
      guideChannelNum: json['GuideChannelNum'] as String,
      iconUrl: json['IconURL'] as String,
      streamUrl: json['StreamURL'] as String,
      dvrEnabled: const TFConverter().fromJson(json['DVREnabled'] as String),
      isFavorite: const YNConverter().fromJson(json['IsFavorite'] as String),
      genreName: const GenreConverter().fromJson(json['GenreName'] as Object),
      channelName: json['ChannelName'] as String,
      programs: _$JsonConverterFromJson<Object, List<Program>>(json['Programs'],
          const EmptyMapToSingleProgramListConverter().fromJson),
    );

Map<String, dynamic> _$$_ChannelToJson(_$_Channel instance) =>
    <String, dynamic>{
      'EPGChannelID': instance.epgChannelId,
      'ChannelRowID': instance.channelRowId,
      'GuideChannelNum': instance.guideChannelNum,
      'IconURL': instance.iconUrl,
      'StreamURL': instance.streamUrl,
      'DVREnabled': const TFConverter().toJson(instance.dvrEnabled),
      'IsFavorite': const YNConverter().toJson(instance.isFavorite),
      'GenreName': const GenreConverter().toJson(instance.genreName),
      'ChannelName': instance.channelName,
      'Programs': _$JsonConverterToJson<Object, List<Program>>(
          instance.programs,
          const EmptyMapToSingleProgramListConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
