import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iptv/core/models/json_helpers.dart';

part 'program.freezed.dart';
part 'program.g.dart';

@freezed
class Program with _$Program {
  factory Program({
    @JsonKey(name: 'EPGShowID') required String epgShowId,
    @JsonKey(name: 'EPGSeriesID') required String epgSeriesId,
    @JsonKey(name: 'EPGSeasonID') required String epgSeasonId,
    @JsonKey(name: 'EPGSeasonNum') required String epgSeasonNum,
    @EmptyMapToStringConverter()
    @JsonKey(name: 'ProgramTitle')
        required String programTitle,
    @EmptyMapToStringConverter()
    @JsonKey(name: 'PreviousRun')
        required String previousRun,
    @EmptyMapToStringConverter()
    @JsonKey(name: 'ProgramLang')
        required String programLang,
    @EmptyMapToStringConverter()
    @JsonKey(name: 'ProgramDesc')
        required String programDesc,
    @EmptyMapToStringConverter()
    @JsonKey(name: 'ProgramRating')
        required String programRating,
    @YNConverter()
    @JsonKey(name: 'IsCurrentlyRecording')
        required bool isCurrentlyRecording,
    @EpochConverter() @JsonKey(name: 'StartEpoch') required DateTime startEpoch,
    @EpochConverter() @JsonKey(name: 'StopEpoch') required DateTime stopEpoch,
  }) = _Program;

  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);
}
