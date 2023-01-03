import 'package:flutter/material.dart';
import 'package:iptv/app/features/live_tv/pages/live_tv_page_mobile.dart';
import 'package:iptv/app/features/live_tv/pages/live_tv_page_stb.dart';
import 'package:iptv/app/features/live_tv/pages/live_tv_page_stb_vlc.dart';
import 'package:iptv/core/device_id.dart';

class LiveTvPage extends StatelessWidget {
  const LiveTvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DeviceId.isStb
        ? DeviceId.isVLC
            ? const LiveTvPageStbVlc()
            : const LiveTvPageSTB()
        : const LiveTvPageMobile();
  }
}
