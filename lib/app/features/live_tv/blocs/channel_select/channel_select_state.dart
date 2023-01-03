part of 'channel_select_cubit.dart';

class ChannelSelectState extends Equatable {
  const ChannelSelectState({
    required this.selectedChannelIndex,
  });

  final int selectedChannelIndex;

  ChannelSelectState copyWith({
    int? selectedChannelIndex,
    int? initialSelectedIndex,
    List<Channel>? channels,
  }) {
    return ChannelSelectState(
      selectedChannelIndex: selectedChannelIndex ?? this.selectedChannelIndex,
    );
  }

  @override
  List<Object?> get props => [
        selectedChannelIndex,
      ];
}
