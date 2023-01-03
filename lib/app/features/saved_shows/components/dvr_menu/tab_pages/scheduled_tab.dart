import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_menu/dvr_menu_cubit.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_menu/dvr_menu.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_movie.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_percentage_widget.dart';
import 'package:iptv/app/home/bloc/channel_bloc.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/helpers/date_converter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

Column scheduledTab({
  required BuildContext context,
  required DvrMenuState state,
  required ItemScrollController itemScrollController1,
  required ItemPositionsListener itemPositionsListener1,
}) {
  return Column(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
          child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: Row(
                        children: const [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              'Title',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              'Channel / Channel Number',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(
                              'Previously shown date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<DvrMenuCubit, DvrMenuState>(builder: (context, state) {
                        if(state.isLoading) return const Center(child: CircularProgressIndicator.adaptive(),);
                        if(!state.isLoading && state.upcomingPrograms.isEmpty) return const Center(child: Text("You don't have any upcoming programs.",),);
                        return Scrollbar(
                          child: ScrollablePositionedList.builder(
                            shrinkWrap: true,
                            itemCount: state.upcomingPrograms.length,
                            itemBuilder: (context, index) {
                              final isSelected =
                                  index == state.currentScheduledSelected;
                              return BlocBuilder<ChannelBloc, ChannelState>(builder: (context, channelState) {
                                return channelState.maybeMap(loaded: (channelState){
                                  final channel =
                                  channelState.channels.firstWhereOrNull(
                                        (element) =>
                                    element.epgChannelId ==
                                        state.upcomingPrograms[index]
                                            .epgChannelId,
                                  );
                                  return GestureDetector(
                                    onTap: () => showAlertDialog(context: context, index: index),
                                    child: Container(
                                      height: 35,
                                      color: isSelected && !state.isNavigatingTabDrawer && DeviceId.isStb ? Colors.blue : Colors.transparent,
                                      child: Row(
                                        children: [
                                          Expanded(flex: 3,child:  Text(
                                            DateFormat('EEEE M/d').format(
                                              DateFormat('yyyy/MM/dd').parse(
                                                '${state.upcomingPrograms[index].programStartTime.substring(0, 4)}/${state.upcomingPrograms[index].programStartTime.substring(4, 6)}/${state.upcomingPrograms[index].programStartTime.substring(6, 8)}',
                                              ),
                                            ),
                                          ),),
                                          Expanded(flex: 5,child: Text(state.upcomingPrograms[index].programTitle)),
                                          Expanded(flex: 5,child: Text(channel != null
                                              ? '${channel.channelName} ${channel.guideChannelNum}'
                                              : '',),),
                                          Expanded(flex: 4,child: Text(dateTimeStringConverter(
                                            state.upcomingPrograms[index]
                                                .programStopTime,),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }, orElse: Container.new,);
                              },);
                            },
                            itemScrollController: itemScrollController1,
                            itemPositionsListener: itemPositionsListener1,
                          ),
                        );
                      },),
                    ),
                  ],
                ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          DvrPercentageWidget(),
        ],
      ),
    ],
  );
}

dynamic showAlertDialog({required BuildContext context, required int index}){
  final alert = BlocBuilder<DvrMenuCubit, DvrMenuState>(
    builder: (context, state) {
      return AlertDialog(
        title: const Text('Alert'),
        content: Text(
          'Are you sure you want to delete ${state.upcomingPrograms[DeviceId.isStb ? state.currentScheduledSelected : index].programTitle}?',
        ),
        actions: [
          ColoredBox(
            color: state.currentAlertBoxSelected == 0 && DeviceId.isStb
                ? Colors.blue
                : Colors.transparent,
            child: TextButton(
              onPressed: () {
                context.read<DvrMenuCubit>().deleteScheduledProgram(context: context, index: index);
                Navigator.pop(context);
              },
              child: Text(
                'Yes',
                style: TextStyle(
                  color: state.currentAlertBoxSelected == 0 && DeviceId.isStb
                      ? Colors.white
                      : Colors.blue,
                ),
              ),
            ),
          ),
          ColoredBox(
            color: state.currentAlertBoxSelected == 1 && DeviceId.isStb
                ? Colors.blue
                : Colors.transparent,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'No',
                style: TextStyle(
                  color: state.currentAlertBoxSelected == 1 && DeviceId.isStb
                      ? Colors.white
                      : Colors.blue,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
  context.read<DvrMenuCubit>().showAlertDialog();
}
