import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../home/bloc/channel_bloc.dart' as ch;
import '../../blocs/mobile/epg_search/epg_search_bloc.dart';

class EpgSearchPage extends StatefulWidget {
  const EpgSearchPage({Key? key}) : super(key: key);

  @override
  State<EpgSearchPage> createState() => _EpgSearchPageState();
}

class _EpgSearchPageState extends State<EpgSearchPage> {
  final searchCtrler = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ch.ChannelBloc>().state.maybeMap(
        loaded: (state) {
          context.read<EpgSearchBloc>().add(SelectChannelEvent(
                channeId: state.channelSelected,
              ));
        },
        orElse: () => null);

    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Scaffold(
              appBar: AppBar(
                leadingWidth: 40,
                leading: const BackButton(color: Colors.white),
                backgroundColor: Colors.transparent,
                title: BlocBuilder<ch.ChannelBloc, ch.ChannelState>(
                    builder: (context, state) {
                  return state.maybeMap(
                    loaded: (state) {
                      return Text(
                        state.filteredChannels[state.channelSelected]
                            .channelName,
                      );
                    },
                    orElse: () => Container(),
                  );
                }),
              ),
              body:
                  BlocBuilder<EpgSearchBloc, ChannelState>(builder: (_, state) {
                if (state is ProgramSuccessState) {
                  final now = DateTime.now();

                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.list.length + 1,
                    itemBuilder: (context, index) {
                      if ((state.list.length) == index) {
                        return const SizedBox(height: 50);
                      }

                      final isCurrentlyPlaying = now.isAfter(
                                state.list[index].startEpoch,
                              ) &&
                              now.isBefore(
                                state.list[index].stopEpoch,
                              ) ||
                          now.isAtSameMomentAs(
                            state.list[index].startEpoch,
                          );

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index == 0)
                            const Padding(
                              padding: EdgeInsets.only(bottom: 35, top: 15),
                              child: Text(
                                'Programs',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                // fontSize: 12,
                                color: Color(
                                  0xffBE9421,
                                ),
                              ),
                              children: [
                                TextSpan(
                                  text: DateFormat(
                                    'h:mm a',
                                  ).format(
                                    state.list[index].startEpoch,
                                  ),
                                ),
                                const TextSpan(
                                  text: ' - ',
                                ),
                                TextSpan(
                                  text: DateFormat(
                                    'h:mm a',
                                  ).format(
                                    state.list[index].stopEpoch,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            state.list[index].programTitle,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isCurrentlyPlaying
                                  ? Colors.white
                                  : const Color(
                                      0xffBE9421,
                                    ),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            state.list[index].programDesc,
                            style: const TextStyle(
                              color: Color(
                                0xffBE9421,
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                          )
                        ],
                      );
                    },
                  );
                }
                if (state is ProgramEmptyState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Result is empty'),
                    ],
                  );
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [CircularProgressIndicator.adaptive()],
                );
              })),
        ),
      ),
    );
  }
}
