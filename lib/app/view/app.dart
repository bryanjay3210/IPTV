import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:iptv/app/features/live_tv/blocs/mini_menu/mini_menu_bloc.dart';
import 'package:iptv/app/features/live_tv/blocs/mobile/epg_search/epg_search_bloc.dart';
import 'package:iptv/app/features/live_tv/blocs/video_control_cubit.dart';
import 'package:iptv/app/features/login/bloc/login_bloc.dart';
import 'package:iptv/app/features/login/pages/login_page.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_menu/dvr_menu_cubit.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_movie/dvr_movie_cubit.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_search_result/dvr_search_result_cubit.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_series_details/dvr_series_details_cubit.dart';
import 'package:iptv/app/features/saved_shows/bloc/dvr_series_manager/dvr_series_manager_cubit.dart';
import 'package:iptv/app/home/bloc/channel_bloc.dart';
import 'package:iptv/app/home/bloc/home_cubit.dart';
import 'package:iptv/app/home/bloc/mosquitto_bloc.dart';
import 'package:iptv/app/home/pages/home_page.dart';
import 'package:iptv/app/view/app_brightness_cubit.dart';
import 'package:iptv/app/view/navigation_service.dart';
import 'package:iptv/app/view/screensaver.dart';
import 'package:iptv/core/api_service/settings_service.dart';
import 'package:iptv/core/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:iptv/core/blocs/profile_bloc/profile_bloc.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/keypress_listener.dart';
import 'package:iptv/core/repositories/authentication_repository.dart';
import 'package:iptv/l10n/l10n.dart';
import 'package:restart_app/restart_app.dart';
import 'package:screen_state/screen_state.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.authenticationRepository,
  });
  final AuthenticationRepository authenticationRepository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    handleHomeButton();
    handleSleep();
  }

  void handleHomeButton() {
    if (!DeviceId.isStb) return;

    const MethodChannel('MDU1Channel').setMethodCallHandler((call) async {
      await Restart.restartApp();
    });
  }

  void handleSleep() {
    if (!DeviceId.isStb) return;

    DeviceId.screenListener.screenStateStream?.listen((event) {
      switch (event) {
        case ScreenStateEvent.SCREEN_OFF:
          GetIt.I<ChopperClient>()
              .getService<SettingsService>()
              .setStatus(data: 'Sleep');
          break;
        case ScreenStateEvent.SCREEN_ON:
          GetIt.I<ChopperClient>()
              .getService<SettingsService>()
              .setStatus(data: 'Active');
          break;
        default:
          break;
      }
    });
  }

  final navigatorKey = NavigationService.navigatorKey;
  NavigatorState? get _navigator => navigatorKey.currentState;
  Timer? _timer;

  void _handleUserInteraction() {
    if (_timer != null) {
      _timer?.cancel();
    }

    _timer = Timer(Duration(seconds: DeviceId.idleTimer), () {
      print('screen saver triggered $mounted ');
      if (mounted && DeviceId.isCommunity == false) {
        Hive.openBox('tv_cache').then((box) {
          box.put('isOn', false);

          _navigator?.pushAndRemoveUntil(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomePage(),
            ),
            (route) => false,
          );

          _navigator?.push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const ScreenSaver(),
            ),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      KeypressListener.stream.listen((event) {
        _handleUserInteraction();
      });
    }

    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.cancel): const ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.close): const ActivateIntent()
      },
      child: RepositoryProvider(
        create: (context) => widget.authenticationRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ProfileBloc(
                authenticationRepository: widget.authenticationRepository,
              ),
              lazy: false,
            ),
            BlocProvider(
              create: (_) => AuthenticationBloc(
                authenticationRepository: widget.authenticationRepository,
              ),
              lazy: false,
            ),
            BlocProvider(
              create: (_) => LoginBloc(
                authenticationRepository: widget.authenticationRepository,
              ),
              lazy: false,
            ),
            BlocProvider(
              create: (_) => ChannelBloc(),
              lazy: false,
            ),
            BlocProvider(
              create: (_) => HomeCubit(),
              lazy: false,
            ),
            BlocProvider(
              create: (_) => MosquittoBloc(),
              lazy: false,
            ),
            BlocProvider(
              create: (context) => DvrMenuCubit(),
            ),
            BlocProvider(
              create: (context) => DvrSeriesManagerCubit(),
            ),
            BlocProvider(
              create: (context) => DvrSeriesDetailsCubit(),
            ),
            BlocProvider(
              create: (context) => VideoControlCubit(),
            ),
            BlocProvider(
              create: (context) => MiniMenuBloc(),
            ),
            BlocProvider(
              create: (context) => AppBrightnessCubit(),
            ),
            BlocProvider(
              create: (context) => EpgSearchBloc(),
            ),
            BlocProvider(
              create: (context) => DvrMovieCubit(),
            ),
            BlocProvider(
              create: (context) => DvrSearchResultCubit(),
            ),
          ],
          child: MaterialApp(
            navigatorObservers: [
              FlutterSmartDialog.observer,
              SentryNavigatorObserver(),
            ],
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: const Color(0xFF212332),
              backgroundColor: Colors.black,
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(
                    color: Colors.transparent,
                    width: 1.1,
                  ),
                ),
              ),
              canvasColor: const Color(0xFF2A2D3E),
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(secondary: Colors.transparent),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            builder: FlutterSmartDialog.init(
              builder: (context, child) {
                return BlocBuilder<AppBrightnessCubit, AppBrightnessState>(
                  buildWhen: (previous, current) {
                    if (!previous.isVideoOn && current.isVideoOn) {
                      widget.authenticationRepository.logOut();
                    }

                    return true;
                  },
                  builder: (context, state) {
                    if (!state.isVideoOn) {
                      _navigator?.pushAndRemoveUntil(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => Container(
                            color: Colors.black,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        (route) => false,
                      );
                    }

                    return BlocListener<AuthenticationBloc,
                        AuthenticationState>(
                      listener: (context, state) {
                        switch (state.status) {
                          case AuthenticationStatus.authenticated:
                            context
                                .read<ProfileBloc>()
                                .add(ProfileStore(state.user!));
                            _navigator?.pushAndRemoveUntil(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const HomePage(),
                              ),
                              (route) => false,
                            );
                            break;
                          case AuthenticationStatus.isLogin:
                            _navigator?.pushAndRemoveUntil(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const HomePage(),
                              ),
                              (route) => false,
                            );
                            break;
                          case AuthenticationStatus.unknown:
                          case AuthenticationStatus.unauthenticated:
                            _navigator?.pushAndRemoveUntil(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const LoginPage(),
                              ),
                              (route) => false,
                            );

                            break;
                        }
                      },
                      child: child,
                    );
                  },
                );
              },
            ),
            supportedLocales: AppLocalizations.supportedLocales,
            navigatorKey: navigatorKey,
            onGenerateRoute: (_) => SplashPage.route(),
          ),
        ),
      ),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  // ignore: strict_raw_type
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/menu/mdu1-logo.png',
          width: 400,
          height: 400,
        ),
      ),
      backgroundColor: const Color(0xFF212332),
    );
  }
}
