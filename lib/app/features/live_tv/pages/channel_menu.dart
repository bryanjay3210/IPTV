import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iptv/app/features/live_tv/blocs/channel_menu/channel_menu_cubit.dart';
import 'package:iptv/app/home/bloc/channel_bloc.dart';
import 'package:iptv/core/control_constants.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/models/channel.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../blocs/video_control_cubit.dart';

class ChannelMenu extends StatefulWidget {
  const ChannelMenu({super.key, required this.updatePlayer});

  final Function(int index, {int? genreIndex}) updatePlayer;

  @override
  State<ChannelMenu> createState() => _ChannelMenuState();
}

class _ChannelMenuState extends State<ChannelMenu> {
  FocusNode focusNode = FocusNode();

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  late AutoScrollController controller;

  @override
  void initState() {
    controller = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical,
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        FocusScope.of(context).requestFocus(focusNode);
      },
    );

    super.initState();

    if (!DeviceId.isStb) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
  }

  @override
  void dispose() {
    if (!DeviceId.isStb) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);

    return Scaffold(
      appBar: DeviceId.isStb
          ? null
          : AppBar(
              backgroundColor: Colors.black,
              leading: const BackButton(
                color: Colors.white,
              ),
              title: const Text('Channels'),
            ),
      body: BlocProvider(
        create: (context) => ChannelMenuCubit(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocConsumer<ChannelMenuCubit, ChannelMenuState>(
            listener: (context, state) {
              itemScrollController.scrollTo(
                index: state.currentGenreSelected,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: 0.5,
              );

              controller.scrollToIndex(
                state.currentChannelSelected,
                preferPosition: AutoScrollPosition.middle,
                duration: const Duration(milliseconds: 1),
              );
            },
            builder: (context, state) {
              return RawKeyboardListener(
                focusNode: focusNode,
                onKey: (e) {
                  FocusScope.of(context).requestFocus(focusNode);
                  if (e.runtimeType == RawKeyDownEvent) {
                    switch (e.logicalKey.keyLabel) {
                      case keyUp:
                        context.read<ChannelMenuCubit>().handleKeyUp();
                        break;
                      case keyDown:
                        final channelState = context.read<ChannelBloc>().state;
                        channelState.whenOrNull(
                          loaded: (
                            channels,
                            genres,
                            spacePurchased,
                            spaceUsed,
                            spaceRemaining,
                            channelSelected,
                            genreSelected,
                            filteredChannels,
                          ) {
                            final genre =
                                genres.elementAt(state.currentGenreSelected);
                            if (genre.contains('All Channels')) {
                              filteredChannels = channels;
                            } else if (genre.contains('Favorites')) {
                              filteredChannels = channels
                                  .where((element) => element.isFavorite)
                                  .toList();
                            } else if (genre.contains('DVR')) {
                              filteredChannels = channels
                                  .where((element) => element.dvrEnabled)
                                  .toList();
                            } else {
                              filteredChannels = channels
                                  .where(
                                    (element) => element.genreName == genre,
                                  )
                                  .toList();
                            }

                            context.read<ChannelMenuCubit>().handleKeyDown(
                                  genres.length,
                                  filteredChannels.length,
                                );
                          },
                        );

                        break;
                      case keyLeft:
                        context.read<ChannelMenuCubit>().handleKeyLeft();
                        break;
                      case keyRight:
                        final channelState = context.read<ChannelBloc>().state;
                        channelState.whenOrNull(
                          loaded: (
                            channels,
                            genres,
                            spacePurchased,
                            spaceUsed,
                            spaceRemaining,
                            channelSelected,
                            genreSelected,
                            filteredChannels,
                          ) {
                            final genre =
                                genres.elementAt(state.currentGenreSelected);
                            if (genre.contains('All Channels')) {
                              filteredChannels = channels;
                            } else if (genre.contains('Favorites')) {
                              filteredChannels = channels
                                  .where((element) => element.isFavorite)
                                  .toList();
                            } else if (genre.contains('DVR')) {
                              filteredChannels = channels
                                  .where((element) => element.dvrEnabled)
                                  .toList();
                            } else {
                              filteredChannels = channels
                                  .where(
                                    (element) => element.genreName == genre,
                                  )
                                  .toList();
                            }
                            context
                                .read<ChannelMenuCubit>()
                                .handleKeyRight(filteredChannels.length);
                          },
                        );

                        break;
                      case keyCenter:
                      case keyEnter:
                        final state = context.read<ChannelMenuCubit>().state;
                        final channelState = context.read<ChannelBloc>().state;

                        channelState.whenOrNull(
                          loaded: (
                            channels,
                            genres,
                            spacePurchased,
                            spaceUsed,
                            spaceRemaining,
                            channelSelected,
                            genreSelected,
                            filteredChannels,
                          ) {
                            var filteredChannels = <Channel>[];
                            final genre = genres.elementAt(
                              state.currentGenreSelected,
                            );
                            if (genre.contains('All Channels')) {
                              filteredChannels = channels;
                            } else if (genre.contains('Favorites')) {
                              filteredChannels = channels
                                  .where(
                                    (element) => element.isFavorite,
                                  )
                                  .toList();
                            } else if (genre.contains('DVR')) {
                              filteredChannels = channels
                                  .where(
                                    (element) => element.dvrEnabled,
                                  )
                                  .toList();
                            } else {
                              filteredChannels = channels
                                  .where(
                                    (element) => element.genreName == genre,
                                  )
                                  .toList();
                            }

                            final idx = filteredChannels.indexWhere(
                              (element) =>
                                  element.epgChannelId ==
                                  filteredChannels[state.currentChannelSelected]
                                      .epgChannelId,
                            );

                            context.read<ChannelBloc>().add(
                                  ChannelEvent.changeChannelAndGenre(
                                    idx,
                                    state.currentGenreSelected,
                                  ),
                                );

                            widget.updatePlayer.call(
                              idx,
                              genreIndex: state.currentGenreSelected,
                            );
                          },
                        );

                        Navigator.pop(context);
                        break;
                      default:
                    }
                  }
                },
                child: BlocBuilder<ChannelBloc, ChannelState>(
                  builder: (context, channelState) {
                    return channelState.maybeWhen(
                      loaded: (
                        channels,
                        genres,
                        spacePurchased,
                        spaceUsed,
                        spaceRemaining,
                        channelSelected,
                        genreSelected,
                        filteredChannels,
                      ) {
                        final genre =
                            genres.elementAt(state.currentGenreSelected);
                        if (genre.contains('All Channels')) {
                          filteredChannels = channels;
                        } else if (genre.contains('Favorites')) {
                          filteredChannels = channels
                              .where((element) => element.isFavorite)
                              .toList();
                        } else if (genre.contains('DVR')) {
                          filteredChannels = channels
                              .where((element) => element.dvrEnabled)
                              .toList();
                        } else {
                          filteredChannels = channels
                              .where((element) => element.genreName == genre)
                              .toList();
                        }
                        return Row(
                          children: [
                            AnimatedContainer(
                              width: state.isNavigatingThroughDrawer
                                  ? MediaQuery.of(context).size.width * 0.2875
                                  : 0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.fastOutSlowIn,
                              color: const Color(0xff000417),
                              child: ScrollablePositionedList.builder(
                                initialScrollIndex: state.currentGenreSelected,
                                itemCount: genres.length,
                                itemBuilder: (context, index) {
                                  final isSelected =
                                      index == state.currentGenreSelected;

                                  return GestureDetector(
                                    onTap: () {
                                      context
                                          .read<ChannelMenuCubit>()
                                          .changeGenre(index);
                                    },
                                    child: Material(
                                      color: Colors.transparent,
                                      child: ListTile(
                                        tileColor: isSelected &&
                                                state.isNavigatingThroughDrawer
                                            ? Colors.grey.shade100
                                                .withOpacity(0.25)
                                            : null,
                                        title: Text(
                                          genres.elementAt(index),
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 16,
                                            overflow: TextOverflow.clip,
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.w400,
                                            color: isSelected
                                                ? Colors.amber
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemScrollController: itemScrollController,
                                itemPositionsListener: itemPositionsListener,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ColoredBox(
                                color: Colors.grey.withOpacity(0.5),
                                child: GridView.builder(
                                  controller: controller,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 6,
                                  ),
                                  itemBuilder: (context, index) {
                                    final isSelected =
                                        index == state.currentChannelSelected;
                                    final item = filteredChannels[index];

                                    return GestureDetector(
                                      onTap: () {
                                        final state = context
                                            .read<ChannelMenuCubit>()
                                            .state;

                                        context
                                            .read<ChannelBloc>()
                                            .state
                                            .whenOrNull(
                                          loaded: (
                                            channels,
                                            genres,
                                            spacePurchased,
                                            spaceUsed,
                                            spaceRemaining,
                                            channelSelected,
                                            genreSelected,
                                            filteredChannels,
                                          ) {
                                            var filteredChannels = <Channel>[];
                                            final genre = genres.elementAt(
                                              state.currentGenreSelected,
                                            );
                                            if (genre
                                                .contains('All Channels')) {
                                              filteredChannels = channels;
                                            } else if (genre
                                                .contains('Favorites')) {
                                              filteredChannels = channels
                                                  .where(
                                                    (element) =>
                                                        element.isFavorite,
                                                  )
                                                  .toList();
                                            } else if (genre.contains('DVR')) {
                                              filteredChannels = channels
                                                  .where(
                                                    (element) =>
                                                        element.dvrEnabled,
                                                  )
                                                  .toList();
                                            } else {
                                              filteredChannels = channels
                                                  .where(
                                                    (element) =>
                                                        element.genreName ==
                                                        genre,
                                                  )
                                                  .toList();
                                            }

                                            final idx =
                                                filteredChannels.indexWhere(
                                              (element) =>
                                                  element.epgChannelId ==
                                                  item.epgChannelId,
                                            );

                                            context.read<ChannelBloc>().add(
                                                  ChannelEvent
                                                      .changeChannelAndGenre(
                                                    idx,
                                                    state.currentGenreSelected,
                                                  ),
                                                );

                                            widget.updatePlayer.call(
                                              idx,
                                              genreIndex:
                                                  state.currentGenreSelected,
                                            );
                                            context
                                                .read<VideoControlCubit>()
                                                .updateCaptionIdx(
                                                    isIncrement: false,
                                                    data: 0);
                                          },
                                        );

                                        Navigator.pop(context);
                                      },
                                      child: AutoScrollTag(
                                        key: ValueKey(index),
                                        controller: controller,
                                        index: index,
                                        child: Container(
                                          color:
                                              !state.isNavigatingThroughDrawer
                                                  ? isSelected
                                                      ? Colors.amber
                                                          .withOpacity(0.5)
                                                      : null
                                                  : null,
                                          padding: const EdgeInsets.all(11),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: CachedNetworkImage(
                                                  imageUrl: item.iconUrl,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      item.channelName,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 1,
                                                    ),
                                                    Text(
                                                      item.guideChannelNum,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: filteredChannels.length,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      orElse: () {
                        return Container();
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
