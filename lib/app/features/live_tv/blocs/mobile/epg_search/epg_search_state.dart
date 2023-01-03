part of 'epg_search_bloc.dart';

class ChannelState {
  const ChannelState();

  @override
  List<Object> get props => [];
}

class ChannelSuccessState extends ChannelState {
  const ChannelSuccessState({required this.list});
  final List<Channel> list;

  @override
  List<Object> get props => [list];
}

class ChannelLoadingState extends ChannelState {}

class ChannelErrorState extends ChannelState {}

class ChannelEmptyState extends ChannelState {}

class ProgramSuccessState extends ChannelState {
  const ProgramSuccessState({required this.list});
  final List<Program> list;

  @override
  List<Object> get props => [list];
}

class ProgramLoadingState extends ChannelState {}

class ProgramEmptyState extends ChannelState {}
