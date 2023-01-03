// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recording.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Recording _$$_RecordingFromJson(Map<String, dynamic> json) => _$_Recording(
      programTblRowId: json['ProgramTblRowID'] as String,
      channelTblRowId: json['ChannelTblRowID'] as String,
      epgShowId: json['EPGShowID'] as String,
      epgSeriesId: json['EPGSeriesID'] as String,
      programStartTime: json['ProgramStartTime'] as String,
      programStopTime: json['ProgramStopTime'] as String,
      programNew: json['ProgramNew'] as String,
      epgChannelId: json['EPGChannelID'] as String,
      programTitle: const EmptyMapToStringConverter()
          .fromJson(json['ProgramTitle'] as Object),
      programDescription: const EmptyMapToStringConverter()
          .fromJson(json['ProgramDescription'] as Object),
      keepValue: json['KeepValue'] as String,
      channelIconURL: const EmptyMapToStringConverter()
          .fromJson(json['ChannelIconURL'] as Object),
      epgSeasonNum: const EmptyMapToStringConverter()
          .fromJson(json['EPGSeasonNum'] as Object),
      seriesRecord:
          const YNConverter().fromJson(json['SeriesRecord'] as String),
    );

Map<String, dynamic> _$$_RecordingToJson(_$_Recording instance) =>
    <String, dynamic>{
      'ProgramTblRowID': instance.programTblRowId,
      'ChannelTblRowID': instance.channelTblRowId,
      'EPGShowID': instance.epgShowId,
      'EPGSeriesID': instance.epgSeriesId,
      'ProgramStartTime': instance.programStartTime,
      'ProgramStopTime': instance.programStopTime,
      'ProgramNew': instance.programNew,
      'EPGChannelID': instance.epgChannelId,
      'ProgramTitle':
          const EmptyMapToStringConverter().toJson(instance.programTitle),
      'ProgramDescription':
          const EmptyMapToStringConverter().toJson(instance.programDescription),
      'KeepValue': instance.keepValue,
      'ChannelIconURL':
          const EmptyMapToStringConverter().toJson(instance.channelIconURL),
      'EPGSeasonNum':
          const EmptyMapToStringConverter().toJson(instance.epgSeasonNum),
      'SeriesRecord': const YNConverter().toJson(instance.seriesRecord),
    };
