import 'package:freezed_annotation/freezed_annotation.dart';
part 'channel_and_program.freezed.dart';
part 'channel_and_program.g.dart';

@freezed
class ChannelAndProgram with _$ChannelAndProgram {
  factory ChannelAndProgram({
    @Default('') dynamic programTitle,
    @Default('') dynamic programDescription,
    @Default('') dynamic channelName,
    @Default('') dynamic channelId,
    @Default('') dynamic channelTblRowId,
    @Default('') dynamic seriesId,
    @Default('') dynamic seasonNum,
    @Default('') dynamic isRecorded,
    @Default('') dynamic isNewEpisode,
    @Default('') dynamic showDate,
    @Default('') dynamic showDateEnd,
    @Default('') dynamic programTblRowId,
    @Default('') dynamic showId,
    @Default('') dynamic isCurrentlyRecording,

  }) = _ChannelAndProgram;

  factory ChannelAndProgram.fromJson(Map<String, dynamic> json) =>
      _$ChannelAndProgramFromJson(json);
}
