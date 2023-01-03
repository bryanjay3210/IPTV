import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'video_control_state.dart';

class VideoControlCubit extends Cubit<VideoControlState> {
  VideoControlCubit()
      : super(
          const VideoControlState(
            captionIdx: 0,
            videoIdx: 0,
            audioIdx: 0,
            maxCaptionLength: 0,
            maxVideoLength: 0,
            maxAudioLength: 0,
          ),
        );

  void initValues(
    int captionIdx,
    int videoIdx,
    int audioIdx,
    int maxCaptionLength,
    int maxVideoLength,
    int maxAudioLength,
  ) {
    emit(
      state.copyWith(
        captionIdx: captionIdx,
        videoIdx: videoIdx,
        audioIdx: audioIdx,
        maxCaptionLength: maxCaptionLength,
        maxVideoLength: maxVideoLength,
        maxAudioLength: maxAudioLength,
      ),
    );
  }

  void updateCaptionIdx({
    bool isIncrement = true,
    int? data,
  }) {
    if (data != null) {
      emit(state.copyWith(captionIdx: data));
      return;
    }

    if (state.captionIdx == 0 && !isIncrement) return;
    if (isIncrement && state.captionIdx == state.maxCaptionLength - 1) return;

    emit(
      state.copyWith(
        captionIdx:
            data ?? (isIncrement ? state.captionIdx + 1 : state.captionIdx - 1),
      ),
    );
  }

  void updateVideoIdx({
    bool isIncrement = true,
    int? data,
  }) {
    if (data != null) {
      emit(state.copyWith(videoIdx: data));
      return;
    }

    if (state.videoIdx == 0 && !isIncrement) return;
    if (isIncrement && state.videoIdx == state.maxVideoLength - 1) return;

    emit(
      state.copyWith(
        videoIdx:
            data ?? (isIncrement ? state.videoIdx + 1 : state.videoIdx - 1),
      ),
    );
  }

  void updateAudioIdx({
    bool isIncrement = true,
    int? data,
  }) {
    if (data != null) {
      emit(state.copyWith(audioIdx: data));
      return;
    }

    if (state.audioIdx == 0 && !isIncrement) return;
    if (isIncrement && state.audioIdx == state.maxAudioLength - 1) return;

    emit(
      state.copyWith(
        audioIdx:
            data ?? (isIncrement ? state.audioIdx + 1 : state.audioIdx - 1),
      ),
    );
  }
}
