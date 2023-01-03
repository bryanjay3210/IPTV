import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iptv/app/features/live_tv/blocs/channel_select/channel_select_cubit.dart';
import 'package:iptv/app/home/bloc/channel_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChannelSelect extends StatefulWidget {
  const ChannelSelect({
    super.key,
    required this.updatePlayer,
  });

  final Function(int) updatePlayer;

  @override
  State<ChannelSelect> createState() => _ChannelSelectState();
}

class _ChannelSelectState extends State<ChannelSelect>
    with SingleTickerProviderStateMixin {
  FocusNode focusNode = FocusNode();

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  Timer? _timer;

  void _handleUserInteraction() {
    if (_timer != null) {
      _timer?.cancel();
    }

    _timer = Timer(const Duration(seconds: 7), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _handleUserInteraction();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);

    return BlocBuilder<ChannelBloc, ChannelState>(
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
            return BlocProvider(
              create: (context) => ChannelSelectCubit(channelSelected),
              child: BlocConsumer<ChannelSelectCubit, ChannelSelectState>(
                listenWhen: (previous, current) {
                  if (current.selectedChannelIndex < 3 ||
                      current.selectedChannelIndex >=
                          filteredChannels.length - 3) {
                    if (current.selectedChannelIndex == 0 &&
                        previous.selectedChannelIndex ==
                            filteredChannels.length - 1) {
                      itemScrollController.jumpTo(
                        index: current.selectedChannelIndex,
                        alignment: 0.45,
                      );
                    } else if (current.selectedChannelIndex ==
                            filteredChannels.length - 1 &&
                        previous.selectedChannelIndex == 0) {
                      itemScrollController.jumpTo(
                        index: current.selectedChannelIndex,
                        alignment: 0.45,
                      );
                    }

                    return true;
                  }

                  itemScrollController.jumpTo(
                    index: current.selectedChannelIndex,
                    alignment: 0.45,
                  );
                  return true;
                },
                listener: (context, state) {},
                builder: (context, state) {
                  FocusScope.of(context).requestFocus(focusNode);

                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _handleUserInteraction,
                    onPanDown: (_) => _handleUserInteraction(),
                    child: RawKeyboardListener(
                      focusNode: focusNode,
                      onKey: (e) {
                        _handleUserInteraction();
                        FocusScope.of(context).requestFocus(focusNode);

                        if (e.runtimeType == RawKeyDownEvent) {
                          if (e.logicalKey.keyLabel == 'Backspace') {
                            Navigator.of(context).pop();
                          } else if (e.logicalKey.keyLabel == 'Arrow Left') {
                            context
                                .read<ChannelSelectCubit>()
                                .handleDecrement(filteredChannels.length);
                          } else if (e.logicalKey.keyLabel == 'Arrow Right') {
                            context
                                .read<ChannelSelectCubit>()
                                .handleIncrement(filteredChannels.length);
                          } else if (e.logicalKey.keyLabel == 'Enter' ||
                              e.logicalKey.keyLabel == 'Select') {
                            widget.updatePlayer(state.selectedChannelIndex);

                            Navigator.of(context).pop();
                          } else if (e.logicalKey.keyLabel == 'Arrow Up') {
                            context.read<ChannelBloc>().add(
                                  const ChannelEvent.traverseChannel(
                                    increment: true,
                                  ),
                                );
                            Navigator.pop(context);
                          } else if (e.logicalKey.keyLabel == 'Arrow Down') {
                            context.read<ChannelBloc>().add(
                                  const ChannelEvent.traverseChannel(
                                    increment: false,
                                  ),
                                );
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        color: Colors.black.withOpacity(0.25),
                        child: ScrollablePositionedList.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: filteredChannels.length,
                          initialAlignment:
                              filteredChannels.length < 8 ? 0 : 0.4,
                          initialScrollIndex: state.selectedChannelIndex,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                final currentIdx = state.selectedChannelIndex;

                                if (currentIdx != index) {
                                  context
                                      .read<ChannelSelectCubit>()
                                      .changeIndex(index);
                                  widget.updatePlayer(index);
                                }

                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 7,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      if (filteredChannels[channelSelected] ==
                                          filteredChannels[index])
                                        Colors.amber.shade200
                                      else
                                        state.selectedChannelIndex == index
                                            ? const Color(0xff3eb469)
                                            : Colors.transparent,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(18),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              filteredChannels[index].iconUrl,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            filteredChannels[index]
                                                .guideChannelNum,
                                            textAlign: TextAlign.center,
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                          Text(
                                            filteredChannels[index].channelName,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemScrollController: itemScrollController,
                          itemPositionsListener: itemPositionsListener,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          orElse: () {
            return Container();
          },
        );
      },
    );
  }
}
