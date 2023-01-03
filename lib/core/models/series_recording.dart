import 'package:freezed_annotation/freezed_annotation.dart';

part 'series_recording.freezed.dart';
part 'series_recording.g.dart';

@freezed
class SeriesRecording with _$SeriesRecording {
  factory SeriesRecording({
    @JsonKey(name: 'Name') required String name,
    @JsonKey(name: 'Episodes') required Map<String, dynamic> episode,
  }) = _SeriesRecording;

  factory SeriesRecording.fromJson(Map<String, dynamic> json) =>
      _$SeriesRecordingFromJson(json);
}
