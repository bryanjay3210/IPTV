part of 'video_control_cubit.dart';

class VideoControlState extends Equatable {
  const VideoControlState({
    required this.captionIdx,
    required this.videoIdx,
    required this.audioIdx,
    required this.maxCaptionLength,
    required this.maxVideoLength,
    required this.maxAudioLength,
  });

  final int captionIdx;
  final int videoIdx;
  final int audioIdx;
  final int maxCaptionLength;
  final int maxVideoLength;
  final int maxAudioLength;

  VideoControlState copyWith({
    int? captionIdx,
    int? videoIdx,
    int? audioIdx,
    int? maxCaptionLength,
    int? maxVideoLength,
    int? maxAudioLength,
  }) {
    return VideoControlState(
      captionIdx: captionIdx ?? this.captionIdx,
      videoIdx: videoIdx ?? this.videoIdx,
      audioIdx: audioIdx ?? this.audioIdx,
      maxCaptionLength: maxCaptionLength ?? this.maxCaptionLength,
      maxVideoLength: maxVideoLength ?? this.maxVideoLength,
      maxAudioLength: maxAudioLength ?? this.maxAudioLength,
    );
  }

  @override
  List<Object?> get props => [
        captionIdx,
        videoIdx,
        audioIdx,
        maxCaptionLength,
        maxVideoLength,
        maxAudioLength,
      ];
}
