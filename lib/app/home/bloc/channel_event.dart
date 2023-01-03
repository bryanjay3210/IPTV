part of 'channel_bloc.dart';

@freezed
class ChannelEvent with _$ChannelEvent {
  const factory ChannelEvent.fetch({
    DateTime? timestamp,
  }) = _Started;

  const factory ChannelEvent.reloadChannels() = _ReloadChannels;
  const factory ChannelEvent.reloadDvr() = _ReloadDvr;
  const factory ChannelEvent.changeChannel(int index) = _ChangeChannel;
  const factory ChannelEvent.changeGenre(int index) = _ChangeGenre;
  const factory ChannelEvent.changeChannelAndGenre(
    int channelIndex,
    int channelGenre,
  ) = _ChangeChannelAndGenre;
  const factory ChannelEvent.recordProgram(
    int channelIndex,
    int programIndex,
    void Function(
      List<Channel>,
    )
        callback,
  ) = _RecordProgram;
  const factory ChannelEvent.recordSeries(
    int channelIndex,
    int programIndex,
    void Function(
      List<Channel>,
    )
        callback,
  ) = _RecordSeries;
  const factory ChannelEvent.stopRecordingProgram(
    int channelIndex,
    int programIndex,
    void Function(
      List<Channel>,
    )
        callback,
  ) = _StopRecordingProgram;
  const factory ChannelEvent.forceUpdateFilteredChannels(
    List<Channel> channels,
  ) = _ForceUpdateFilteredChannels;
  const factory ChannelEvent.addFavoriteChannel(
    String epgChannelId,
    void Function() callback,
  ) = _AddFavoriteChannel;
  const factory ChannelEvent.removeFavoriteChannel(
    String epgChannelId,
    void Function() callback,
  ) = _RemoveFavoriteChannel;
  const factory ChannelEvent.clean(
    void Function()? callback,
  ) = _Clean;
  const factory ChannelEvent.traverseChannel({required bool increment}) =
      _TraverseChannel;
  const factory ChannelEvent.updateProgramRecordStatus({
    required String epgSeriesId,
  }) = _UpdateProgramRecordStatus;
}
