import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_menu/dvr_menu_cubit.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_series_details/dvr_series_details_cubit.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_series_manager/dvr_series_manager_cubit.dart';
import 'package:iptv/core/device_id.dart';

class DVRSeriesDetail extends StatefulWidget {
  const DVRSeriesDetail({
    super.key,
    required this.seriesName,
    required this.seriesId,
  });
  final String seriesName;
  final String seriesId;
  @override
  State<DVRSeriesDetail> createState() => _DVRSeriesDetailState();
}

class _DVRSeriesDetailState extends State<DVRSeriesDetail> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO(mis-kcn): for validation
    context.read<DvrSeriesDetailsCubit>().initializeCubit();
    context
        .read<DvrSeriesDetailsCubit>()
        .fetchSettings(context, widget.seriesId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
    return Scaffold(
      backgroundColor: const Color(0xFF212332),
      body: SafeArea(
        child: RawKeyboardListener(
          focusNode: focusNode,
          onKey: (e) {
            FocusScope.of(context).requestFocus(focusNode);

            if (e.runtimeType == RawKeyDownEvent) {
              switch (e.logicalKey.keyLabel) {
                case 'Arrow Up':
                  context.read<DvrSeriesDetailsCubit>().handleKeyUp();
                  break;
                case 'Arrow Down':
                  context.read<DvrSeriesDetailsCubit>().handleKeyDown();
                  break;
                case 'Arrow Left':
                  context.read<DvrSeriesDetailsCubit>().handleKeyLeft();
                  break;
                case 'Arrow Right':
                  context.read<DvrSeriesDetailsCubit>().handleKeyRight();
                  break;
                case 'Select':
                  context
                      .read<DvrSeriesDetailsCubit>()
                      .handleKeySelect(context, widget.seriesId);
                  // Navigator.of(context).pop();
                  break;
                case 'Go Back':
                  context
                      .read<DvrSeriesManagerCubit>()
                      .isOnSettingsChangeValue(value: false);
                  // Navigator.of(context).pop();
                  break;
                default:
              }
            }
          },
          child: BlocConsumer<DvrSeriesDetailsCubit, DvrSeriesDetailsState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.seriesName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                'Series Recording',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Save changes?',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 50),
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<DvrSeriesDetailsCubit>()
                                          .saveSettings(context, widget.seriesId);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        color: state.rowIndexSelected == 0 &&
                                                state.columnIndexSelected == 0
                                             && DeviceId.isStb
                                            ? Colors.blue
                                            : const Color(0xFF7E9FDB),
                                        height: 20,
                                        width: 60,
                                        child: const Center(
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        color: state.rowIndexSelected == 1 &&
                                                state.columnIndexSelected == 0
                                            && DeviceId.isStb
                                            ? Colors.blue
                                            : const Color(0xFF7E9FDB),
                                        height: 20,
                                        width: 60,
                                        child: const Center(
                                          child: Text(
                                            'No',
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                SizedBox(
                                  height: 18,
                                ),
                                Text(
                                  'Record',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 53,
                                ),
                                Text(
                                  'Keep Until',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   width: 50,
                        // ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 280,
                                child: ListTile(
                                  tileColor: state.rowIndexSelected == 0 &&
                                          state.columnIndexSelected == 1
                                      ? Colors.blue
                                      : null,
                                  title: const Text('New Episodes Only'),
                                  leading: Radio(
                                    value: 'Y',
                                    groupValue: state.recordSettingsValue,
                                    onChanged: (value) => context
                                        .read<DvrSeriesDetailsCubit>()
                                        .changeRecordSettings(value.toString()),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: 280,
                                child: ListTile(
                                  tileColor: state.rowIndexSelected == 0 &&
                                          state.columnIndexSelected == 2
                                      ? Colors.blue
                                      : null,
                                  title: const Text('Manually Deleted'),
                                  leading: Radio(
                                    value: '1',
                                    groupValue: state.keepUntilSettingsValue,
                                    onChanged: (value) => context
                                        .read<DvrSeriesDetailsCubit>()
                                        .changeKeepUntilSettings(
                                          value.toString(),
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 280,
                                child: ListTile(
                                  tileColor: state.rowIndexSelected == 1 &&
                                          state.columnIndexSelected == 1
                                      ? Colors.blue
                                      : null,
                                  title: const Text('All Episodes'),
                                  leading: Radio(
                                    value: 'N',
                                    groupValue: state.recordSettingsValue,
                                    onChanged: (value) => context
                                        .read<DvrSeriesDetailsCubit>()
                                        .changeRecordSettings(value.toString()),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: 280,
                                child: ListTile(
                                  tileColor: state.rowIndexSelected == 1 &&
                                          state.columnIndexSelected == 2
                                      ? Colors.blue
                                      : null,
                                  title: const Text('Disk Is Full'),
                                  leading: Radio(
                                    value: '2',
                                    groupValue: state.keepUntilSettingsValue,
                                    onChanged: (value) => context
                                        .read<DvrSeriesDetailsCubit>()
                                        .changeKeepUntilSettings(
                                          value.toString(),
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state.isLoading)
                          const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        else
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: GestureDetector(
                              onTap: () => context
                                  .read<DvrSeriesDetailsCubit>()
                                  .cancelSeries(context, widget.seriesId)
                                  .then(
                                    (value) => context
                                        .read<DvrMenuCubit>()
                                        .initializeCubit(context),
                                  ),
                              child: Container(
                                color: (state.columnIndexSelected == 3
                                    && DeviceId.isStb) || !DeviceId.isStb
                                    ? Colors.red
                                    : Colors.grey,
                                height: 30,
                                width: 200,
                                child: const Center(
                                  child: Text(
                                    'Cancel Series',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
