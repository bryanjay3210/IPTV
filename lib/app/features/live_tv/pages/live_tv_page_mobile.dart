import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:iptv/app/features/live_tv/blocs/epg/epg_cubit.dart';
import 'package:iptv/app/features/live_tv/blocs/epg/new_epg_page.dart';
import 'package:iptv/app/features/live_tv/blocs/mini_menu/mini_menu_bloc.dart';
import 'package:iptv/app/features/live_tv/blocs/video_control_cubit.dart';
import 'package:iptv/app/features/live_tv/pages/channel_menu.dart';
import 'package:iptv/app/features/live_tv/pages/material_transparent_route.dart';
import 'package:iptv/app/features/live_tv/pages/mobile/vlc/bloc/vlc_player_status_cubit.dart';
import 'package:iptv/app/features/live_tv/pages/mobile/vlc/vlc_controller.dart';
import 'package:iptv/app/home/bloc/channel_bloc.dart';
import 'package:iptv/app/home/pages/home_page.dart';
import 'package:iptv/app/stop_alert_dialog.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/models/channel.dart';
import 'package:iptv/core/mqtt_helper.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class LiveTvPageMobile extends StatefulWidget {
  const LiveTvPageMobile({super.key});

  @override
  State<LiveTvPageMobile> createState() => _LiveTvPageMobileState();
}

class _LiveTvPageMobileState extends State<LiveTvPageMobile> {
  final myWidgetState = GlobalKey<StopAlertDialogState>();
  FocusNode focusNode = FocusNode();
  final filterCtrler = TextEditingController();
  late AutoScrollController controller;

  bool currentlyRetrying = false;
  int countOfRetries = 0;
  bool isLoading = true;
  bool isGuideOpen = false;
  bool isMiniMenuOpen = false;
  bool isChannelSelectOpen = false;
  bool isChannelMenuOpen = false;

  // for handling exceptions

  List<int> keyPresses = [];
  int percentage = 0;
  // Timer? _timer;
  String statusCodeError = '';

  String? programId;
  // Timer? _tvExceptionTimer;
  Timer? _statsTimer;

  late VlcPlayerController _videoPlayerController;
  final _key = GlobalKey<VlcPlayerWithControlsState>();

  @override
  Future<void> dispose() async {
    _statsTimer?.cancel();
    _statsTimer = null;
    Future.delayed(Duration.zero, () {
      // _videoPlayerController.stopRendererScanning();
      _videoPlayerController.dispose();
    });
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<ChannelBloc>().state.maybeMap(
      loaded: (a) {
        _videoPlayerController = VlcPlayerController.network(
          a.filteredChannels[a.channelSelected].streamUrl,
          hwAcc: HwAcc.full,
          options: VlcPlayerOptions(
            subtitle: VlcSubtitleOptions([
              // VlcSubtitleOptions.fontSize(5),
            ]),
            advanced: VlcAdvancedOptions([
              VlcAdvancedOptions.clockJitter(0),
              VlcAdvancedOptions.networkCaching(200),
              // VlcAdvancedOptions.liveCaching(0),
              // VlcAdvancedOptions.fileCaching(0)
            ]),
            http: VlcHttpOptions([
              VlcHttpOptions.httpReconnect(true),
              VlcHttpOptions.httpContinuous(true),
              // VlcHttpOptions.httpForwardCookies(true),
              // VlcHttpOptions.
            ]),
            rtp: VlcRtpOptions([
              VlcRtpOptions.rtpOverRtsp(true),
            ]),
            // sout: VlcStreamOutputOptions(
            //   [VlcStreamOutputOptions.soutMuxCaching(0)],
            // ),
          ),
        );

        _videoPlayerController.addOnInitListener(() async {
          // await _videoPlayerController.startRendererScanning();
        });
        _videoPlayerController.addOnRendererEventListener((type, id, name) {
          print(
            'addOnRendererEventListener........................................',
          );
          print('OnRendererEventListener $type $id $name');
        });

        controller = AutoScrollController(
          axis: Axis.vertical,
        );

        controller.scrollToIndex(
          a.channelSelected,
          preferPosition: AutoScrollPosition.middle,
        );

        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      },
      orElse: () {
        // no-op
      },
    );

    context.read<ChannelBloc>().state.maybeMap(
          loaded: (a) {
            final currentChannel = a.filteredChannels[a.channelSelected];
            context.read<MiniMenuBloc>().add(
                  FetchMiniMenuData(
                    currentChannel,
                    currentChannel.epgChannelId,
                    context,
                    isFavoriteState: currentChannel.isFavorite,
                  ),
                );
          },
          orElse: () => null,
        );

    _statsTimer = Timer.periodic(
      const Duration(minutes: 1),
      (timer) {
        if (!mounted) return;

        final now = DateTime.now();

        context.read<ChannelBloc>().state.maybeMap(
          loaded: (state) {
            final currentChannel =
                state.filteredChannels[state.channelSelected];
            final currentProgram = currentChannel.programs?.firstWhereOrNull(
              (currentEpg) =>
                  (now.isAfter(currentEpg.startEpoch) ||
                      now.isAtSameMomentAs(
                        currentEpg.startEpoch,
                      )) &&
                  now.isBefore(currentEpg.stopEpoch),
            );

            if (currentProgram == null) return;

            if (programId == null || programId != currentProgram.epgShowId) {
              programId = currentProgram.epgShowId;
              final builder = MqttClientPayloadBuilder()
                ..addString(
                  buildAction(
                    {
                      'chan': currentChannel.epgChannelId,
                      'prog': currentProgram.epgShowId,
                      'time': (currentProgram.startEpoch
                                  .toUtc()
                                  .millisecondsSinceEpoch /
                              1000)
                          .round()
                          .toString(),
                    },
                    MqttAction.prog,
                  ),
                );

              try {
                final client = GetIt.I.get<MqttServerClient>();

                if (client.connectionStatus?.state ==
                        MqttConnectionState.connected &&
                    builder.payload != null) {
                  client.publishMessage(
                    'statlog',
                    MqttQos.atLeastOnce,
                    builder.payload!,
                  );
                }
              } catch (e) {
                // no-op if fails
              }
            }
          },
          orElse: () {
            // no-op
          },
        );
      },
    );
  }

  void updatePlayer(
    int index, {
    int? genreIndex,
  }) {
    setState(() {
      isLoading = true;
      percentage = 0;
      countOfRetries = 0;
      currentlyRetrying = false;
    });

    context.read<ChannelBloc>().state.maybeMap(
      loaded: (a) {
        if (a.channelSelected != index) {
          context.read<ChannelBloc>().add(ChannelEvent.changeChannel(index));
        }

        if (genreIndex != null) {
          context.read<ChannelBloc>().add(ChannelEvent.changeGenre(genreIndex));
          var filteredChannels = <Channel>[];
          final genre = a.genres.elementAt(genreIndex);
          if (genre.contains('All Channels')) {
            filteredChannels = a.channels;
          } else if (genre.contains('Favorites')) {
            filteredChannels =
                a.channels.where((element) => element.isFavorite).toList();
          } else if (genre.contains('DVR')) {
            filteredChannels =
                a.channels.where((element) => element.dvrEnabled).toList();
          } else {
            filteredChannels = a.channels
                .where((element) => element.genreName == genre)
                .toList();
          }

          _videoPlayerController.setMediaFromNetwork(
            filteredChannels[index].streamUrl,
            autoPlay: true,
            hwAcc: HwAcc.full,
          );
        } else {
          _videoPlayerController.setMediaFromNetwork(
            a.filteredChannels[index].streamUrl,
            autoPlay: true,
            hwAcc: HwAcc.full,
          );
        }
        context
            .read<VideoControlCubit>()
            .updateCaptionIdx(isIncrement: false, data: 0);
      },
      orElse: () {
        // no-op
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChannelBloc, ChannelState>(
      listenWhen: (previous, current) {
        previous.maybeMap(
          loaded: (previous) {
            current.maybeMap(
              loaded: (current) {
                if (previous
                        .filteredChannels[previous.channelSelected].streamUrl !=
                    current
                        .filteredChannels[current.channelSelected].streamUrl) {
                  setState(() {
                    isLoading = true;
                    // percentage = 0;
                    // isStartingVideo = true;
                    countOfRetries = 0;
                    // isAtFinalEnd = false;
                    currentlyRetrying = false;
                  });

                  if (current.channelSelected > 6) {
                    controller.scrollToIndex(
                      current.channelSelected,
                    );
                  }

                  _videoPlayerController.setMediaFromNetwork(
                    current.filteredChannels[current.channelSelected].streamUrl,
                    autoPlay: true,
                    hwAcc: HwAcc.full,
                  );

                  context.read<MiniMenuBloc>().add(
                        FetchMiniMenuData(
                          current.filteredChannels[current.channelSelected],
                          current.filteredChannels[current.channelSelected]
                              .epgChannelId,
                          context,
                          isFavoriteState: current
                              .filteredChannels[current.channelSelected]
                              .isFavorite,
                        ),
                      );
                }
              },
              orElse: () {},
            );
          },
          orElse: () {},
        );

        return true;
      },
      listener: (context, state) {
        // no-op
      },
      builder: (context, state) {
        return BlocProvider(
          create: (context) => VlcPlayerStatusCubit(),
          child: state.maybeMap(
            loaded: (state) {
              final channel = state.filteredChannels[state.channelSelected];
              final vlcPlayerWidget =
                  BlocBuilder<VlcPlayerStatusCubit, VlcPlayerStatusState>(
                builder: (context, state) {
                  return VlcPlayerWithControls(
                    key: _key,
                    controller: _videoPlayerController,
                    onStopRecording: (recordPath) {},
                  );
                },
              );
              return OrientationBuilder(
                builder: (context, orientation) {
                  if (orientation == Orientation.landscape) {
                    return vlcPlayerWidget;
                  }
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.black,
                      leading: BackButton(
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => const HomePage(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                      centerTitle: true,
                      title: Text(
                        state.filteredChannels[state.channelSelected]
                            .channelName,
                      ),
                      actions: [
                        BlocBuilder<MiniMenuBloc, MiniMenuState>(
                          builder: (context, menuState) {
                            if (menuState is! MiniMenuLoaded) {
                              return Container();
                            }

                            return PopupMenuButton<String>(
                              onSelected: (item) {
                                switch (item) {
                                  case 'Guides':
                                    if (DeviceId.isCommunity) return;
                                    try {
                                      _videoPlayerController
                                          .stopRendererScanning();

                                      SmartDialog.showLoading();
                                      context.read<ChannelBloc>().add(
                                        ChannelEvent.clean(() {
                                          SmartDialog.dismiss();
                                          context
                                              .read<ChannelBloc>()
                                              .state
                                              .maybeMap(
                                                loaded: (state) {
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute<void>(
                                                      builder: (context) =>
                                                          BlocProvider(
                                                        create: (context) =>
                                                            EpgCubit(
                                                          channelSelected: state
                                                              .channelSelected,
                                                          channels: state
                                                              .filteredChannels,
                                                          genreSelected: state
                                                              .genreSelected,
                                                        ),
                                                        child:
                                                            const NewEpgPage(),
                                                      ),
                                                    ),
                                                    (route) => false,
                                                  );
                                                },
                                                orElse: () => null,
                                              );
                                        }),
                                      );
                                    } catch (e) {
                                      SmartDialog.dismiss();
                                    }
                                    break;
                                  case 'Info':
                                    final state =
                                        context.read<MiniMenuBloc>().state;
                                    if (DeviceId.isCommunity) return;
                                    if (menuState is! MiniMenuLoaded) return;

                                    SmartDialog.show(
                                      builder: (_) => Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 32,
                                        ),
                                        padding: const EdgeInsets.all(16),
                                        height: max(
                                          450,
                                          MediaQuery.of(context).size.height *
                                              0.55,
                                        ),
                                        width: max(
                                          600,
                                          MediaQuery.of(context).size.width *
                                              0.6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xff00051B),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                        maxHeight: 60,
                                                        maxWidth: 175,
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            channel.iconUrl,
                                                      ),
                                                    ),
                                                    Text(
                                                      channel.guideChannelNum,
                                                    ),
                                                    // Text(
                                                    //   genre['name'].toString(),
                                                    // ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 24,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Visibility(
                                                    visible:
                                                        menuState.data != null,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'Now Playing',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 6,
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .amber,
                                                                  width: 0.5,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  4,
                                                                ),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 8,
                                                                vertical: 2,
                                                              ),
                                                              child: Text(
                                                                '${DateFormat('h:mm a').format(
                                                                  menuState
                                                                      .data!
                                                                      .startEpoch,
                                                                )} - ${DateFormat('h:mm a').format(
                                                                  menuState
                                                                      .data!
                                                                      .stopEpoch,
                                                                )}',
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 10,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '${menuState.data?.programTitle}',
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            if (menuState
                                                                    .data
                                                                    ?.previousRun
                                                                    .isEmpty ??
                                                                false)
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 4,
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(4),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    4,
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  'NEW',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                        Text(
                                                          menuState.data!
                                                              .programDesc,
                                                        ),
                                                        Text(
                                                          '${menuState.data!.stopEpoch.difference(menuState.data!.startEpoch).inMinutes} mins',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.amber,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Visibility(
                                                    visible:
                                                        menuState.nextData !=
                                                            null,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'Up Next',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 6,
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .amber,
                                                                  width: 0.5,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  4,
                                                                ),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 8,
                                                                vertical: 2,
                                                              ),
                                                              child: Text(
                                                                '${DateFormat('h:mm a').format(
                                                                  menuState
                                                                          .nextData
                                                                          ?.startEpoch ??
                                                                      DateTime
                                                                          .now(),
                                                                )} - ${DateFormat('h:mm a').format(
                                                                  menuState
                                                                          .nextData
                                                                          ?.stopEpoch ??
                                                                      DateTime
                                                                          .now(),
                                                                )}',
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 10,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '${menuState.nextData?.programTitle}',
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            if (menuState
                                                                    .nextData
                                                                    ?.previousRun
                                                                    .isEmpty ??
                                                                false)
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 4,
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(4),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    4,
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  'NEW',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                        Text(
                                                          menuState.nextData
                                                                  ?.programDesc ??
                                                              'No Description',
                                                        ),
                                                        Text(
                                                          '${((menuState.nextData?.stopEpoch ?? DateTime.now()).difference(menuState.nextData?.startEpoch ?? DateTime.now()).inMinutes).toStringAsFixed(0)} mins',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.amber,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Align(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.amber,
                                                ),
                                                child: const Text('OK'),
                                                onPressed: () async {
                                                  await SmartDialog.dismiss();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                    break;
                                  case 'Add to Favorites':
                                    context.read<ChannelBloc>().add(
                                          ChannelEvent.addFavoriteChannel(
                                            channel.epgChannelId,
                                            () {
                                              context.read<MiniMenuBloc>().add(
                                                    AddToFavorites(
                                                      channel.epgChannelId,
                                                    ),
                                                  );
                                              SmartDialog.showToast(
                                                'Added ${channel.channelName} to your favorites.',
                                              );
                                            },
                                          ),
                                        );
                                    break;
                                  case 'Remove from Favorites':
                                    context.read<ChannelBloc>().add(
                                          ChannelEvent.removeFavoriteChannel(
                                            channel.epgChannelId,
                                            () {
                                              context.read<MiniMenuBloc>().add(
                                                    RemoveToFavorites(
                                                      channel.epgChannelId,
                                                    ),
                                                  );

                                              SmartDialog.showToast(
                                                'Removed ${channel.channelName} to your favorites.',
                                              );
                                            },
                                          ),
                                        );
                                    break;
                                  case 'Record Program':
                                    final channelIndex = state.channelSelected;

                                    final now = DateTime.now();

                                    final programIndex = state
                                        .filteredChannels[channelIndex]
                                        .programs!
                                        .indexWhere(
                                      (currentEpg) =>
                                          (now.isAfter(
                                                currentEpg.startEpoch,
                                              ) ||
                                              now.isAtSameMomentAs(
                                                currentEpg.startEpoch,
                                              )) &&
                                          now.isBefore(
                                            currentEpg.stopEpoch,
                                          ),
                                    );

                                    if (channelIndex == -1 ||
                                        programIndex == -1) {
                                      return;
                                    }

                                    context.read<ChannelBloc>().add(
                                          ChannelEvent.recordProgram(
                                            channelIndex,
                                            programIndex,
                                            (_) async {
                                              context.read<MiniMenuBloc>().add(
                                                    StartRecording(
                                                      channel.epgChannelId,
                                                    ),
                                                  );
                                            },
                                          ),
                                        );

                                    break;
                                  case 'Stop Recording':
                                    final channelIndex = state.channelSelected;

                                    final now = DateTime.now();

                                    final programIndex = state
                                        .filteredChannels[channelIndex]
                                        .programs!
                                        .indexWhere(
                                      (currentEpg) =>
                                          (now.isAfter(
                                                currentEpg.startEpoch,
                                              ) ||
                                              now.isAtSameMomentAs(
                                                currentEpg.startEpoch,
                                              )) &&
                                          now.isBefore(
                                            currentEpg.stopEpoch,
                                          ),
                                    );

                                    if (channelIndex == -1 ||
                                        programIndex == -1) {
                                      return;
                                    }

                                    SmartDialog.show(
                                      backDismiss: false,
                                      builder: (_) => StopAlertDialog(
                                        key: myWidgetState,
                                        response: (proceed) {
                                          SmartDialog.dismiss();
                                          if (proceed == false) return;

                                          context.read<ChannelBloc>().add(
                                                ChannelEvent
                                                    .stopRecordingProgram(
                                                  channelIndex,
                                                  programIndex,
                                                  (p0) {
                                                    context
                                                        .read<MiniMenuBloc>()
                                                        .add(
                                                          StopRecording(
                                                            channel
                                                                .epgChannelId,
                                                          ),
                                                        );
                                                  },
                                                ),
                                              );
                                        },
                                      ),
                                    );

                                    break;
                                  case 'Channels':
                                    Navigator.of(context)
                                        .push(
                                      MaterialTransparentRoute<void>(
                                        builder: (BuildContext context) =>
                                            ChannelMenu(
                                          updatePlayer: updatePlayer,
                                        ),
                                      ),
                                    )
                                        .then((value) {
                                      if (!DeviceId.isStb) {
                                        SystemChrome.setPreferredOrientations([
                                          DeviceOrientation.portraitUp,
                                          DeviceOrientation.portraitDown,
                                        ]);
                                      }
                                    });
                                    break;
                                  default:
                                }
                              },
                              icon: const Icon(Icons.more_vert),
                              itemBuilder: (BuildContext context) {
                                return {
                                  'Guides',
                                  'Info',
                                  if (!menuState.isFavorite)
                                    'Add to Favorites'
                                  else
                                    'Remove from Favorites',
                                  if (menuState.isRecording)
                                    'Stop Recording'
                                  else if (state
                                      .filteredChannels[state.channelSelected]
                                      .dvrEnabled)
                                    'Record Program',
                                  'Channels',
                                }.map((String choice) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(choice),
                                  );
                                }).toList();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    body: Column(
                      children: [
                        Expanded(
                          child: vlcPlayerWidget,
                        ),
                        Expanded(
                          flex: 2,
                          child: NestedScrollView(
                            headerSliverBuilder: (context, innerBoxIsScrolled) {
                              return [
                                SliverAppBar(
                                  automaticallyImplyLeading: false,
                                  centerTitle: true,
                                  snap: true,
                                  toolbarHeight: 65,
                                  floating: true,
                                  backgroundColor: Colors.transparent,
                                  flexibleSpace: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 15,
                                      right: 15,
                                      bottom: 10,
                                    ),
                                    child: FlexibleSpaceBar(
                                      centerTitle: true,
                                      titlePadding:
                                          const EdgeInsets.only(top: 5),
                                      title: TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: filterCtrler,
                                        onChanged: (text) {
                                          setState(() {});
                                        },
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: Colors.white,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(90),
                                            ),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          hintText: 'Channel Name/number...',
                                          fillColor: Colors.white24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ];
                            },
                            body: Builder(
                              builder: (context) {
                                final channels = state.filteredChannels
                                    .where(
                                      (element) =>
                                          element.channelName
                                              .trim()
                                              .toLowerCase()
                                              .contains(filterCtrler.text) ||
                                          element.guideChannelNum
                                              .trim()
                                              .contains(filterCtrler.text),
                                    )
                                    .toList();

                                return ListView.builder(
                                  controller: controller,
                                  itemCount: channels.length,
                                  itemBuilder: (context, index) {
                                    return AutoScrollTag(
                                      key: ValueKey(index),
                                      index: index,
                                      controller: controller,
                                      child: ListTile(
                                        onTap: () {
                                          if (filterCtrler.text.isEmpty) {
                                            return updatePlayer(index);
                                          }

                                          final newIndex =
                                              state.filteredChannels.indexWhere(
                                            (element) =>
                                                element == channels[index],
                                          );
                                          updatePlayer(newIndex);
                                        },
                                        tileColor: state
                                                    .filteredChannels[
                                                        state.channelSelected]
                                                    .epgChannelId ==
                                                channels[index].epgChannelId
                                            ? Colors.green
                                            : Colors.black,
                                        leading: CachedNetworkImage(
                                          height: 100,
                                          width: 100,
                                          imageUrl: channels[index].iconUrl,
                                        ),
                                        title: Text(
                                          channels[index].channelName,
                                        ),
                                        subtitle: Text(
                                          channels[index].guideChannelNum,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: ListView.builder(
                        //     primary: true,
                        //     shrinkWrap: true,
                        //     itemBuilder: (context, index) {
                        //       return ListTile(
                        //         leading: Image.network(
                        //           state.filteredChannels[index].iconUrl,
                        //         ),
                        //         title: Text(
                        //           state.filteredChannels[index].channelName,
                        //         ),
                        //       );
                        //     },
                        //     itemCount: state.filteredChannels.length,
                        //   ),
                        // )
                      ],
                    ),
                  );
                },
              );
            },
            orElse: SizedBox.new,
          ),
        );
      },
    );
  }
}
