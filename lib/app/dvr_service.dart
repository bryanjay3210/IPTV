import 'package:iptv/app/features/saved_shows/bloc/dvr_menu/dvr_menu_cubit.dart';
import 'package:iptv/app/home/bloc/channel_bloc.dart';
import 'package:iptv/app/view/navigation_service.dart';
import 'package:iptv/core/models/channel_and_program.dart';
import 'package:provider/provider.dart';

class DvrService {
  static List<ChannelAndProgram> channelsAndProgram = [];

  Future<List<ChannelAndProgram>> fetchChannelAndProgram() async{
    channelsAndProgram.clear();
    final menuState = NavigationService.navigatorKey.currentContext?.read<DvrMenuCubit>().state;
    NavigationService.navigatorKey.currentContext
        ?.read<ChannelBloc>()
        .state
        .maybeMap(
      loaded: (loaded) {
        for (final rec in menuState!.recordedPrograms) {
          try {
            final channel = loaded.channels.firstWhere(
                  (element) => element.epgChannelId == rec.epgChannelId,
            );
            channelsAndProgram.add(
              ChannelAndProgram(
                channelId: rec.epgChannelId,
                channelName:
                '${channel.channelName} - ${channel.guideChannelNum}',
                seriesId: rec.epgSeriesId,
                programTitle: rec.programTitle,
                isRecorded: 'Y',
                seasonNum: rec.epgSeasonNum,
                programDescription: rec.programDescription,
                showDate: rec.programStartTime,
                isNewEpisode: rec.programNew,
                programTblRowId: rec.programTblRowId,
                showId: rec.epgShowId,
                isCurrentlyRecording: false,
                channelTblRowId: rec.channelTblRowId,
              ),
            );
          } catch (e) {
            // no-op
          }
        }

        for (final upcoming in menuState.upcomingPrograms) {
          try {
            final channel = loaded.channels.firstWhere(
                  (element) => element.epgChannelId == upcoming.epgChannelId,
            );
            channelsAndProgram.add(
              ChannelAndProgram(
                channelId: upcoming.epgChannelId,
                channelName:
                '${channel.channelName} - ${channel.guideChannelNum}',
                seriesId: upcoming.epgSeriesId,
                programTitle: upcoming.programTitle,
                isRecorded: 'N',
                seasonNum: upcoming.epgSeasonNum,
                programDescription: upcoming.programDescription,
                showDate: upcoming.programStartTime,
                showDateEnd: upcoming.programStopTime,
                isNewEpisode: upcoming.programNew,
                programTblRowId: upcoming.programTblRowId,
                showId: upcoming.epgShowId,
                isCurrentlyRecording: false,
                channelTblRowId: upcoming.channelTblRowId,
              ),
            );
          } catch (e) {
            // no-op
          }
        }

        for (final channel in loaded.channels) {
          for (final program in channel.programs!) {
            try {
              if(channelsAndProgram.where((element) => element.seriesId == program.epgSeriesId && element.programTitle == program.programTitle && element.showId == program.epgShowId,).toList().isNotEmpty){
                channelsAndProgram.removeWhere((element) => element.seriesId == program.epgSeriesId && element.programTitle == program.programTitle && element.showId == program.epgShowId,);
              }
              channelsAndProgram.add(
                ChannelAndProgram(
                    seriesId: program.epgSeriesId,
                    channelName:
                    '${channel.channelName} - ${channel.guideChannelNum}',
                    programTitle: program.programTitle,
                    channelId: channel.epgChannelId,
                    isRecorded: 'N',
                    seasonNum: program.epgSeasonNum,
                    programDescription: program.programDesc,
                    showDate: program.startEpoch,
                    showDateEnd: program.stopEpoch,
                    showId: program.epgShowId,
                    isCurrentlyRecording: program.isCurrentlyRecording,
                    channelTblRowId: channel.channelRowId
                ),
              );

            } catch (e) {
              // no-op
            }
          }
        }
      },
      orElse: () => null,
    );
    return channelsAndProgram;
  }
}
