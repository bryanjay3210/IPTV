import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iptv/app/home/bloc/channel_bloc.dart';

class DvrPercentageWidget extends StatelessWidget {
  const DvrPercentageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelBloc, ChannelState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (
            channels,
            genres,
            spacePurchased,
            spaceUsed,
            spaceRemaining,
            currentChannel,
            currentGenre,
            filteredChannels,
          ) {
            var fullPercent = spaceUsed / spacePurchased;
            if (fullPercent.isInfinite || fullPercent.isNaN) {
              fullPercent = 100;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  height: 12,
                  child: LinearProgressIndicator(
                    value: fullPercent,
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${(fullPercent * 100).round()}% Full',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            );
          },
          orElse: () {
            return const SizedBox();
          },
        );
      },
    );
  }
}
