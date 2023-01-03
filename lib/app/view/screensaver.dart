import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:iptv/core/api_service/settings_service.dart';

class ScreenSaver extends StatefulWidget {
  const ScreenSaver({super.key});

  @override
  State<ScreenSaver> createState() => _ScreenSaverState();
}

class _ScreenSaverState extends State<ScreenSaver> {
  final _logoKey = GlobalKey();
  Timer? _updateTimer;

  @override
  void initState() {
    super.initState();
    _scheduleUpdate();
    setStatus('Screensaver');
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () {
      setStatus('Active');
    });
    _updateTimer?.cancel();
    super.dispose();
  }

  Future<void> setStatus(String data) {
    return GetIt.I<ChopperClient>()
        .getService<SettingsService>()
        .setStatus(data: data);
  }

  var _x = .0, _y = .0, _dx = 1, _dy = 1;

  void _update() {
    final availableSize = (context.findRenderObject() as RenderBox).constraints,
        logoSize =
            (_logoKey.currentContext?.findRenderObject() as RenderBox).size;

    if (availableSize.maxWidth < _x + logoSize.width) {
      _dx = -1;
    } else if (_x < 0) {
      _dx = 1;
    }
    if (availableSize.maxHeight < _y + logoSize.height) {
      _dy = -1;
    } else if (_y < 0) {
      _dy = 1;
    }

    setState(() {
      _x += _dx * 15;
      _y += _dy * 15;
    });
    _scheduleUpdate();
  }

  void _scheduleUpdate() {
    _updateTimer = Timer(
      // Lock the update rate, no matter the frame rate.
      const Duration(milliseconds: 300),
      _update,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ColoredBox(
        color: Colors.black,
        child: Stack(
          children: [
            AnimatedPositioned(
              top: _y,
              left: _x,
              duration: const Duration(milliseconds: 300),
              child: Image.asset(
                'assets/menu/mdu1-logo.png',
                key: _logoKey,
                height: 128,
                width: 128,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
