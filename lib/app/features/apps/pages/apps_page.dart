import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iptv/app/features/apps/blocs/apps_cubit.dart';
import 'package:iptv/app/home/pages/home_page.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class AppsPage extends StatefulWidget {
  const AppsPage({super.key});

  @override
  State<AppsPage> createState() => _AppsPageState();
}

class _AppsPageState extends State<AppsPage> {
  late AutoScrollController controller;

  final node = FocusNode();

  @override
  void initState() {
    super.initState();

    controller = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical,
    );

    node.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    node.requestFocus();

    return WillPopScope(
      onWillPop: () async {
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const HomePage(),
          ),
          (route) => false,
        );

        return false;
      },
      child: BlocProvider(
        create: (context) => AppsCubit(),
        child: BlocConsumer<AppsCubit, AppsState>(
          listener: (context, state) {
            controller.scrollToIndex(
              state.selectedIndex ?? 0,
              preferPosition: AutoScrollPosition.middle,
              duration: const Duration(milliseconds: 1),
            );
          },
          builder: (context, state) {
            return RawKeyboardListener(
              focusNode: node,
              onKey: (e) {
                if (e is RawKeyDownEvent) {
                  switch (e.logicalKey.keyLabel) {
                    // case 'Context Menu':
                    //   Navigator.pop(context);
                    //   break;
                    case 'Arrow Up':
                      context.read<AppsCubit>().handleKeyUp();
                      break;
                    case 'Arrow Down':
                      context.read<AppsCubit>().handleKeyDown();
                      break;
                    case 'Arrow Left':
                      context.read<AppsCubit>().handleKeyLeft();
                      break;
                    case 'Arrow Right':
                      context.read<AppsCubit>().handleKeyRight();
                      break;
                    case 'Select':
                      final state = context.read<AppsCubit>().state;
                      if (state.applications == null ||
                          state.selectedIndex == null) {
                        return;
                      }

                      if (state.applications![state.selectedIndex!]
                              .packageName ==
                          'tv.mdu1.iptv') {
                        Navigator.pop(context);
                        return;
                      }

                      DeviceApps.openApp(
                        state.applications![state.selectedIndex!].packageName,
                      );
                      break;
                    default:
                  }
                }
              },
              child: Scaffold(
                body: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/background.jpg'),
                            fit: BoxFit.cover,
                            isAntiAlias: true,
                            colorFilter: ColorFilter.mode(
                              Color(0xFF222222),
                              BlendMode.hardLight,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (state.applications != null)
                      GridView.builder(
                        padding: const EdgeInsets.all(48),
                        controller: controller,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                        ),
                        itemCount: state.applications!.length,
                        itemBuilder: (context, index) {
                          final app = state.applications![index];
                          return GestureDetector(
                            onTap: () {
                              if (app.packageName == 'tv.mdu1.iptv') {
                                Navigator.pop(context);
                                return;
                              }
                              DeviceApps.openApp(app.packageName);
                            },
                            child: AutoScrollTag(
                              key: ValueKey(index),
                              controller: controller,
                              index: index,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: index == state.selectedIndex
                                      ? Colors.black.withOpacity(0.85)
                                      : null,
                                  borderRadius: BorderRadius.circular(16),
                                  border: index == state.selectedIndex
                                      ? Border.all(color: Colors.white)
                                      : null,
                                ),
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (app is ApplicationWithIcon)
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: Image.memory(
                                            app.icon,
                                            gaplessPlayback: true,
                                          ),
                                        ),
                                      )
                                    else
                                      const SizedBox.shrink(),
                                    Text(
                                      app.appName,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    else
                      const Center(
                        child: CircularProgressIndicator(),
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
