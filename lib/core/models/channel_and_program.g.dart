// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_and_program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChannelAndProgram _$$_ChannelAndProgramFromJson(Map<String, dynamic> json) =>
    _$_ChannelAndProgram(
      programTitle: json['programTitle'] ?? '',
      programDescription: json['programDescription'] ?? '',
      channelName: json['channelName'] ?? '',
      channelId: json['channelId'] ?? '',
      channelTblRowId: json['channelTblRowId'] ?? '',
      seriesId: json['seriesId'] ?? '',
      seasonNum: json['seasonNum'] ?? '',
      isRecorded: json['isRecorded'] ?? '',
      isNewEpisode: json['isNewEpisode'] ?? '',
      showDate: json['showDate'] ?? '',
      showDateEnd: json['showDateEnd'] ?? '',
      programTblRowId: json['programTblRowId'] ?? '',
      showId: json['showId'] ?? '',
      isCurrentlyRecording: json['isCurrentlyRecording'] ?? '',
    );

Map<String, dynamic> _$$_ChannelAndProgramToJson(
        _$_ChannelAndProgram instance) =>
    <String, dynamic>{
      'programTitle': instance.programTitle,
      'programDescription': instance.programDescription,
      'channelName': instance.channelName,
      'channelId': instance.channelId,
      'channelTblRowId': instance.channelTblRowId,
      'seriesId': instance.seriesId,
      'seasonNum': instance.seasonNum,
      'isRecorded': instance.isRecorded,
      'isNewEpisode': instance.isNewEpisode,
      'showDate': instance.showDate,
      'showDateEnd': instance.showDateEnd,
      'programTblRowId': instance.programTblRowId,
      'showId': instance.showId,
      'isCurrentlyRecording': instance.isCurrentlyRecording,
    };
