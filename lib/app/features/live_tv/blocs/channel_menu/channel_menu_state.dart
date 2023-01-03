part of 'channel_menu_cubit.dart';

class ChannelMenuState extends Equatable {
  const ChannelMenuState({
    required this.currentGenreSelected,
    required this.currentChannelSelected,
    required this.isNavigatingThroughDrawer,
  });

  final int currentGenreSelected;
  final int currentChannelSelected;
  final bool isNavigatingThroughDrawer;

  ChannelMenuState copyWith({
    int? currentGenreSelected,
    int? currentChannelSelected,
    bool? isNavigatingThroughDrawer,
    List<Channel>? channels,
    Set<String>? genres,
  }) {
    return ChannelMenuState(
      currentGenreSelected: currentGenreSelected ?? this.currentGenreSelected,
      currentChannelSelected:
          currentChannelSelected ?? this.currentChannelSelected,
      isNavigatingThroughDrawer:
          isNavigatingThroughDrawer ?? this.isNavigatingThroughDrawer,
    );
  }

  @override
  List<Object?> get props => [
        currentGenreSelected,
        currentChannelSelected,
        isNavigatingThroughDrawer,
      ];
}
