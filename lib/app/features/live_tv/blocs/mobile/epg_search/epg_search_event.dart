part of 'epg_search_bloc.dart';

abstract class ChannelEvent {
  const ChannelEvent();

  @override
  List<Object> get props => [];
}

class LaodingEvent extends ChannelEvent {}

class ErrorEvent extends ChannelEvent {}

class InitializeEvent extends ChannelEvent {}

class TypeChannelName extends ChannelEvent {
  const TypeChannelName({required this.channelName});
  final String channelName;

  @override
  List<Object> get props => [channelName];
}

class SelectChannelEvent extends ChannelEvent {
  const SelectChannelEvent({required this.channeId});
  final int channeId;

  @override
  List<Object> get props => [channeId];
}
