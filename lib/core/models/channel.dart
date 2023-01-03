import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iptv/core/models/json_helpers.dart';
import 'package:iptv/core/models/program.dart';

part 'channel.freezed.dart';
part 'channel.g.dart';

@freezed
class Channel with _$Channel {
  factory Channel({
    @JsonKey(name: 'EPGChannelID') required String epgChannelId,
    @JsonKey(name: 'ChannelRowID') required String channelRowId,
    @JsonKey(name: 'GuideChannelNum') required String guideChannelNum,
    @JsonKey(name: 'IconURL') required String iconUrl,
    @JsonKey(name: 'StreamURL') required String streamUrl,
    @TFConverter() @JsonKey(name: 'DVREnabled') required bool dvrEnabled,
    @YNConverter() @JsonKey(name: 'IsFavorite') required bool isFavorite,
    @GenreConverter() @JsonKey(name: 'GenreName') required String genreName,
    @JsonKey(name: 'ChannelName') required String channelName,
    @EmptyMapToSingleProgramListConverter()
    @JsonKey(name: 'Programs')
        required List<Program>? programs,
  }) = _Channel;

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);
}
