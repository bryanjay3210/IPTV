// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'channel_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChannelEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? timestamp) fetch,
    required TResult Function() reloadChannels,
    required TResult Function() reloadDvr,
    required TResult Function(int index) changeChannel,
    required TResult Function(int index) changeGenre,
    required TResult Function(int channelIndex, int channelGenre)
        changeChannelAndGenre,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordProgram,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordSeries,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        stopRecordingProgram,
    required TResult Function(List<Channel> channels)
        forceUpdateFilteredChannels,
    required TResult Function(String epgChannelId, void Function() callback)
        addFavoriteChannel,
    required TResult Function(String epgChannelId, void Function() callback)
        removeFavoriteChannel,
    required TResult Function(void Function()? callback) clean,
    required TResult Function(bool increment) traverseChannel,
    required TResult Function(String epgSeriesId) updateProgramRecordStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) fetch,
    required TResult Function(_ReloadChannels value) reloadChannels,
    required TResult Function(_ReloadDvr value) reloadDvr,
    required TResult Function(_ChangeChannel value) changeChannel,
    required TResult Function(_ChangeGenre value) changeGenre,
    required TResult Function(_ChangeChannelAndGenre value)
        changeChannelAndGenre,
    required TResult Function(_RecordProgram value) recordProgram,
    required TResult Function(_RecordSeries value) recordSeries,
    required TResult Function(_StopRecordingProgram value) stopRecordingProgram,
    required TResult Function(_ForceUpdateFilteredChannels value)
        forceUpdateFilteredChannels,
    required TResult Function(_AddFavoriteChannel value) addFavoriteChannel,
    required TResult Function(_RemoveFavoriteChannel value)
        removeFavoriteChannel,
    required TResult Function(_Clean value) clean,
    required TResult Function(_TraverseChannel value) traverseChannel,
    required TResult Function(_UpdateProgramRecordStatus value)
        updateProgramRecordStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelEventCopyWith<$Res> {
  factory $ChannelEventCopyWith(
          ChannelEvent value, $Res Function(ChannelEvent) then) =
      _$ChannelEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ChannelEventCopyWithImpl<$Res> implements $ChannelEventCopyWith<$Res> {
  _$ChannelEventCopyWithImpl(this._value, this._then);

  final ChannelEvent _value;
  // ignore: unused_field
  final $Res Function(ChannelEvent) _then;
}

/// @nodoc
abstract class _$$_StartedCopyWith<$Res> {
  factory _$$_StartedCopyWith(
          _$_Started value, $Res Function(_$_Started) then) =
      __$$_StartedCopyWithImpl<$Res>;
  $Res call({DateTime? timestamp});
}

/// @nodoc
class __$$_StartedCopyWithImpl<$Res> extends _$ChannelEventCopyWithImpl<$Res>
    implements _$$_StartedCopyWith<$Res> {
  __$$_StartedCopyWithImpl(_$_Started _value, $Res Function(_$_Started) _then)
      : super(_value, (v) => _then(v as _$_Started));

  @override
  _$_Started get _value => super._value as _$_Started;

  @override
  $Res call({
    Object? timestamp = freezed,
  }) {
    return _then(_$_Started(
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$_Started implements _Started {
  const _$_Started({this.timestamp});

  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'ChannelEvent.fetch(timestamp: $timestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Started &&
            const DeepCollectionEquality().equals(other.timestamp, timestamp));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(timestamp));

  @JsonKey(ignore: true)
  @override
  _$$_StartedCopyWith<_$_Started> get copyWith =>
      __$$_StartedCopyWithImpl<_$_Started>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? timestamp) fetch,
    required TResult Function() reloadChannels,
    required TResult Function() reloadDvr,
    required TResult Function(int index) changeChannel,
    required TResult Function(int index) changeGenre,
    required TResult Function(int channelIndex, int channelGenre)
        changeChannelAndGenre,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordProgram,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordSeries,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        stopRecordingProgram,
    required TResult Function(List<Channel> channels)
        forceUpdateFilteredChannels,
    required TResult Function(String epgChannelId, void Function() callback)
        addFavoriteChannel,
    required TResult Function(String epgChannelId, void Function() callback)
        removeFavoriteChannel,
    required TResult Function(void Function()? callback) clean,
    required TResult Function(bool increment) traverseChannel,
    required TResult Function(String epgSeriesId) updateProgramRecordStatus,
  }) {
    return fetch(timestamp);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
  }) {
    return fetch?.call(timestamp);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(timestamp);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) fetch,
    required TResult Function(_ReloadChannels value) reloadChannels,
    required TResult Function(_ReloadDvr value) reloadDvr,
    required TResult Function(_ChangeChannel value) changeChannel,
    required TResult Function(_ChangeGenre value) changeGenre,
    required TResult Function(_ChangeChannelAndGenre value)
        changeChannelAndGenre,
    required TResult Function(_RecordProgram value) recordProgram,
    required TResult Function(_RecordSeries value) recordSeries,
    required TResult Function(_StopRecordingProgram value) stopRecordingProgram,
    required TResult Function(_ForceUpdateFilteredChannels value)
        forceUpdateFilteredChannels,
    required TResult Function(_AddFavoriteChannel value) addFavoriteChannel,
    required TResult Function(_RemoveFavoriteChannel value)
        removeFavoriteChannel,
    required TResult Function(_Clean value) clean,
    required TResult Function(_TraverseChannel value) traverseChannel,
    required TResult Function(_UpdateProgramRecordStatus value)
        updateProgramRecordStatus,
  }) {
    return fetch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
  }) {
    return fetch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (fetch != null) {
      return fetch(this);
    }
    return orElse();
  }
}

abstract class _Started implements ChannelEvent {
  const factory _Started({final DateTime? timestamp}) = _$_Started;

  DateTime? get timestamp;
  @JsonKey(ignore: true)
  _$$_StartedCopyWith<_$_Started> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ReloadChannelsCopyWith<$Res> {
  factory _$$_ReloadChannelsCopyWith(
          _$_ReloadChannels value, $Res Function(_$_ReloadChannels) then) =
      __$$_ReloadChannelsCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ReloadChannelsCopyWithImpl<$Res>
    extends _$ChannelEventCopyWithImpl<$Res>
    implements _$$_ReloadChannelsCopyWith<$Res> {
  __$$_ReloadChannelsCopyWithImpl(
      _$_ReloadChannels _value, $Res Function(_$_ReloadChannels) _then)
      : super(_value, (v) => _then(v as _$_ReloadChannels));

  @override
  _$_ReloadChannels get _value => super._value as _$_ReloadChannels;
}

/// @nodoc

class _$_ReloadChannels implements _ReloadChannels {
  const _$_ReloadChannels();

  @override
  String toString() {
    return 'ChannelEvent.reloadChannels()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_ReloadChannels);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? timestamp) fetch,
    required TResult Function() reloadChannels,
    required TResult Function() reloadDvr,
    required TResult Function(int index) changeChannel,
    required TResult Function(int index) changeGenre,
    required TResult Function(int channelIndex, int channelGenre)
        changeChannelAndGenre,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordProgram,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordSeries,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        stopRecordingProgram,
    required TResult Function(List<Channel> channels)
        forceUpdateFilteredChannels,
    required TResult Function(String epgChannelId, void Function() callback)
        addFavoriteChannel,
    required TResult Function(String epgChannelId, void Function() callback)
        removeFavoriteChannel,
    required TResult Function(void Function()? callback) clean,
    required TResult Function(bool increment) traverseChannel,
    required TResult Function(String epgSeriesId) updateProgramRecordStatus,
  }) {
    return reloadChannels();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
  }) {
    return reloadChannels?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (reloadChannels != null) {
      return reloadChannels();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) fetch,
    required TResult Function(_ReloadChannels value) reloadChannels,
    required TResult Function(_ReloadDvr value) reloadDvr,
    required TResult Function(_ChangeChannel value) changeChannel,
    required TResult Function(_ChangeGenre value) changeGenre,
    required TResult Function(_ChangeChannelAndGenre value)
        changeChannelAndGenre,
    required TResult Function(_RecordProgram value) recordProgram,
    required TResult Function(_RecordSeries value) recordSeries,
    required TResult Function(_StopRecordingProgram value) stopRecordingProgram,
    required TResult Function(_ForceUpdateFilteredChannels value)
        forceUpdateFilteredChannels,
    required TResult Function(_AddFavoriteChannel value) addFavoriteChannel,
    required TResult Function(_RemoveFavoriteChannel value)
        removeFavoriteChannel,
    required TResult Function(_Clean value) clean,
    required TResult Function(_TraverseChannel value) traverseChannel,
    required TResult Function(_UpdateProgramRecordStatus value)
        updateProgramRecordStatus,
  }) {
    return reloadChannels(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
  }) {
    return reloadChannels?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (reloadChannels != null) {
      return reloadChannels(this);
    }
    return orElse();
  }
}

abstract class _ReloadChannels implements ChannelEvent {
  const factory _ReloadChannels() = _$_ReloadChannels;
}

/// @nodoc
abstract class _$$_ReloadDvrCopyWith<$Res> {
  factory _$$_ReloadDvrCopyWith(
          _$_ReloadDvr value, $Res Function(_$_ReloadDvr) then) =
      __$$_ReloadDvrCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ReloadDvrCopyWithImpl<$Res> extends _$ChannelEventCopyWithImpl<$Res>
    implements _$$_ReloadDvrCopyWith<$Res> {
  __$$_ReloadDvrCopyWithImpl(
      _$_ReloadDvr _value, $Res Function(_$_ReloadDvr) _then)
      : super(_value, (v) => _then(v as _$_ReloadDvr));

  @override
  _$_ReloadDvr get _value => super._value as _$_ReloadDvr;
}

/// @nodoc

class _$_ReloadDvr implements _ReloadDvr {
  const _$_ReloadDvr();

  @override
  String toString() {
    return 'ChannelEvent.reloadDvr()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_ReloadDvr);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? timestamp) fetch,
    required TResult Function() reloadChannels,
    required TResult Function() reloadDvr,
    required TResult Function(int index) changeChannel,
    required TResult Function(int index) changeGenre,
    required TResult Function(int channelIndex, int channelGenre)
        changeChannelAndGenre,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordProgram,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordSeries,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        stopRecordingProgram,
    required TResult Function(List<Channel> channels)
        forceUpdateFilteredChannels,
    required TResult Function(String epgChannelId, void Function() callback)
        addFavoriteChannel,
    required TResult Function(String epgChannelId, void Function() callback)
        removeFavoriteChannel,
    required TResult Function(void Function()? callback) clean,
    required TResult Function(bool increment) traverseChannel,
    required TResult Function(String epgSeriesId) updateProgramRecordStatus,
  }) {
    return reloadDvr();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
  }) {
    return reloadDvr?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (reloadDvr != null) {
      return reloadDvr();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) fetch,
    required TResult Function(_ReloadChannels value) reloadChannels,
    required TResult Function(_ReloadDvr value) reloadDvr,
    required TResult Function(_ChangeChannel value) changeChannel,
    required TResult Function(_ChangeGenre value) changeGenre,
    required TResult Function(_ChangeChannelAndGenre value)
        changeChannelAndGenre,
    required TResult Function(_RecordProgram value) recordProgram,
    required TResult Function(_RecordSeries value) recordSeries,
    required TResult Function(_StopRecordingProgram value) stopRecordingProgram,
    required TResult Function(_ForceUpdateFilteredChannels value)
        forceUpdateFilteredChannels,
    required TResult Function(_AddFavoriteChannel value) addFavoriteChannel,
    required TResult Function(_RemoveFavoriteChannel value)
        removeFavoriteChannel,
    required TResult Function(_Clean value) clean,
    required TResult Function(_TraverseChannel value) traverseChannel,
    required TResult Function(_UpdateProgramRecordStatus value)
        updateProgramRecordStatus,
  }) {
    return reloadDvr(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
  }) {
    return reloadDvr?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (reloadDvr != null) {
      return reloadDvr(this);
    }
    return orElse();
  }
}

abstract class _ReloadDvr implements ChannelEvent {
  const factory _ReloadDvr() = _$_ReloadDvr;
}

/// @nodoc
abstract class _$$_ChangeChannelCopyWith<$Res> {
  factory _$$_ChangeChannelCopyWith(
          _$_ChangeChannel value, $Res Function(_$_ChangeChannel) then) =
      __$$_ChangeChannelCopyWithImpl<$Res>;
  $Res call({int index});
}

/// @nodoc
class __$$_ChangeChannelCopyWithImpl<$Res>
    extends _$ChannelEventCopyWithImpl<$Res>
    implements _$$_ChangeChannelCopyWith<$Res> {
  __$$_ChangeChannelCopyWithImpl(
      _$_ChangeChannel _value, $Res Function(_$_ChangeChannel) _then)
      : super(_value, (v) => _then(v as _$_ChangeChannel));

  @override
  _$_ChangeChannel get _value => super._value as _$_ChangeChannel;

  @override
  $Res call({
    Object? index = freezed,
  }) {
    return _then(_$_ChangeChannel(
      index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ChangeChannel implements _ChangeChannel {
  const _$_ChangeChannel(this.index);

  @override
  final int index;

  @override
  String toString() {
    return 'ChannelEvent.changeChannel(index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChangeChannel &&
            const DeepCollectionEquality().equals(other.index, index));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(index));

  @JsonKey(ignore: true)
  @override
  _$$_ChangeChannelCopyWith<_$_ChangeChannel> get copyWith =>
      __$$_ChangeChannelCopyWithImpl<_$_ChangeChannel>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? timestamp) fetch,
    required TResult Function() reloadChannels,
    required TResult Function() reloadDvr,
    required TResult Function(int index) changeChannel,
    required TResult Function(int index) changeGenre,
    required TResult Function(int channelIndex, int channelGenre)
        changeChannelAndGenre,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordProgram,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordSeries,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        stopRecordingProgram,
    required TResult Function(List<Channel> channels)
        forceUpdateFilteredChannels,
    required TResult Function(String epgChannelId, void Function() callback)
        addFavoriteChannel,
    required TResult Function(String epgChannelId, void Function() callback)
        removeFavoriteChannel,
    required TResult Function(void Function()? callback) clean,
    required TResult Function(bool increment) traverseChannel,
    required TResult Function(String epgSeriesId) updateProgramRecordStatus,
  }) {
    return changeChannel(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
  }) {
    return changeChannel?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (changeChannel != null) {
      return changeChannel(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) fetch,
    required TResult Function(_ReloadChannels value) reloadChannels,
    required TResult Function(_ReloadDvr value) reloadDvr,
    required TResult Function(_ChangeChannel value) changeChannel,
    required TResult Function(_ChangeGenre value) changeGenre,
    required TResult Function(_ChangeChannelAndGenre value)
        changeChannelAndGenre,
    required TResult Function(_RecordProgram value) recordProgram,
    required TResult Function(_RecordSeries value) recordSeries,
    required TResult Function(_StopRecordingProgram value) stopRecordingProgram,
    required TResult Function(_ForceUpdateFilteredChannels value)
        forceUpdateFilteredChannels,
    required TResult Function(_AddFavoriteChannel value) addFavoriteChannel,
    required TResult Function(_RemoveFavoriteChannel value)
        removeFavoriteChannel,
    required TResult Function(_Clean value) clean,
    required TResult Function(_TraverseChannel value) traverseChannel,
    required TResult Function(_UpdateProgramRecordStatus value)
        updateProgramRecordStatus,
  }) {
    return changeChannel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
  }) {
    return changeChannel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (changeChannel != null) {
      return changeChannel(this);
    }
    return orElse();
  }
}

abstract class _ChangeChannel implements ChannelEvent {
  const factory _ChangeChannel(final int index) = _$_ChangeChannel;

  int get index;
  @JsonKey(ignore: true)
  _$$_ChangeChannelCopyWith<_$_ChangeChannel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ChangeGenreCopyWith<$Res> {
  factory _$$_ChangeGenreCopyWith(
          _$_ChangeGenre value, $Res Function(_$_ChangeGenre) then) =
      __$$_ChangeGenreCopyWithImpl<$Res>;
  $Res call({int index});
}

/// @nodoc
class __$$_ChangeGenreCopyWithImpl<$Res>
    extends _$ChannelEventCopyWithImpl<$Res>
    implements _$$_ChangeGenreCopyWith<$Res> {
  __$$_ChangeGenreCopyWithImpl(
      _$_ChangeGenre _value, $Res Function(_$_ChangeGenre) _then)
      : super(_value, (v) => _then(v as _$_ChangeGenre));

  @override
  _$_ChangeGenre get _value => super._value as _$_ChangeGenre;

  @override
  $Res call({
    Object? index = freezed,
  }) {
    return _then(_$_ChangeGenre(
      index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ChangeGenre implements _ChangeGenre {
  const _$_ChangeGenre(this.index);

  @override
  final int index;

  @override
  String toString() {
    return 'ChannelEvent.changeGenre(index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChangeGenre &&
            const DeepCollectionEquality().equals(other.index, index));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(index));

  @JsonKey(ignore: true)
  @override
  _$$_ChangeGenreCopyWith<_$_ChangeGenre> get copyWith =>
      __$$_ChangeGenreCopyWithImpl<_$_ChangeGenre>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? timestamp) fetch,
    required TResult Function() reloadChannels,
    required TResult Function() reloadDvr,
    required TResult Function(int index) changeChannel,
    required TResult Function(int index) changeGenre,
    required TResult Function(int channelIndex, int channelGenre)
        changeChannelAndGenre,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordProgram,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordSeries,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        stopRecordingProgram,
    required TResult Function(List<Channel> channels)
        forceUpdateFilteredChannels,
    required TResult Function(String epgChannelId, void Function() callback)
        addFavoriteChannel,
    required TResult Function(String epgChannelId, void Function() callback)
        removeFavoriteChannel,
    required TResult Function(void Function()? callback) clean,
    required TResult Function(bool increment) traverseChannel,
    required TResult Function(String epgSeriesId) updateProgramRecordStatus,
  }) {
    return changeGenre(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
  }) {
    return changeGenre?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (changeGenre != null) {
      return changeGenre(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) fetch,
    required TResult Function(_ReloadChannels value) reloadChannels,
    required TResult Function(_ReloadDvr value) reloadDvr,
    required TResult Function(_ChangeChannel value) changeChannel,
    required TResult Function(_ChangeGenre value) changeGenre,
    required TResult Function(_ChangeChannelAndGenre value)
        changeChannelAndGenre,
    required TResult Function(_RecordProgram value) recordProgram,
    required TResult Function(_RecordSeries value) recordSeries,
    required TResult Function(_StopRecordingProgram value) stopRecordingProgram,
    required TResult Function(_ForceUpdateFilteredChannels value)
        forceUpdateFilteredChannels,
    required TResult Function(_AddFavoriteChannel value) addFavoriteChannel,
    required TResult Function(_RemoveFavoriteChannel value)
        removeFavoriteChannel,
    required TResult Function(_Clean value) clean,
    required TResult Function(_TraverseChannel value) traverseChannel,
    required TResult Function(_UpdateProgramRecordStatus value)
        updateProgramRecordStatus,
  }) {
    return changeGenre(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
  }) {
    return changeGenre?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (changeGenre != null) {
      return changeGenre(this);
    }
    return orElse();
  }
}

abstract class _ChangeGenre implements ChannelEvent {
  const factory _ChangeGenre(final int index) = _$_ChangeGenre;

  int get index;
  @JsonKey(ignore: true)
  _$$_ChangeGenreCopyWith<_$_ChangeGenre> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ChangeChannelAndGenreCopyWith<$Res> {
  factory _$$_ChangeChannelAndGenreCopyWith(_$_ChangeChannelAndGenre value,
          $Res Function(_$_ChangeChannelAndGenre) then) =
      __$$_ChangeChannelAndGenreCopyWithImpl<$Res>;
  $Res call({int channelIndex, int channelGenre});
}

/// @nodoc
class __$$_ChangeChannelAndGenreCopyWithImpl<$Res>
    extends _$ChannelEventCopyWithImpl<$Res>
    implements _$$_ChangeChannelAndGenreCopyWith<$Res> {
  __$$_ChangeChannelAndGenreCopyWithImpl(_$_ChangeChannelAndGenre _value,
      $Res Function(_$_ChangeChannelAndGenre) _then)
      : super(_value, (v) => _then(v as _$_ChangeChannelAndGenre));

  @override
  _$_ChangeChannelAndGenre get _value =>
      super._value as _$_ChangeChannelAndGenre;

  @override
  $Res call({
    Object? channelIndex = freezed,
    Object? channelGenre = freezed,
  }) {
    return _then(_$_ChangeChannelAndGenre(
      channelIndex == freezed
          ? _value.channelIndex
          : channelIndex // ignore: cast_nullable_to_non_nullable
              as int,
      channelGenre == freezed
          ? _value.channelGenre
          : channelGenre // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ChangeChannelAndGenre implements _ChangeChannelAndGenre {
  const _$_ChangeChannelAndGenre(this.channelIndex, this.channelGenre);

  @override
  final int channelIndex;
  @override
  final int channelGenre;

  @override
  String toString() {
    return 'ChannelEvent.changeChannelAndGenre(channelIndex: $channelIndex, channelGenre: $channelGenre)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChangeChannelAndGenre &&
            const DeepCollectionEquality()
                .equals(other.channelIndex, channelIndex) &&
            const DeepCollectionEquality()
                .equals(other.channelGenre, channelGenre));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(channelIndex),
      const DeepCollectionEquality().hash(channelGenre));

  @JsonKey(ignore: true)
  @override
  _$$_ChangeChannelAndGenreCopyWith<_$_ChangeChannelAndGenre> get copyWith =>
      __$$_ChangeChannelAndGenreCopyWithImpl<_$_ChangeChannelAndGenre>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? timestamp) fetch,
    required TResult Function() reloadChannels,
    required TResult Function() reloadDvr,
    required TResult Function(int index) changeChannel,
    required TResult Function(int index) changeGenre,
    required TResult Function(int channelIndex, int channelGenre)
        changeChannelAndGenre,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordProgram,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordSeries,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        stopRecordingProgram,
    required TResult Function(List<Channel> channels)
        forceUpdateFilteredChannels,
    required TResult Function(String epgChannelId, void Function() callback)
        addFavoriteChannel,
    required TResult Function(String epgChannelId, void Function() callback)
        removeFavoriteChannel,
    required TResult Function(void Function()? callback) clean,
    required TResult Function(bool increment) traverseChannel,
    required TResult Function(String epgSeriesId) updateProgramRecordStatus,
  }) {
    return changeChannelAndGenre(channelIndex, channelGenre);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
  }) {
    return changeChannelAndGenre?.call(channelIndex, channelGenre);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (changeChannelAndGenre != null) {
      return changeChannelAndGenre(channelIndex, channelGenre);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) fetch,
    required TResult Function(_ReloadChannels value) reloadChannels,
    required TResult Function(_ReloadDvr value) reloadDvr,
    required TResult Function(_ChangeChannel value) changeChannel,
    required TResult Function(_ChangeGenre value) changeGenre,
    required TResult Function(_ChangeChannelAndGenre value)
        changeChannelAndGenre,
    required TResult Function(_RecordProgram value) recordProgram,
    required TResult Function(_RecordSeries value) recordSeries,
    required TResult Function(_StopRecordingProgram value) stopRecordingProgram,
    required TResult Function(_ForceUpdateFilteredChannels value)
        forceUpdateFilteredChannels,
    required TResult Function(_AddFavoriteChannel value) addFavoriteChannel,
    required TResult Function(_RemoveFavoriteChannel value)
        removeFavoriteChannel,
    required TResult Function(_Clean value) clean,
    required TResult Function(_TraverseChannel value) traverseChannel,
    required TResult Function(_UpdateProgramRecordStatus value)
        updateProgramRecordStatus,
  }) {
    return changeChannelAndGenre(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
  }) {
    return changeChannelAndGenre?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (changeChannelAndGenre != null) {
      return changeChannelAndGenre(this);
    }
    return orElse();
  }
}

abstract class _ChangeChannelAndGenre implements ChannelEvent {
  const factory _ChangeChannelAndGenre(
          final int channelIndex, final int channelGenre) =
      _$_ChangeChannelAndGenre;

  int get channelIndex;
  int get channelGenre;
  @JsonKey(ignore: true)
  _$$_ChangeChannelAndGenreCopyWith<_$_ChangeChannelAndGenre> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_RecordProgramCopyWith<$Res> {
  factory _$$_RecordProgramCopyWith(
          _$_RecordProgram value, $Res Function(_$_RecordProgram) then) =
      __$$_RecordProgramCopyWithImpl<$Res>;
  $Res call(
      {int channelIndex,
      int programIndex,
      void Function(List<Channel>) callback});
}

/// @nodoc
class __$$_RecordProgramCopyWithImpl<$Res>
    extends _$ChannelEventCopyWithImpl<$Res>
    implements _$$_RecordProgramCopyWith<$Res> {
  __$$_RecordProgramCopyWithImpl(
      _$_RecordProgram _value, $Res Function(_$_RecordProgram) _then)
      : super(_value, (v) => _then(v as _$_RecordProgram));

  @override
  _$_RecordProgram get _value => super._value as _$_RecordProgram;

  @override
  $Res call({
    Object? channelIndex = freezed,
    Object? programIndex = freezed,
    Object? callback = freezed,
  }) {
    return _then(_$_RecordProgram(
      channelIndex == freezed
          ? _value.channelIndex
          : channelIndex // ignore: cast_nullable_to_non_nullable
              as int,
      programIndex == freezed
          ? _value.programIndex
          : programIndex // ignore: cast_nullable_to_non_nullable
              as int,
      callback == freezed
          ? _value.callback
          : callback // ignore: cast_nullable_to_non_nullable
              as void Function(List<Channel>),
    ));
  }
}

/// @nodoc

class _$_RecordProgram implements _RecordProgram {
  const _$_RecordProgram(this.channelIndex, this.programIndex, this.callback);

  @override
  final int channelIndex;
  @override
  final int programIndex;
  @override
  final void Function(List<Channel>) callback;

  @override
  String toString() {
    return 'ChannelEvent.recordProgram(channelIndex: $channelIndex, programIndex: $programIndex, callback: $callback)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecordProgram &&
            const DeepCollectionEquality()
                .equals(other.channelIndex, channelIndex) &&
            const DeepCollectionEquality()
                .equals(other.programIndex, programIndex) &&
            (identical(other.callback, callback) ||
                other.callback == callback));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(channelIndex),
      const DeepCollectionEquality().hash(programIndex),
      callback);

  @JsonKey(ignore: true)
  @override
  _$$_RecordProgramCopyWith<_$_RecordProgram> get copyWith =>
      __$$_RecordProgramCopyWithImpl<_$_RecordProgram>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? timestamp) fetch,
    required TResult Function() reloadChannels,
    required TResult Function() reloadDvr,
    required TResult Function(int index) changeChannel,
    required TResult Function(int index) changeGenre,
    required TResult Function(int channelIndex, int channelGenre)
        changeChannelAndGenre,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordProgram,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordSeries,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        stopRecordingProgram,
    required TResult Function(List<Channel> channels)
        forceUpdateFilteredChannels,
    required TResult Function(String epgChannelId, void Function() callback)
        addFavoriteChannel,
    required TResult Function(String epgChannelId, void Function() callback)
        removeFavoriteChannel,
    required TResult Function(void Function()? callback) clean,
    required TResult Function(bool increment) traverseChannel,
    required TResult Function(String epgSeriesId) updateProgramRecordStatus,
  }) {
    return recordProgram(channelIndex, programIndex, callback);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
  }) {
    return recordProgram?.call(channelIndex, programIndex, callback);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (recordProgram != null) {
      return recordProgram(channelIndex, programIndex, callback);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) fetch,
    required TResult Function(_ReloadChannels value) reloadChannels,
    required TResult Function(_ReloadDvr value) reloadDvr,
    required TResult Function(_ChangeChannel value) changeChannel,
    required TResult Function(_ChangeGenre value) changeGenre,
    required TResult Function(_ChangeChannelAndGenre value)
        changeChannelAndGenre,
    required TResult Function(_RecordProgram value) recordProgram,
    required TResult Function(_RecordSeries value) recordSeries,
    required TResult Function(_StopRecordingProgram value) stopRecordingProgram,
    required TResult Function(_ForceUpdateFilteredChannels value)
        forceUpdateFilteredChannels,
    required TResult Function(_AddFavoriteChannel value) addFavoriteChannel,
    required TResult Function(_RemoveFavoriteChannel value)
        removeFavoriteChannel,
    required TResult Function(_Clean value) clean,
    required TResult Function(_TraverseChannel value) traverseChannel,
    required TResult Function(_UpdateProgramRecordStatus value)
        updateProgramRecordStatus,
  }) {
    return recordProgram(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
  }) {
    return recordProgram?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (recordProgram != null) {
      return recordProgram(this);
    }
    return orElse();
  }
}

abstract class _RecordProgram implements ChannelEvent {
  const factory _RecordProgram(final int channelIndex, final int programIndex,
      final void Function(List<Channel>) callback) = _$_RecordProgram;

  int get channelIndex;
  int get programIndex;
  void Function(List<Channel>) get callback;
  @JsonKey(ignore: true)
  _$$_RecordProgramCopyWith<_$_RecordProgram> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_RecordSeriesCopyWith<$Res> {
  factory _$$_RecordSeriesCopyWith(
          _$_RecordSeries value, $Res Function(_$_RecordSeries) then) =
      __$$_RecordSeriesCopyWithImpl<$Res>;
  $Res call(
      {int channelIndex,
      int programIndex,
      void Function(List<Channel>) callback});
}

/// @nodoc
class __$$_RecordSeriesCopyWithImpl<$Res>
    extends _$ChannelEventCopyWithImpl<$Res>
    implements _$$_RecordSeriesCopyWith<$Res> {
  __$$_RecordSeriesCopyWithImpl(
      _$_RecordSeries _value, $Res Function(_$_RecordSeries) _then)
      : super(_value, (v) => _then(v as _$_RecordSeries));

  @override
  _$_RecordSeries get _value => super._value as _$_RecordSeries;

  @override
  $Res call({
    Object? channelIndex = freezed,
    Object? programIndex = freezed,
    Object? callback = freezed,
  }) {
    return _then(_$_RecordSeries(
      channelIndex == freezed
          ? _value.channelIndex
          : channelIndex // ignore: cast_nullable_to_non_nullable
              as int,
      programIndex == freezed
          ? _value.programIndex
          : programIndex // ignore: cast_nullable_to_non_nullable
              as int,
      callback == freezed
          ? _value.callback
          : callback // ignore: cast_nullable_to_non_nullable
              as void Function(List<Channel>),
    ));
  }
}

/// @nodoc

class _$_RecordSeries implements _RecordSeries {
  const _$_RecordSeries(this.channelIndex, this.programIndex, this.callback);

  @override
  final int channelIndex;
  @override
  final int programIndex;
  @override
  final void Function(List<Channel>) callback;

  @override
  String toString() {
    return 'ChannelEvent.recordSeries(channelIndex: $channelIndex, programIndex: $programIndex, callback: $callback)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecordSeries &&
            const DeepCollectionEquality()
                .equals(other.channelIndex, channelIndex) &&
            const DeepCollectionEquality()
                .equals(other.programIndex, programIndex) &&
            (identical(other.callback, callback) ||
                other.callback == callback));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(channelIndex),
      const DeepCollectionEquality().hash(programIndex),
      callback);

  @JsonKey(ignore: true)
  @override
  _$$_RecordSeriesCopyWith<_$_RecordSeries> get copyWith =>
      __$$_RecordSeriesCopyWithImpl<_$_RecordSeries>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? timestamp) fetch,
    required TResult Function() reloadChannels,
    required TResult Function() reloadDvr,
    required TResult Function(int index) changeChannel,
    required TResult Function(int index) changeGenre,
    required TResult Function(int channelIndex, int channelGenre)
        changeChannelAndGenre,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordProgram,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordSeries,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        stopRecordingProgram,
    required TResult Function(List<Channel> channels)
        forceUpdateFilteredChannels,
    required TResult Function(String epgChannelId, void Function() callback)
        addFavoriteChannel,
    required TResult Function(String epgChannelId, void Function() callback)
        removeFavoriteChannel,
    required TResult Function(void Function()? callback) clean,
    required TResult Function(bool increment) traverseChannel,
    required TResult Function(String epgSeriesId) updateProgramRecordStatus,
  }) {
    return recordSeries(channelIndex, programIndex, callback);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
  }) {
    return recordSeries?.call(channelIndex, programIndex, callback);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (recordSeries != null) {
      return recordSeries(channelIndex, programIndex, callback);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) fetch,
    required TResult Function(_ReloadChannels value) reloadChannels,
    required TResult Function(_ReloadDvr value) reloadDvr,
    required TResult Function(_ChangeChannel value) changeChannel,
    required TResult Function(_ChangeGenre value) changeGenre,
    required TResult Function(_ChangeChannelAndGenre value)
        changeChannelAndGenre,
    required TResult Function(_RecordProgram value) recordProgram,
    required TResult Function(_RecordSeries value) recordSeries,
    required TResult Function(_StopRecordingProgram value) stopRecordingProgram,
    required TResult Function(_ForceUpdateFilteredChannels value)
        forceUpdateFilteredChannels,
    required TResult Function(_AddFavoriteChannel value) addFavoriteChannel,
    required TResult Function(_RemoveFavoriteChannel value)
        removeFavoriteChannel,
    required TResult Function(_Clean value) clean,
    required TResult Function(_TraverseChannel value) traverseChannel,
    required TResult Function(_UpdateProgramRecordStatus value)
        updateProgramRecordStatus,
  }) {
    return recordSeries(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
  }) {
    return recordSeries?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (recordSeries != null) {
      return recordSeries(this);
    }
    return orElse();
  }
}

abstract class _RecordSeries implements ChannelEvent {
  const factory _RecordSeries(final int channelIndex, final int programIndex,
      final void Function(List<Channel>) callback) = _$_RecordSeries;

  int get channelIndex;
  int get programIndex;
  void Function(List<Channel>) get callback;
  @JsonKey(ignore: true)
  _$$_RecordSeriesCopyWith<_$_RecordSeries> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_StopRecordingProgramCopyWith<$Res> {
  factory _$$_StopRecordingProgramCopyWith(_$_StopRecordingProgram value,
          $Res Function(_$_StopRecordingProgram) then) =
      __$$_StopRecordingProgramCopyWithImpl<$Res>;
  $Res call(
      {int channelIndex,
      int programIndex,
      void Function(List<Channel>) callback});
}

/// @nodoc
class __$$_StopRecordingProgramCopyWithImpl<$Res>
    extends _$ChannelEventCopyWithImpl<$Res>
    implements _$$_StopRecordingProgramCopyWith<$Res> {
  __$$_StopRecordingProgramCopyWithImpl(_$_StopRecordingProgram _value,
      $Res Function(_$_StopRecordingProgram) _then)
      : super(_value, (v) => _then(v as _$_StopRecordingProgram));

  @override
  _$_StopRecordingProgram get _value => super._value as _$_StopRecordingProgram;

  @override
  $Res call({
    Object? channelIndex = freezed,
    Object? programIndex = freezed,
    Object? callback = freezed,
  }) {
    return _then(_$_StopRecordingProgram(
      channelIndex == freezed
          ? _value.channelIndex
          : channelIndex // ignore: cast_nullable_to_non_nullable
              as int,
      programIndex == freezed
          ? _value.programIndex
          : programIndex // ignore: cast_nullable_to_non_nullable
              as int,
      callback == freezed
          ? _value.callback
          : callback // ignore: cast_nullable_to_non_nullable
              as void Function(List<Channel>),
    ));
  }
}

/// @nodoc

class _$_StopRecordingProgram implements _StopRecordingProgram {
  const _$_StopRecordingProgram(
      this.channelIndex, this.programIndex, this.callback);

  @override
  final int channelIndex;
  @override
  final int programIndex;
  @override
  final void Function(List<Channel>) callback;

  @override
  String toString() {
    return 'ChannelEvent.stopRecordingProgram(channelIndex: $channelIndex, programIndex: $programIndex, callback: $callback)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StopRecordingProgram &&
            const DeepCollectionEquality()
                .equals(other.channelIndex, channelIndex) &&
            const DeepCollectionEquality()
                .equals(other.programIndex, programIndex) &&
            (identical(other.callback, callback) ||
                other.callback == callback));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(channelIndex),
      const DeepCollectionEquality().hash(programIndex),
      callback);

  @JsonKey(ignore: true)
  @override
  _$$_StopRecordingProgramCopyWith<_$_StopRecordingProgram> get copyWith =>
      __$$_StopRecordingProgramCopyWithImpl<_$_StopRecordingProgram>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? timestamp) fetch,
    required TResult Function() reloadChannels,
    required TResult Function() reloadDvr,
    required TResult Function(int index) changeChannel,
    required TResult Function(int index) changeGenre,
    required TResult Function(int channelIndex, int channelGenre)
        changeChannelAndGenre,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordProgram,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordSeries,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        stopRecordingProgram,
    required TResult Function(List<Channel> channels)
        forceUpdateFilteredChannels,
    required TResult Function(String epgChannelId, void Function() callback)
        addFavoriteChannel,
    required TResult Function(String epgChannelId, void Function() callback)
        removeFavoriteChannel,
    required TResult Function(void Function()? callback) clean,
    required TResult Function(bool increment) traverseChannel,
    required TResult Function(String epgSeriesId) updateProgramRecordStatus,
  }) {
    return stopRecordingProgram(channelIndex, programIndex, callback);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
  }) {
    return stopRecordingProgram?.call(channelIndex, programIndex, callback);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (stopRecordingProgram != null) {
      return stopRecordingProgram(channelIndex, programIndex, callback);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) fetch,
    required TResult Function(_ReloadChannels value) reloadChannels,
    required TResult Function(_ReloadDvr value) reloadDvr,
    required TResult Function(_ChangeChannel value) changeChannel,
    required TResult Function(_ChangeGenre value) changeGenre,
    required TResult Function(_ChangeChannelAndGenre value)
        changeChannelAndGenre,
    required TResult Function(_RecordProgram value) recordProgram,
    required TResult Function(_RecordSeries value) recordSeries,
    required TResult Function(_StopRecordingProgram value) stopRecordingProgram,
    required TResult Function(_ForceUpdateFilteredChannels value)
        forceUpdateFilteredChannels,
    required TResult Function(_AddFavoriteChannel value) addFavoriteChannel,
    required TResult Function(_RemoveFavoriteChannel value)
        removeFavoriteChannel,
    required TResult Function(_Clean value) clean,
    required TResult Function(_TraverseChannel value) traverseChannel,
    required TResult Function(_UpdateProgramRecordStatus value)
        updateProgramRecordStatus,
  }) {
    return stopRecordingProgram(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
  }) {
    return stopRecordingProgram?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (stopRecordingProgram != null) {
      return stopRecordingProgram(this);
    }
    return orElse();
  }
}

abstract class _StopRecordingProgram implements ChannelEvent {
  const factory _StopRecordingProgram(
      final int channelIndex,
      final int programIndex,
      final void Function(List<Channel>) callback) = _$_StopRecordingProgram;

  int get channelIndex;
  int get programIndex;
  void Function(List<Channel>) get callback;
  @JsonKey(ignore: true)
  _$$_StopRecordingProgramCopyWith<_$_StopRecordingProgram> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ForceUpdateFilteredChannelsCopyWith<$Res> {
  factory _$$_ForceUpdateFilteredChannelsCopyWith(
          _$_ForceUpdateFilteredChannels value,
          $Res Function(_$_ForceUpdateFilteredChannels) then) =
      __$$_ForceUpdateFilteredChannelsCopyWithImpl<$Res>;
  $Res call({List<Channel> channels});
}

/// @nodoc
class __$$_ForceUpdateFilteredChannelsCopyWithImpl<$Res>
    extends _$ChannelEventCopyWithImpl<$Res>
    implements _$$_ForceUpdateFilteredChannelsCopyWith<$Res> {
  __$$_ForceUpdateFilteredChannelsCopyWithImpl(
      _$_ForceUpdateFilteredChannels _value,
      $Res Function(_$_ForceUpdateFilteredChannels) _then)
      : super(_value, (v) => _then(v as _$_ForceUpdateFilteredChannels));

  @override
  _$_ForceUpdateFilteredChannels get _value =>
      super._value as _$_ForceUpdateFilteredChannels;

  @override
  $Res call({
    Object? channels = freezed,
  }) {
    return _then(_$_ForceUpdateFilteredChannels(
      channels == freezed
          ? _value.channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<Channel>,
    ));
  }
}

/// @nodoc

class _$_ForceUpdateFilteredChannels implements _ForceUpdateFilteredChannels {
  const _$_ForceUpdateFilteredChannels(this.channels);

  @override
  final List<Channel> channels;

  @override
  String toString() {
    return 'ChannelEvent.forceUpdateFilteredChannels(channels: $channels)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ForceUpdateFilteredChannels &&
            const DeepCollectionEquality().equals(other.channels, channels));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(channels));

  @JsonKey(ignore: true)
  @override
  _$$_ForceUpdateFilteredChannelsCopyWith<_$_ForceUpdateFilteredChannels>
      get copyWith => __$$_ForceUpdateFilteredChannelsCopyWithImpl<
          _$_ForceUpdateFilteredChannels>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? timestamp) fetch,
    required TResult Function() reloadChannels,
    required TResult Function() reloadDvr,
    required TResult Function(int index) changeChannel,
    required TResult Function(int index) changeGenre,
    required TResult Function(int channelIndex, int channelGenre)
        changeChannelAndGenre,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordProgram,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordSeries,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        stopRecordingProgram,
    required TResult Function(List<Channel> channels)
        forceUpdateFilteredChannels,
    required TResult Function(String epgChannelId, void Function() callback)
        addFavoriteChannel,
    required TResult Function(String epgChannelId, void Function() callback)
        removeFavoriteChannel,
    required TResult Function(void Function()? callback) clean,
    required TResult Function(bool increment) traverseChannel,
    required TResult Function(String epgSeriesId) updateProgramRecordStatus,
  }) {
    return forceUpdateFilteredChannels(channels);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
  }) {
    return forceUpdateFilteredChannels?.call(channels);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (forceUpdateFilteredChannels != null) {
      return forceUpdateFilteredChannels(channels);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) fetch,
    required TResult Function(_ReloadChannels value) reloadChannels,
    required TResult Function(_ReloadDvr value) reloadDvr,
    required TResult Function(_ChangeChannel value) changeChannel,
    required TResult Function(_ChangeGenre value) changeGenre,
    required TResult Function(_ChangeChannelAndGenre value)
        changeChannelAndGenre,
    required TResult Function(_RecordProgram value) recordProgram,
    required TResult Function(_RecordSeries value) recordSeries,
    required TResult Function(_StopRecordingProgram value) stopRecordingProgram,
    required TResult Function(_ForceUpdateFilteredChannels value)
        forceUpdateFilteredChannels,
    required TResult Function(_AddFavoriteChannel value) addFavoriteChannel,
    required TResult Function(_RemoveFavoriteChannel value)
        removeFavoriteChannel,
    required TResult Function(_Clean value) clean,
    required TResult Function(_TraverseChannel value) traverseChannel,
    required TResult Function(_UpdateProgramRecordStatus value)
        updateProgramRecordStatus,
  }) {
    return forceUpdateFilteredChannels(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
  }) {
    return forceUpdateFilteredChannels?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (forceUpdateFilteredChannels != null) {
      return forceUpdateFilteredChannels(this);
    }
    return orElse();
  }
}

abstract class _ForceUpdateFilteredChannels implements ChannelEvent {
  const factory _ForceUpdateFilteredChannels(final List<Channel> channels) =
      _$_ForceUpdateFilteredChannels;

  List<Channel> get channels;
  @JsonKey(ignore: true)
  _$$_ForceUpdateFilteredChannelsCopyWith<_$_ForceUpdateFilteredChannels>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_AddFavoriteChannelCopyWith<$Res> {
  factory _$$_AddFavoriteChannelCopyWith(_$_AddFavoriteChannel value,
          $Res Function(_$_AddFavoriteChannel) then) =
      __$$_AddFavoriteChannelCopyWithImpl<$Res>;
  $Res call({String epgChannelId, void Function() callback});
}

/// @nodoc
class __$$_AddFavoriteChannelCopyWithImpl<$Res>
    extends _$ChannelEventCopyWithImpl<$Res>
    implements _$$_AddFavoriteChannelCopyWith<$Res> {
  __$$_AddFavoriteChannelCopyWithImpl(
      _$_AddFavoriteChannel _value, $Res Function(_$_AddFavoriteChannel) _then)
      : super(_value, (v) => _then(v as _$_AddFavoriteChannel));

  @override
  _$_AddFavoriteChannel get _value => super._value as _$_AddFavoriteChannel;

  @override
  $Res call({
    Object? epgChannelId = freezed,
    Object? callback = freezed,
  }) {
    return _then(_$_AddFavoriteChannel(
      epgChannelId == freezed
          ? _value.epgChannelId
          : epgChannelId // ignore: cast_nullable_to_non_nullable
              as String,
      callback == freezed
          ? _value.callback
          : callback // ignore: cast_nullable_to_non_nullable
              as void Function(),
    ));
  }
}

/// @nodoc

class _$_AddFavoriteChannel implements _AddFavoriteChannel {
  const _$_AddFavoriteChannel(this.epgChannelId, this.callback);

  @override
  final String epgChannelId;
  @override
  final void Function() callback;

  @override
  String toString() {
    return 'ChannelEvent.addFavoriteChannel(epgChannelId: $epgChannelId, callback: $callback)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddFavoriteChannel &&
            const DeepCollectionEquality()
                .equals(other.epgChannelId, epgChannelId) &&
            (identical(other.callback, callback) ||
                other.callback == callback));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(epgChannelId), callback);

  @JsonKey(ignore: true)
  @override
  _$$_AddFavoriteChannelCopyWith<_$_AddFavoriteChannel> get copyWith =>
      __$$_AddFavoriteChannelCopyWithImpl<_$_AddFavoriteChannel>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? timestamp) fetch,
    required TResult Function() reloadChannels,
    required TResult Function() reloadDvr,
    required TResult Function(int index) changeChannel,
    required TResult Function(int index) changeGenre,
    required TResult Function(int channelIndex, int channelGenre)
        changeChannelAndGenre,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordProgram,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordSeries,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        stopRecordingProgram,
    required TResult Function(List<Channel> channels)
        forceUpdateFilteredChannels,
    required TResult Function(String epgChannelId, void Function() callback)
        addFavoriteChannel,
    required TResult Function(String epgChannelId, void Function() callback)
        removeFavoriteChannel,
    required TResult Function(void Function()? callback) clean,
    required TResult Function(bool increment) traverseChannel,
    required TResult Function(String epgSeriesId) updateProgramRecordStatus,
  }) {
    return addFavoriteChannel(epgChannelId, callback);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
  }) {
    return addFavoriteChannel?.call(epgChannelId, callback);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (addFavoriteChannel != null) {
      return addFavoriteChannel(epgChannelId, callback);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) fetch,
    required TResult Function(_ReloadChannels value) reloadChannels,
    required TResult Function(_ReloadDvr value) reloadDvr,
    required TResult Function(_ChangeChannel value) changeChannel,
    required TResult Function(_ChangeGenre value) changeGenre,
    required TResult Function(_ChangeChannelAndGenre value)
        changeChannelAndGenre,
    required TResult Function(_RecordProgram value) recordProgram,
    required TResult Function(_RecordSeries value) recordSeries,
    required TResult Function(_StopRecordingProgram value) stopRecordingProgram,
    required TResult Function(_ForceUpdateFilteredChannels value)
        forceUpdateFilteredChannels,
    required TResult Function(_AddFavoriteChannel value) addFavoriteChannel,
    required TResult Function(_RemoveFavoriteChannel value)
        removeFavoriteChannel,
    required TResult Function(_Clean value) clean,
    required TResult Function(_TraverseChannel value) traverseChannel,
    required TResult Function(_UpdateProgramRecordStatus value)
        updateProgramRecordStatus,
  }) {
    return addFavoriteChannel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
  }) {
    return addFavoriteChannel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (addFavoriteChannel != null) {
      return addFavoriteChannel(this);
    }
    return orElse();
  }
}

abstract class _AddFavoriteChannel implements ChannelEvent {
  const factory _AddFavoriteChannel(
          final String epgChannelId, final void Function() callback) =
      _$_AddFavoriteChannel;

  String get epgChannelId;
  void Function() get callback;
  @JsonKey(ignore: true)
  _$$_AddFavoriteChannelCopyWith<_$_AddFavoriteChannel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_RemoveFavoriteChannelCopyWith<$Res> {
  factory _$$_RemoveFavoriteChannelCopyWith(_$_RemoveFavoriteChannel value,
          $Res Function(_$_RemoveFavoriteChannel) then) =
      __$$_RemoveFavoriteChannelCopyWithImpl<$Res>;
  $Res call({String epgChannelId, void Function() callback});
}

/// @nodoc
class __$$_RemoveFavoriteChannelCopyWithImpl<$Res>
    extends _$ChannelEventCopyWithImpl<$Res>
    implements _$$_RemoveFavoriteChannelCopyWith<$Res> {
  __$$_RemoveFavoriteChannelCopyWithImpl(_$_RemoveFavoriteChannel _value,
      $Res Function(_$_RemoveFavoriteChannel) _then)
      : super(_value, (v) => _then(v as _$_RemoveFavoriteChannel));

  @override
  _$_RemoveFavoriteChannel get _value =>
      super._value as _$_RemoveFavoriteChannel;

  @override
  $Res call({
    Object? epgChannelId = freezed,
    Object? callback = freezed,
  }) {
    return _then(_$_RemoveFavoriteChannel(
      epgChannelId == freezed
          ? _value.epgChannelId
          : epgChannelId // ignore: cast_nullable_to_non_nullable
              as String,
      callback == freezed
          ? _value.callback
          : callback // ignore: cast_nullable_to_non_nullable
              as void Function(),
    ));
  }
}

/// @nodoc

class _$_RemoveFavoriteChannel implements _RemoveFavoriteChannel {
  const _$_RemoveFavoriteChannel(this.epgChannelId, this.callback);

  @override
  final String epgChannelId;
  @override
  final void Function() callback;

  @override
  String toString() {
    return 'ChannelEvent.removeFavoriteChannel(epgChannelId: $epgChannelId, callback: $callback)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RemoveFavoriteChannel &&
            const DeepCollectionEquality()
                .equals(other.epgChannelId, epgChannelId) &&
            (identical(other.callback, callback) ||
                other.callback == callback));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(epgChannelId), callback);

  @JsonKey(ignore: true)
  @override
  _$$_RemoveFavoriteChannelCopyWith<_$_RemoveFavoriteChannel> get copyWith =>
      __$$_RemoveFavoriteChannelCopyWithImpl<_$_RemoveFavoriteChannel>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? timestamp) fetch,
    required TResult Function() reloadChannels,
    required TResult Function() reloadDvr,
    required TResult Function(int index) changeChannel,
    required TResult Function(int index) changeGenre,
    required TResult Function(int channelIndex, int channelGenre)
        changeChannelAndGenre,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordProgram,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordSeries,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        stopRecordingProgram,
    required TResult Function(List<Channel> channels)
        forceUpdateFilteredChannels,
    required TResult Function(String epgChannelId, void Function() callback)
        addFavoriteChannel,
    required TResult Function(String epgChannelId, void Function() callback)
        removeFavoriteChannel,
    required TResult Function(void Function()? callback) clean,
    required TResult Function(bool increment) traverseChannel,
    required TResult Function(String epgSeriesId) updateProgramRecordStatus,
  }) {
    return removeFavoriteChannel(epgChannelId, callback);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
  }) {
    return removeFavoriteChannel?.call(epgChannelId, callback);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (removeFavoriteChannel != null) {
      return removeFavoriteChannel(epgChannelId, callback);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) fetch,
    required TResult Function(_ReloadChannels value) reloadChannels,
    required TResult Function(_ReloadDvr value) reloadDvr,
    required TResult Function(_ChangeChannel value) changeChannel,
    required TResult Function(_ChangeGenre value) changeGenre,
    required TResult Function(_ChangeChannelAndGenre value)
        changeChannelAndGenre,
    required TResult Function(_RecordProgram value) recordProgram,
    required TResult Function(_RecordSeries value) recordSeries,
    required TResult Function(_StopRecordingProgram value) stopRecordingProgram,
    required TResult Function(_ForceUpdateFilteredChannels value)
        forceUpdateFilteredChannels,
    required TResult Function(_AddFavoriteChannel value) addFavoriteChannel,
    required TResult Function(_RemoveFavoriteChannel value)
        removeFavoriteChannel,
    required TResult Function(_Clean value) clean,
    required TResult Function(_TraverseChannel value) traverseChannel,
    required TResult Function(_UpdateProgramRecordStatus value)
        updateProgramRecordStatus,
  }) {
    return removeFavoriteChannel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
  }) {
    return removeFavoriteChannel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (removeFavoriteChannel != null) {
      return removeFavoriteChannel(this);
    }
    return orElse();
  }
}

abstract class _RemoveFavoriteChannel implements ChannelEvent {
  const factory _RemoveFavoriteChannel(
          final String epgChannelId, final void Function() callback) =
      _$_RemoveFavoriteChannel;

  String get epgChannelId;
  void Function() get callback;
  @JsonKey(ignore: true)
  _$$_RemoveFavoriteChannelCopyWith<_$_RemoveFavoriteChannel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_CleanCopyWith<$Res> {
  factory _$$_CleanCopyWith(_$_Clean value, $Res Function(_$_Clean) then) =
      __$$_CleanCopyWithImpl<$Res>;
  $Res call({void Function()? callback});
}

/// @nodoc
class __$$_CleanCopyWithImpl<$Res> extends _$ChannelEventCopyWithImpl<$Res>
    implements _$$_CleanCopyWith<$Res> {
  __$$_CleanCopyWithImpl(_$_Clean _value, $Res Function(_$_Clean) _then)
      : super(_value, (v) => _then(v as _$_Clean));

  @override
  _$_Clean get _value => super._value as _$_Clean;

  @override
  $Res call({
    Object? callback = freezed,
  }) {
    return _then(_$_Clean(
      callback == freezed
          ? _value.callback
          : callback // ignore: cast_nullable_to_non_nullable
              as void Function()?,
    ));
  }
}

/// @nodoc

class _$_Clean implements _Clean {
  const _$_Clean(this.callback);

  @override
  final void Function()? callback;

  @override
  String toString() {
    return 'ChannelEvent.clean(callback: $callback)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Clean &&
            (identical(other.callback, callback) ||
                other.callback == callback));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callback);

  @JsonKey(ignore: true)
  @override
  _$$_CleanCopyWith<_$_Clean> get copyWith =>
      __$$_CleanCopyWithImpl<_$_Clean>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? timestamp) fetch,
    required TResult Function() reloadChannels,
    required TResult Function() reloadDvr,
    required TResult Function(int index) changeChannel,
    required TResult Function(int index) changeGenre,
    required TResult Function(int channelIndex, int channelGenre)
        changeChannelAndGenre,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordProgram,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordSeries,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        stopRecordingProgram,
    required TResult Function(List<Channel> channels)
        forceUpdateFilteredChannels,
    required TResult Function(String epgChannelId, void Function() callback)
        addFavoriteChannel,
    required TResult Function(String epgChannelId, void Function() callback)
        removeFavoriteChannel,
    required TResult Function(void Function()? callback) clean,
    required TResult Function(bool increment) traverseChannel,
    required TResult Function(String epgSeriesId) updateProgramRecordStatus,
  }) {
    return clean(callback);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
  }) {
    return clean?.call(callback);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (clean != null) {
      return clean(callback);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) fetch,
    required TResult Function(_ReloadChannels value) reloadChannels,
    required TResult Function(_ReloadDvr value) reloadDvr,
    required TResult Function(_ChangeChannel value) changeChannel,
    required TResult Function(_ChangeGenre value) changeGenre,
    required TResult Function(_ChangeChannelAndGenre value)
        changeChannelAndGenre,
    required TResult Function(_RecordProgram value) recordProgram,
    required TResult Function(_RecordSeries value) recordSeries,
    required TResult Function(_StopRecordingProgram value) stopRecordingProgram,
    required TResult Function(_ForceUpdateFilteredChannels value)
        forceUpdateFilteredChannels,
    required TResult Function(_AddFavoriteChannel value) addFavoriteChannel,
    required TResult Function(_RemoveFavoriteChannel value)
        removeFavoriteChannel,
    required TResult Function(_Clean value) clean,
    required TResult Function(_TraverseChannel value) traverseChannel,
    required TResult Function(_UpdateProgramRecordStatus value)
        updateProgramRecordStatus,
  }) {
    return clean(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
  }) {
    return clean?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (clean != null) {
      return clean(this);
    }
    return orElse();
  }
}

abstract class _Clean implements ChannelEvent {
  const factory _Clean(final void Function()? callback) = _$_Clean;

  void Function()? get callback;
  @JsonKey(ignore: true)
  _$$_CleanCopyWith<_$_Clean> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_TraverseChannelCopyWith<$Res> {
  factory _$$_TraverseChannelCopyWith(
          _$_TraverseChannel value, $Res Function(_$_TraverseChannel) then) =
      __$$_TraverseChannelCopyWithImpl<$Res>;
  $Res call({bool increment});
}

/// @nodoc
class __$$_TraverseChannelCopyWithImpl<$Res>
    extends _$ChannelEventCopyWithImpl<$Res>
    implements _$$_TraverseChannelCopyWith<$Res> {
  __$$_TraverseChannelCopyWithImpl(
      _$_TraverseChannel _value, $Res Function(_$_TraverseChannel) _then)
      : super(_value, (v) => _then(v as _$_TraverseChannel));

  @override
  _$_TraverseChannel get _value => super._value as _$_TraverseChannel;

  @override
  $Res call({
    Object? increment = freezed,
  }) {
    return _then(_$_TraverseChannel(
      increment: increment == freezed
          ? _value.increment
          : increment // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_TraverseChannel implements _TraverseChannel {
  const _$_TraverseChannel({required this.increment});

  @override
  final bool increment;

  @override
  String toString() {
    return 'ChannelEvent.traverseChannel(increment: $increment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TraverseChannel &&
            const DeepCollectionEquality().equals(other.increment, increment));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(increment));

  @JsonKey(ignore: true)
  @override
  _$$_TraverseChannelCopyWith<_$_TraverseChannel> get copyWith =>
      __$$_TraverseChannelCopyWithImpl<_$_TraverseChannel>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? timestamp) fetch,
    required TResult Function() reloadChannels,
    required TResult Function() reloadDvr,
    required TResult Function(int index) changeChannel,
    required TResult Function(int index) changeGenre,
    required TResult Function(int channelIndex, int channelGenre)
        changeChannelAndGenre,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordProgram,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordSeries,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        stopRecordingProgram,
    required TResult Function(List<Channel> channels)
        forceUpdateFilteredChannels,
    required TResult Function(String epgChannelId, void Function() callback)
        addFavoriteChannel,
    required TResult Function(String epgChannelId, void Function() callback)
        removeFavoriteChannel,
    required TResult Function(void Function()? callback) clean,
    required TResult Function(bool increment) traverseChannel,
    required TResult Function(String epgSeriesId) updateProgramRecordStatus,
  }) {
    return traverseChannel(increment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
  }) {
    return traverseChannel?.call(increment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (traverseChannel != null) {
      return traverseChannel(increment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) fetch,
    required TResult Function(_ReloadChannels value) reloadChannels,
    required TResult Function(_ReloadDvr value) reloadDvr,
    required TResult Function(_ChangeChannel value) changeChannel,
    required TResult Function(_ChangeGenre value) changeGenre,
    required TResult Function(_ChangeChannelAndGenre value)
        changeChannelAndGenre,
    required TResult Function(_RecordProgram value) recordProgram,
    required TResult Function(_RecordSeries value) recordSeries,
    required TResult Function(_StopRecordingProgram value) stopRecordingProgram,
    required TResult Function(_ForceUpdateFilteredChannels value)
        forceUpdateFilteredChannels,
    required TResult Function(_AddFavoriteChannel value) addFavoriteChannel,
    required TResult Function(_RemoveFavoriteChannel value)
        removeFavoriteChannel,
    required TResult Function(_Clean value) clean,
    required TResult Function(_TraverseChannel value) traverseChannel,
    required TResult Function(_UpdateProgramRecordStatus value)
        updateProgramRecordStatus,
  }) {
    return traverseChannel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
  }) {
    return traverseChannel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (traverseChannel != null) {
      return traverseChannel(this);
    }
    return orElse();
  }
}

abstract class _TraverseChannel implements ChannelEvent {
  const factory _TraverseChannel({required final bool increment}) =
      _$_TraverseChannel;

  bool get increment;
  @JsonKey(ignore: true)
  _$$_TraverseChannelCopyWith<_$_TraverseChannel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UpdateProgramRecordStatusCopyWith<$Res> {
  factory _$$_UpdateProgramRecordStatusCopyWith(
          _$_UpdateProgramRecordStatus value,
          $Res Function(_$_UpdateProgramRecordStatus) then) =
      __$$_UpdateProgramRecordStatusCopyWithImpl<$Res>;
  $Res call({String epgSeriesId});
}

/// @nodoc
class __$$_UpdateProgramRecordStatusCopyWithImpl<$Res>
    extends _$ChannelEventCopyWithImpl<$Res>
    implements _$$_UpdateProgramRecordStatusCopyWith<$Res> {
  __$$_UpdateProgramRecordStatusCopyWithImpl(
      _$_UpdateProgramRecordStatus _value,
      $Res Function(_$_UpdateProgramRecordStatus) _then)
      : super(_value, (v) => _then(v as _$_UpdateProgramRecordStatus));

  @override
  _$_UpdateProgramRecordStatus get _value =>
      super._value as _$_UpdateProgramRecordStatus;

  @override
  $Res call({
    Object? epgSeriesId = freezed,
  }) {
    return _then(_$_UpdateProgramRecordStatus(
      epgSeriesId: epgSeriesId == freezed
          ? _value.epgSeriesId
          : epgSeriesId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_UpdateProgramRecordStatus implements _UpdateProgramRecordStatus {
  const _$_UpdateProgramRecordStatus({required this.epgSeriesId});

  @override
  final String epgSeriesId;

  @override
  String toString() {
    return 'ChannelEvent.updateProgramRecordStatus(epgSeriesId: $epgSeriesId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateProgramRecordStatus &&
            const DeepCollectionEquality()
                .equals(other.epgSeriesId, epgSeriesId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(epgSeriesId));

  @JsonKey(ignore: true)
  @override
  _$$_UpdateProgramRecordStatusCopyWith<_$_UpdateProgramRecordStatus>
      get copyWith => __$$_UpdateProgramRecordStatusCopyWithImpl<
          _$_UpdateProgramRecordStatus>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? timestamp) fetch,
    required TResult Function() reloadChannels,
    required TResult Function() reloadDvr,
    required TResult Function(int index) changeChannel,
    required TResult Function(int index) changeGenre,
    required TResult Function(int channelIndex, int channelGenre)
        changeChannelAndGenre,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordProgram,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        recordSeries,
    required TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)
        stopRecordingProgram,
    required TResult Function(List<Channel> channels)
        forceUpdateFilteredChannels,
    required TResult Function(String epgChannelId, void Function() callback)
        addFavoriteChannel,
    required TResult Function(String epgChannelId, void Function() callback)
        removeFavoriteChannel,
    required TResult Function(void Function()? callback) clean,
    required TResult Function(bool increment) traverseChannel,
    required TResult Function(String epgSeriesId) updateProgramRecordStatus,
  }) {
    return updateProgramRecordStatus(epgSeriesId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
  }) {
    return updateProgramRecordStatus?.call(epgSeriesId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? timestamp)? fetch,
    TResult Function()? reloadChannels,
    TResult Function()? reloadDvr,
    TResult Function(int index)? changeChannel,
    TResult Function(int index)? changeGenre,
    TResult Function(int channelIndex, int channelGenre)? changeChannelAndGenre,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordProgram,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        recordSeries,
    TResult Function(int channelIndex, int programIndex,
            void Function(List<Channel>) callback)?
        stopRecordingProgram,
    TResult Function(List<Channel> channels)? forceUpdateFilteredChannels,
    TResult Function(String epgChannelId, void Function() callback)?
        addFavoriteChannel,
    TResult Function(String epgChannelId, void Function() callback)?
        removeFavoriteChannel,
    TResult Function(void Function()? callback)? clean,
    TResult Function(bool increment)? traverseChannel,
    TResult Function(String epgSeriesId)? updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (updateProgramRecordStatus != null) {
      return updateProgramRecordStatus(epgSeriesId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) fetch,
    required TResult Function(_ReloadChannels value) reloadChannels,
    required TResult Function(_ReloadDvr value) reloadDvr,
    required TResult Function(_ChangeChannel value) changeChannel,
    required TResult Function(_ChangeGenre value) changeGenre,
    required TResult Function(_ChangeChannelAndGenre value)
        changeChannelAndGenre,
    required TResult Function(_RecordProgram value) recordProgram,
    required TResult Function(_RecordSeries value) recordSeries,
    required TResult Function(_StopRecordingProgram value) stopRecordingProgram,
    required TResult Function(_ForceUpdateFilteredChannels value)
        forceUpdateFilteredChannels,
    required TResult Function(_AddFavoriteChannel value) addFavoriteChannel,
    required TResult Function(_RemoveFavoriteChannel value)
        removeFavoriteChannel,
    required TResult Function(_Clean value) clean,
    required TResult Function(_TraverseChannel value) traverseChannel,
    required TResult Function(_UpdateProgramRecordStatus value)
        updateProgramRecordStatus,
  }) {
    return updateProgramRecordStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
  }) {
    return updateProgramRecordStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? fetch,
    TResult Function(_ReloadChannels value)? reloadChannels,
    TResult Function(_ReloadDvr value)? reloadDvr,
    TResult Function(_ChangeChannel value)? changeChannel,
    TResult Function(_ChangeGenre value)? changeGenre,
    TResult Function(_ChangeChannelAndGenre value)? changeChannelAndGenre,
    TResult Function(_RecordProgram value)? recordProgram,
    TResult Function(_RecordSeries value)? recordSeries,
    TResult Function(_StopRecordingProgram value)? stopRecordingProgram,
    TResult Function(_ForceUpdateFilteredChannels value)?
        forceUpdateFilteredChannels,
    TResult Function(_AddFavoriteChannel value)? addFavoriteChannel,
    TResult Function(_RemoveFavoriteChannel value)? removeFavoriteChannel,
    TResult Function(_Clean value)? clean,
    TResult Function(_TraverseChannel value)? traverseChannel,
    TResult Function(_UpdateProgramRecordStatus value)?
        updateProgramRecordStatus,
    required TResult orElse(),
  }) {
    if (updateProgramRecordStatus != null) {
      return updateProgramRecordStatus(this);
    }
    return orElse();
  }
}

abstract class _UpdateProgramRecordStatus implements ChannelEvent {
  const factory _UpdateProgramRecordStatus(
      {required final String epgSeriesId}) = _$_UpdateProgramRecordStatus;

  String get epgSeriesId;
  @JsonKey(ignore: true)
  _$$_UpdateProgramRecordStatusCopyWith<_$_UpdateProgramRecordStatus>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChannelState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Channel> channels,
            Set<String> genres,
            num spacePurchased,
            num spaceUsed,
            num spaceRemaining,
            int channelSelected,
            int genreSelected,
            List<Channel> filteredChannels)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Channel> channels,
            Set<String> genres,
            num spacePurchased,
            num spaceUsed,
            num spaceRemaining,
            int channelSelected,
            int genreSelected,
            List<Channel> filteredChannels)?
        loaded,
    TResult Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Channel> channels,
            Set<String> genres,
            num spacePurchased,
            num spaceUsed,
            num spaceRemaining,
            int channelSelected,
            int genreSelected,
            List<Channel> filteredChannels)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelStateCopyWith<$Res> {
  factory $ChannelStateCopyWith(
          ChannelState value, $Res Function(ChannelState) then) =
      _$ChannelStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ChannelStateCopyWithImpl<$Res> implements $ChannelStateCopyWith<$Res> {
  _$ChannelStateCopyWithImpl(this._value, this._then);

  final ChannelState _value;
  // ignore: unused_field
  final $Res Function(ChannelState) _then;
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res> extends _$ChannelStateCopyWithImpl<$Res>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, (v) => _then(v as _$_Initial));

  @override
  _$_Initial get _value => super._value as _$_Initial;
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'ChannelState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Channel> channels,
            Set<String> genres,
            num spacePurchased,
            num spaceUsed,
            num spaceRemaining,
            int channelSelected,
            int genreSelected,
            List<Channel> filteredChannels)
        loaded,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Channel> channels,
            Set<String> genres,
            num spacePurchased,
            num spaceUsed,
            num spaceRemaining,
            int channelSelected,
            int genreSelected,
            List<Channel> filteredChannels)?
        loaded,
    TResult Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Channel> channels,
            Set<String> genres,
            num spacePurchased,
            num spaceUsed,
            num spaceRemaining,
            int channelSelected,
            int genreSelected,
            List<Channel> filteredChannels)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ChannelState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<$Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading value, $Res Function(_$_Loading) then) =
      __$$_LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<$Res> extends _$ChannelStateCopyWithImpl<$Res>
    implements _$$_LoadingCopyWith<$Res> {
  __$$_LoadingCopyWithImpl(_$_Loading _value, $Res Function(_$_Loading) _then)
      : super(_value, (v) => _then(v as _$_Loading));

  @override
  _$_Loading get _value => super._value as _$_Loading;
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading();

  @override
  String toString() {
    return 'ChannelState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Channel> channels,
            Set<String> genres,
            num spacePurchased,
            num spaceUsed,
            num spaceRemaining,
            int channelSelected,
            int genreSelected,
            List<Channel> filteredChannels)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Channel> channels,
            Set<String> genres,
            num spacePurchased,
            num spaceUsed,
            num spaceRemaining,
            int channelSelected,
            int genreSelected,
            List<Channel> filteredChannels)?
        loaded,
    TResult Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Channel> channels,
            Set<String> genres,
            num spacePurchased,
            num spaceUsed,
            num spaceRemaining,
            int channelSelected,
            int genreSelected,
            List<Channel> filteredChannels)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ChannelState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$$_LoadedCopyWith<$Res> {
  factory _$$_LoadedCopyWith(_$_Loaded value, $Res Function(_$_Loaded) then) =
      __$$_LoadedCopyWithImpl<$Res>;
  $Res call(
      {List<Channel> channels,
      Set<String> genres,
      num spacePurchased,
      num spaceUsed,
      num spaceRemaining,
      int channelSelected,
      int genreSelected,
      List<Channel> filteredChannels});
}

/// @nodoc
class __$$_LoadedCopyWithImpl<$Res> extends _$ChannelStateCopyWithImpl<$Res>
    implements _$$_LoadedCopyWith<$Res> {
  __$$_LoadedCopyWithImpl(_$_Loaded _value, $Res Function(_$_Loaded) _then)
      : super(_value, (v) => _then(v as _$_Loaded));

  @override
  _$_Loaded get _value => super._value as _$_Loaded;

  @override
  $Res call({
    Object? channels = freezed,
    Object? genres = freezed,
    Object? spacePurchased = freezed,
    Object? spaceUsed = freezed,
    Object? spaceRemaining = freezed,
    Object? channelSelected = freezed,
    Object? genreSelected = freezed,
    Object? filteredChannels = freezed,
  }) {
    return _then(_$_Loaded(
      channels: channels == freezed
          ? _value.channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<Channel>,
      genres: genres == freezed
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      spacePurchased: spacePurchased == freezed
          ? _value.spacePurchased
          : spacePurchased // ignore: cast_nullable_to_non_nullable
              as num,
      spaceUsed: spaceUsed == freezed
          ? _value.spaceUsed
          : spaceUsed // ignore: cast_nullable_to_non_nullable
              as num,
      spaceRemaining: spaceRemaining == freezed
          ? _value.spaceRemaining
          : spaceRemaining // ignore: cast_nullable_to_non_nullable
              as num,
      channelSelected: channelSelected == freezed
          ? _value.channelSelected
          : channelSelected // ignore: cast_nullable_to_non_nullable
              as int,
      genreSelected: genreSelected == freezed
          ? _value.genreSelected
          : genreSelected // ignore: cast_nullable_to_non_nullable
              as int,
      filteredChannels: filteredChannels == freezed
          ? _value.filteredChannels
          : filteredChannels // ignore: cast_nullable_to_non_nullable
              as List<Channel>,
    ));
  }
}

/// @nodoc

class _$_Loaded implements _Loaded {
  const _$_Loaded(
      {this.channels = const <Channel>[],
      this.genres = const <String>{'All Channels', 'Favorites'},
      this.spacePurchased = 0,
      this.spaceUsed = 0,
      this.spaceRemaining = 0,
      this.channelSelected = 0,
      this.genreSelected = 0,
      this.filteredChannels = const <Channel>[]});

  @override
  @JsonKey()
  final List<Channel> channels;
  @override
  @JsonKey()
  final Set<String> genres;
  @override
  @JsonKey()
  final num spacePurchased;
  @override
  @JsonKey()
  final num spaceUsed;
  @override
  @JsonKey()
  final num spaceRemaining;
  @override
  @JsonKey()
  final int channelSelected;
  @override
  @JsonKey()
  final int genreSelected;
  @override
  @JsonKey()
  final List<Channel> filteredChannels;

  @override
  String toString() {
    return 'ChannelState.loaded(channels: $channels, genres: $genres, spacePurchased: $spacePurchased, spaceUsed: $spaceUsed, spaceRemaining: $spaceRemaining, channelSelected: $channelSelected, genreSelected: $genreSelected, filteredChannels: $filteredChannels)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Loaded &&
            const DeepCollectionEquality().equals(other.channels, channels) &&
            const DeepCollectionEquality().equals(other.genres, genres) &&
            const DeepCollectionEquality()
                .equals(other.spacePurchased, spacePurchased) &&
            const DeepCollectionEquality().equals(other.spaceUsed, spaceUsed) &&
            const DeepCollectionEquality()
                .equals(other.spaceRemaining, spaceRemaining) &&
            const DeepCollectionEquality()
                .equals(other.channelSelected, channelSelected) &&
            const DeepCollectionEquality()
                .equals(other.genreSelected, genreSelected) &&
            const DeepCollectionEquality()
                .equals(other.filteredChannels, filteredChannels));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(channels),
      const DeepCollectionEquality().hash(genres),
      const DeepCollectionEquality().hash(spacePurchased),
      const DeepCollectionEquality().hash(spaceUsed),
      const DeepCollectionEquality().hash(spaceRemaining),
      const DeepCollectionEquality().hash(channelSelected),
      const DeepCollectionEquality().hash(genreSelected),
      const DeepCollectionEquality().hash(filteredChannels));

  @JsonKey(ignore: true)
  @override
  _$$_LoadedCopyWith<_$_Loaded> get copyWith =>
      __$$_LoadedCopyWithImpl<_$_Loaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Channel> channels,
            Set<String> genres,
            num spacePurchased,
            num spaceUsed,
            num spaceRemaining,
            int channelSelected,
            int genreSelected,
            List<Channel> filteredChannels)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(channels, genres, spacePurchased, spaceUsed, spaceRemaining,
        channelSelected, genreSelected, filteredChannels);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Channel> channels,
            Set<String> genres,
            num spacePurchased,
            num spaceUsed,
            num spaceRemaining,
            int channelSelected,
            int genreSelected,
            List<Channel> filteredChannels)?
        loaded,
    TResult Function(String error)? error,
  }) {
    return loaded?.call(channels, genres, spacePurchased, spaceUsed,
        spaceRemaining, channelSelected, genreSelected, filteredChannels);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Channel> channels,
            Set<String> genres,
            num spacePurchased,
            num spaceUsed,
            num spaceRemaining,
            int channelSelected,
            int genreSelected,
            List<Channel> filteredChannels)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(channels, genres, spacePurchased, spaceUsed, spaceRemaining,
          channelSelected, genreSelected, filteredChannels);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements ChannelState {
  const factory _Loaded(
      {final List<Channel> channels,
      final Set<String> genres,
      final num spacePurchased,
      final num spaceUsed,
      final num spaceRemaining,
      final int channelSelected,
      final int genreSelected,
      final List<Channel> filteredChannels}) = _$_Loaded;

  List<Channel> get channels;
  Set<String> get genres;
  num get spacePurchased;
  num get spaceUsed;
  num get spaceRemaining;
  int get channelSelected;
  int get genreSelected;
  List<Channel> get filteredChannels;
  @JsonKey(ignore: true)
  _$$_LoadedCopyWith<_$_Loaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorCopyWith<$Res> {
  factory _$$_ErrorCopyWith(_$_Error value, $Res Function(_$_Error) then) =
      __$$_ErrorCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class __$$_ErrorCopyWithImpl<$Res> extends _$ChannelStateCopyWithImpl<$Res>
    implements _$$_ErrorCopyWith<$Res> {
  __$$_ErrorCopyWithImpl(_$_Error _value, $Res Function(_$_Error) _then)
      : super(_value, (v) => _then(v as _$_Error));

  @override
  _$_Error get _value => super._value as _$_Error;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$_Error(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Error implements _Error {
  const _$_Error(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'ChannelState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Error &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      __$$_ErrorCopyWithImpl<_$_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Channel> channels,
            Set<String> genres,
            num spacePurchased,
            num spaceUsed,
            num spaceRemaining,
            int channelSelected,
            int genreSelected,
            List<Channel> filteredChannels)
        loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Channel> channels,
            Set<String> genres,
            num spacePurchased,
            num spaceUsed,
            num spaceRemaining,
            int channelSelected,
            int genreSelected,
            List<Channel> filteredChannels)?
        loaded,
    TResult Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Channel> channels,
            Set<String> genres,
            num spacePurchased,
            num spaceUsed,
            num spaceRemaining,
            int channelSelected,
            int genreSelected,
            List<Channel> filteredChannels)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ChannelState {
  const factory _Error(final String error) = _$_Error;

  String get error;
  @JsonKey(ignore: true)
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      throw _privateConstructorUsedError;
}
