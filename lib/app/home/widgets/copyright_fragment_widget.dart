import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iptv/app/home/bloc/mosquitto_bloc.dart';
import 'package:iptv/core/blocs/profile_bloc/profile_bloc.dart';
import 'package:iptv/core/device_id.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class CopyrightFragmentWidget extends StatelessWidget {
  const CopyrightFragmentWidget({super.key, required this.loadMqtt});
  final bool loadMqtt;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                if (loadMqtt)
                  BlocBuilder<MosquittoBloc, MosquittoState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () {
                          final profileState = context.read<ProfileBloc>().state;
                          if (profileState is ProfileUser) {
                            context.read<MosquittoBloc>().add(
                                  MosquittoEvent.started(
                                    profileState.user,
                                  ),
                                );
                          }
                          return const Icon(
                            Icons.circle,
                            color: Colors.grey,
                            size: 12,
                          );
                        },
                        loading: () {
                          return const Icon(
                            Icons.circle,
                            color: Colors.amber,
                            size: 12,
                          );
                        },
                        error: (_) {
                          return const Icon(
                            Icons.circle,
                            color: Colors.red,
                            size: 12,
                          );
                        },
                        loaded: () {
                          return const Icon(
                            Icons.circle,
                            color: Colors.green,
                            size: 12,
                          );
                        },
                      );
                    },
                  ),
                const SizedBox(width: 6),
                Text(
                  context.select(
                    (ProfileBloc b) => b.state is ProfileUser
                        ? (b.state as ProfileUser).user.beta
                            ? 'Beta Access'
                            : ''
                        : '',
                  ),
                  style: const TextStyle(color: Colors.white54),
                ),
                const SizedBox(width: 6),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileUser) {
                      return Text(
                        '${state.user.customerId} | ',
                        style: const TextStyle(color: Colors.white54),
                      );
                    }
                    return Container();
                  },
                ),
                Text(
                  DeviceId.deviceId,
                  style: const TextStyle(color: Colors.white54),
                ),
                const SizedBox(width: 12),
                StatefulBuilder(
                  builder: (context, setState) {
                    if(!DeviceId.isStb){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DigitalClock(
                            is24HourTimeFormat: false,
                            areaAligment: AlignmentDirectional.center,
                            areaHeight: 30,
                            areaWidth: 80,
                            showSecondsDigit: false,
                            hourMinuteDigitDecoration: const BoxDecoration(),
                            secondDigitDecoration: const BoxDecoration(),
                            hourMinuteDigitTextStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.white54,
                            ),
                            secondDigitTextStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white54,
                            ),
                            amPmDigitTextStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.white54,
                            ),
                            areaDecoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                          ),
                          FutureBuilder(
                            future: PackageInfo.fromPlatform(),
                            builder: (
                                BuildContext context,
                                AsyncSnapshot<PackageInfo> snapshot,
                                ) {
                              if (snapshot.connectionState == ConnectionState.done &&
                                  snapshot.data != null) {
                                return Text(
                                  '''v${snapshot.data?.version} B${snapshot.data?.buildNumber ?? ''}''',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    height: 1,
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ],
                      );
                    }
                    return Row(
                      children: [
                        DigitalClock(
                          is24HourTimeFormat: false,
                          areaAligment: AlignmentDirectional.center,
                          areaHeight: 30,
                          areaWidth: 80,
                          showSecondsDigit: false,
                          hourMinuteDigitDecoration: const BoxDecoration(),
                          secondDigitDecoration: const BoxDecoration(),
                          hourMinuteDigitTextStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.white54,
                          ),
                          secondDigitTextStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.white54,
                          ),
                          amPmDigitTextStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
                          ),
                          areaDecoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                        ),
                        FutureBuilder(
                          future: PackageInfo.fromPlatform(),
                          builder: (
                              BuildContext context,
                              AsyncSnapshot<PackageInfo> snapshot,
                              ) {
                            if (snapshot.connectionState == ConnectionState.done &&
                                snapshot.data != null) {
                              return Text(
                                '''v${snapshot.data?.version} B${snapshot.data?.buildNumber ?? ''}''',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  height: 1,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
