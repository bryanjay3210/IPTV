// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Program _$$_ProgramFromJson(Map<String, dynamic> json) => _$_Program(
      epgShowId: json['EPGShowID'] as String,
      epgSeriesId: json['EPGSeriesID'] as String,
      epgSeasonId: json['EPGSeasonID'] as String,
      epgSeasonNum: json['EPGSeasonNum'] as String,
      programTitle: const EmptyMapToStringConverter()
          .fromJson(json['ProgramTitle'] as Object),
      previousRun: const EmptyMapToStringConverter()
          .fromJson(json['PreviousRun'] as Object),
      programLang: const EmptyMapToStringConverter()
          .fromJson(json['ProgramLang'] as Object),
      programDesc: const EmptyMapToStringConverter()
          .fromJson(json['ProgramDesc'] as Object),
      programRating: const EmptyMapToStringConverter()
          .fromJson(json['ProgramRating'] as Object),
      isCurrentlyRecording:
          const YNConverter().fromJson(json['IsCurrentlyRecording'] as String),
      startEpoch: const EpochConverter().fromJson(json['StartEpoch'] as String),
      stopEpoch: const EpochConverter().fromJson(json['StopEpoch'] as String),
    );

Map<String, dynamic> _$$_ProgramToJson(_$_Program instance) =>
    <String, dynamic>{
      'EPGShowID': instance.epgShowId,
      'EPGSeriesID': instance.epgSeriesId,
      'EPGSeasonID': instance.epgSeasonId,
      'EPGSeasonNum': instance.epgSeasonNum,
      'ProgramTitle':
          const EmptyMapToStringConverter().toJson(instance.programTitle),
      'PreviousRun':
          const EmptyMapToStringConverter().toJson(instance.previousRun),
      'ProgramLang':
          const EmptyMapToStringConverter().toJson(instance.programLang),
      'ProgramDesc':
          const EmptyMapToStringConverter().toJson(instance.programDesc),
      'ProgramRating':
          const EmptyMapToStringConverter().toJson(instance.programRating),
      'IsCurrentlyRecording':
          const YNConverter().toJson(instance.isCurrentlyRecording),
      'StartEpoch': const EpochConverter().toJson(instance.startEpoch),
      'StopEpoch': const EpochConverter().toJson(instance.stopEpoch),
    };
