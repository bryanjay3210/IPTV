import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iptv/core/models/json_helpers.dart';

part 'recording.freezed.dart';
part 'recording.g.dart';

@freezed
class Recording with _$Recording {
  factory Recording({
    @JsonKey(name: 'ProgramTblRowID') required String programTblRowId,
    @JsonKey(name: 'ChannelTblRowID') required String channelTblRowId,
    // @JsonKey(name: 'GuideChannel') required String guideChannel,
    @JsonKey(name: 'EPGShowID') required String epgShowId,
    @JsonKey(name: 'EPGSeriesID') required String epgSeriesId,
    @JsonKey(name: 'ProgramStartTime') required String programStartTime,
    @JsonKey(name: 'ProgramStopTime') required String programStopTime,
    @JsonKey(name: 'ProgramNew') required String programNew,
    @JsonKey(name: 'EPGChannelID') required String epgChannelId,
    // @JsonKey(name: 'PreviousShowing') required String previousShowing,
    @EmptyMapToStringConverter()
    @JsonKey(name: 'ProgramTitle')
        required String programTitle,
    @EmptyMapToStringConverter()
    @JsonKey(name: 'ProgramDescription')
        required String programDescription,
    // @JsonKey(name: 'ProgramRating') required dynamic programRating,
    // @JsonKey(name: 'ProgramLanguage') required String programLanguage,
    // @JsonKey(name: 'ProgramDescriptiveVideo')
    //     required String programDescriptiveVideo,
    // @JsonKey(name: 'ProgramChannel') required String programChannel,
    // @JsonKey(name: 'ProgramCategory') required String programCategory,
    @JsonKey(name: 'KeepValue') required String keepValue,
    @EmptyMapToStringConverter()
    @JsonKey(name: 'ChannelIconURL')
        required String channelIconURL,
    @EmptyMapToStringConverter()
    @JsonKey(name: 'EPGSeasonNum')
        required String epgSeasonNum,
    @YNConverter() @JsonKey(name: 'SeriesRecord') required bool seriesRecord,
  }) = _Recording;

  factory Recording.fromJson(Map<String, dynamic> json) =>
      _$RecordingFromJson(json);
}
