part of 'channel_bloc.dart';

@freezed
class ChannelState with _$ChannelState {
  const factory ChannelState.initial() = _Initial;
  const factory ChannelState.loading() = _Loading;
  const factory ChannelState.loaded({
    @Default(<Channel>[])
        List<Channel> channels,
    @Default(<String>{
      'All Channels',
      'Favorites',
    })
        Set<String> genres,
    @Default(0)
        num spacePurchased,
    @Default(0)
        num spaceUsed,
    @Default(0)
        num spaceRemaining,
    @Default(0)
        int channelSelected,
    @Default(0)
        int genreSelected,
    @Default(<Channel>[])
        List<Channel> filteredChannels,
  }) = _Loaded;
  const factory ChannelState.error(String error) = _Error;
}
