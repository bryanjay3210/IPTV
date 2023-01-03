import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_search_result/dvr_search_result_cubit.dart';
import 'package:iptv/app/features/saved_shows/components/dvr_menu/dvr_menu.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/helpers/date_converter.dart';
import 'package:iptv/core/models/channel_and_program.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../dvr_service.dart';
import '../../../home/bloc/channel_bloc.dart';

class DVRSearchResult extends StatefulWidget {
  const DVRSearchResult({super.key, required this.searchResult});
  final ChannelAndProgram searchResult;
  @override
  State<DVRSearchResult> createState() => _DVRSearchResultState();
}

class _DVRSearchResultState extends State<DVRSearchResult> {
  FocusNode focusNode = FocusNode();
  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DvrSearchResultCubit>().initializeCubit(widget.searchResult);
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
    return WillPopScope(
      onWillPop: () async {
        await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
            builder: (context) => const DVRView(),
          ), (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: DeviceId.isStb
            ? null
            : AppBar(
          backgroundColor: Colors.black,
          leading: BackButton(
            color: Colors.white,
            onPressed: () async {
              await Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute<void>(
                  builder: (context) => const DVRView(),
                ), (route) => false,
              );
            },
          ),
          title: const Text('Search'),
        ),
        body: BlocConsumer<DvrSearchResultCubit, DvrSearchResultState>(
          listener: (context, state) {
            if (itemScrollController.isAttached) {
              itemScrollController.scrollTo(
                index: state.currentIndex,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                alignment: 0.75,
              );
            }
          },
          builder: (context, state) {
            return RawKeyboardListener(
              focusNode: focusNode,
              onKey: (e) {
                if (e.runtimeType == RawKeyDownEvent) {
                  switch (e.logicalKey.keyLabel) {
                    case 'Arrow Up':
                      context.read<DvrSearchResultCubit>().handleUpKey();
                      break;
                    case 'Arrow Down':
                      context.read<DvrSearchResultCubit>().handleDownKey();
                      break;
                    case 'Arrow Left':
                      context.read<DvrSearchResultCubit>().handleLeftKey();
                      break;
                    case 'Arrow Right':
                      context.read<DvrSearchResultCubit>().handleRightKey();
                      break;
                    case 'Select':
                      context.read<DvrSearchResultCubit>().handleSelectKey(
                        widget.searchResult,
                        context,
                        focusNode,
                      );
                      break;
                    case 'Go Back':
                      context.read<DvrSearchResultCubit>().disableDialogControl();
                      break;
                    default:
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Visibility(visible: !DeviceId.isStb, child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 30,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.searchResult.programTitle.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Visibility(
                            visible: widget.searchResult.isRecorded == 'Y',
                            child: const Text(
                              'DVR',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        widget.searchResult.programDescription.toString(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: ListTile(
                            tileColor: state.inFilter && state.filterIndex == 0 && DeviceId.isStb
                                ? Colors.blue
                                : null,
                            title: const Text('All Episode'),
                            leading: Radio(
                              visualDensity: VisualDensity.compact,
                              value: 'AllEpisode',
                              groupValue: state.filterBy,
                              onChanged: (value) {
                                context
                                    .read<DvrSearchResultCubit>()
                                    .changeFilter(value.toString());
                                context.read<DvrSearchResultCubit>().allEpisodeFilter(widget.searchResult);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 200,
                          child: ListTile(
                            tileColor: state.inFilter && state.filterIndex == 1 && DeviceId.isStb
                                ? Colors.blue
                                : null,
                            title: const Text('New Episode'),
                            leading: Radio(
                              visualDensity: VisualDensity.compact,
                              value: 'NewEpisode',
                              groupValue: state.filterBy,
                              onChanged: (value) {
                                context
                                    .read<DvrSearchResultCubit>()
                                    .changeFilter(value.toString());
                                context.read<DvrSearchResultCubit>().newEpisodeFilter(widget.searchResult);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 200,
                          child: ListTile(
                            tileColor: state.inFilter && state.filterIndex == 2 && DeviceId.isStb
                                ? Colors.blue
                                : null,
                            title: const Text('DVR'),
                            leading: Radio(
                              visualDensity: VisualDensity.compact,
                              value: 'DVR',
                              groupValue: state.filterBy,
                              onChanged: (value) {
                                context
                                    .read<DvrSearchResultCubit>()
                                    .changeFilter(value.toString());
                                context.read<DvrSearchResultCubit>().dvrFilter(widget.searchResult);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: Row(
                        children: const [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                'Season',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(
                              'Program Title',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text(
                              'Channel',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Show Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<DvrSearchResultCubit, DvrSearchResultState>(
                        builder: (context, state) {
                          if(!state.isLoading && state.episodeList.isNotEmpty){
                            return Scrollbar(
                              child: ScrollablePositionedList.builder(
                                initialScrollIndex: state.currentIndex,
                                itemCount: state.episodeList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if(state.episodeList[index].isRecorded == 'Y'){
                                        context.read<DvrSearchResultCubit>().playInDVR(context: context, focusNode: focusNode);
                                      } else {
                                        recordDialog(context: context, state: state, index: index);
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: double.infinity,
                                          color: !state.inFilter &&
                                              state.currentIndex == index
                                              ? Colors.blue
                                              : null,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Center(
                                                  child: Text(
                                                    state.episodeList[index]
                                                        .seasonNum
                                                        .toString(),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  state.episodeList[index]
                                                      .programTitle
                                                      .toString(),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 6,
                                                child: Text(
                                                  state.episodeList[index]
                                                      .channelName
                                                      .toString(),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      state.episodeList[index]
                                                          .showDate
                                                          .toString()
                                                          .contains('-')
                                                          ? formatDateTime(
                                                        DateTime.parse(
                                                          state
                                                              .episodeList[
                                                          index]
                                                              .showDate
                                                              .toString(),
                                                        ),
                                                      )
                                                          : dateTimeStringConverter(
                                                        state
                                                            .episodeList[
                                                        index]
                                                            .showDate
                                                            .toString(),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Visibility(
                                                      visible: state
                                                          .episodeList[index]
                                                          .isRecorded ==
                                                          'Y',
                                                      child: const Text('DVR'),
                                                    ),
                                                    Visibility(
                                                      visible: state.episodeList[index].isCurrentlyRecording.toString().toLowerCase() == 'true',
                                                      child: StatefulBuilder(builder: (context, setState) {
                                                        final now = DateTime.now();
                                                        final isCurrentlyPlaying = (now.isAfter(
                                                          DateTime.parse(state.episodeList[index].showDate.toString()),
                                                        ) ||
                                                            now.isAtSameMomentAs(
                                                              DateTime.parse(state.episodeList[index].showDate.toString()),
                                                            )) &&
                                                            now.isBefore(
                                                              DateTime.parse(state.episodeList[index].showDateEnd.toString()),
                                                            );
                                                        if(isCurrentlyPlaying){
                                                          return const Icon(Icons.fiber_smart_record, color: Colors.red, size: 18,);
                                                        }
                                                        return const Icon(Icons.timer, color: Colors.white, size: 18,);
                                                      },),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        )
                                      ],
                                    ),
                                  );
                                },
                                itemScrollController: itemScrollController,
                                itemPositionsListener: itemPositionsListener,
                              ),
                            );
                          }
                          if(!state.isLoading && state.episodeList.isEmpty){
                            return const Center(
                              child: Text(
                                'Episode list is empty',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            );
                          }
                          return const Center(child: CircularProgressIndicator.adaptive(),);
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Future<void> cancelRecordDialog({
  required BuildContext context,
  required DvrSearchResultState state,
  required int index,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return BlocBuilder<DvrSearchResultCubit, DvrSearchResultState>(
        builder: (context, state) {
          return AlertDialog(
            title: const Text('Alert'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Do you want to cancel ${state.episodeList[state.currentIndex].programTitle} recording?',
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              if (state.btnLoading)
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: state.inCancelDialog && state.cancelDialogIndex == 0
                          ? Colors.blue
                          : null,
                      child: TextButton(
                        child: Text(
                          'Cancel Episode',
                          style: TextStyle(color: DeviceId.isStb ? Colors.white : Colors.blue),
                        ),
                        onPressed: () {
                          context.read<DvrSearchResultCubit>().cancelRecording(context: context, index: index);
                          Navigator.of(context).pop();
                          context.read<ChannelBloc>().add(const ChannelEvent.reloadChannels());
                          DvrService().fetchChannelAndProgram();
                          context.read<DvrSearchResultCubit>().updateProgram(context: context, index: index, fromRecording: false);
                        },
                      ),
                    ),
                    Container(
                      color: state.inCancelDialog && state.cancelDialogIndex == 1
                          ? Colors.blue
                          : null,
                      child: TextButton(
                        child: Text(
                          'Cancel Series',
                          style: TextStyle(color: DeviceId.isStb ? Colors.white : Colors.blue),
                        ),
                        onPressed: () {
                          context.read<DvrSearchResultCubit>().cancelRecording(context: context, isSeries: true, index: index);
                          Navigator.of(context).pop();
                          context.read<ChannelBloc>().add(const ChannelEvent.reloadChannels());
                          DvrService().fetchChannelAndProgram();
                          context.read<DvrSearchResultCubit>().updateProgram(context: context, index: index, fromRecording: false);
                        },
                      ),
                    ),
                    Container(
                      color: state.inCancelDialog && state.cancelDialogIndex == 2
                          ? Colors.blue
                          : null,
                      child: TextButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: DeviceId.isStb ? Colors.white : Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      );
    },
  );
}

Future<void> recordDialog({
  required BuildContext context,
  required DvrSearchResultState state,
  required int index,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return BlocBuilder<DvrSearchResultCubit, DvrSearchResultState>(
        builder: (context, state) {
          return AlertDialog(
            title: const Text('Alert'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Do you want to record ${state.episodeList[DeviceId.isStb ? state.currentIndex : index].programTitle}',
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              if (state.btnLoading)
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: state.inDialog && state.dialogIndex == 0
                          ? Colors.blue
                          : null,
                      child: TextButton(
                        child: Text(
                          'Record Episode',
                          style: TextStyle(color: DeviceId.isStb ? Colors.white : Colors.blue),
                        ),
                        onPressed: () {
                          context.read<DvrSearchResultCubit>().startRecording(context: context, index: index);
                          Navigator.of(context).pop();
                          context.read<ChannelBloc>().add(const ChannelEvent.reloadChannels());
                          DvrService().fetchChannelAndProgram();
                          context.read<DvrSearchResultCubit>().updateProgram(context: context, index: index);
                        },
                      ),
                    ),
                    Container(
                      color: state.inDialog && state.dialogIndex == 1
                          ? Colors.blue
                          : null,
                      child: TextButton(
                        child: Text(
                          'Record Series',
                          style: TextStyle(color: DeviceId.isStb ? Colors.white : Colors.blue),
                        ),
                        onPressed: () {
                          context.read<DvrSearchResultCubit>().startRecording(context: context, isSeries: true, index: index);
                          Navigator.of(context).pop();
                          context.read<ChannelBloc>().add(const ChannelEvent.reloadChannels());
                          DvrService().fetchChannelAndProgram();
                          context.read<DvrSearchResultCubit>().updateProgram(context: context, index: index);
                        },
                      ),
                    ),
                    Container(
                      color: state.inDialog && state.dialogIndex == 2
                          ? Colors.blue
                          : null,
                      child: TextButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: DeviceId.isStb ? Colors.white : Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      );
    },
  );
}
