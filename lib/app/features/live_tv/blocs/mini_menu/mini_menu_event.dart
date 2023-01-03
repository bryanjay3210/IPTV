part of 'mini_menu_bloc.dart';

abstract class MiniMenuEvent extends Equatable {
  const MiniMenuEvent();

  @override
  List<Object> get props => [];
}

class FetchMiniMenuData extends MiniMenuEvent {
  const FetchMiniMenuData(
    this.currentChannel,
    this.epgChannelId,
    this.context, {
    required this.isFavoriteState,
  });

  final Channel currentChannel;
  final String epgChannelId;
  final bool isFavoriteState;
  final BuildContext context;
}

class StartRecording extends MiniMenuEvent {
  const StartRecording(this.epgChannelId);

  final String epgChannelId;
}

class StopRecording extends MiniMenuEvent {
  const StopRecording(this.epgChannelId);

  final String epgChannelId;
}

class AddToFavorites extends MiniMenuEvent {
  const AddToFavorites(this.channelId);

  final String channelId;
}

class RemoveToFavorites extends MiniMenuEvent {
  const RemoveToFavorites(this.channelId);

  final String channelId;
}
