import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as httpDio;
import 'package:flutter_install_apk_silently/flutter_install_apk_silently.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:iptv/core/device_id.dart';
import 'package:iptv/core/models/user_data.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:version/version.dart';

Future<void> fetchOta({
  required bool show,
  required UserData user,
}) async {
  if (!DeviceId.isStb) {
    return;
  }

  try {
    if (show) {
      unawaited(
        SmartDialog.showToast(
          'Checking for any ${user.beta ? 'beta ' : ''}updates...',
        ),
      );
    }

    final packageInfoPlugin = await PackageInfo.fromPlatform();
    final currentVersion = Version.parse(packageInfoPlugin.version);

    if (user.latestVersion != null && user.urlLink != null) {
      final latestVersion = Version.parse(user.latestVersion ?? '');

      if (latestVersion > currentVersion) {
        unawaited(
          SmartDialog.showToast(
            'Updating app to latest version: ${user.latestVersion}.',
            displayTime: const Duration(seconds: 15),
          ),
        );

        return await download(user.urlLink!);
      } else {
        if (show) {
          unawaited(
            SmartDialog.showToast(
              'You have the latest version running!',
              displayTime: const Duration(seconds: 5),
            ),
          );
        }
      }
    }

    final resp = await RetryClient(http.Client())
        .post(
      Uri.parse('https://static.safepayhost.com/ota/apiv2/app/upgrade'),
      headers: {
        'auth': 'auth=token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'api_version': DeviceId.deviceId,
        'app_version': packageInfoPlugin.version,
        'fetch_beta': user.beta ? 'Y' : 'N',
      }),
    )
        .timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        throw Exception('Cannot connect to OTA server - DNS Timed out');
      },
    ).catchError((error, stackTrace) {
      throw Exception('There was a problem fetching your updates.');
    });

    if (resp.statusCode == 404) {
      if (show) {
        unawaited(
          SmartDialog.showToast(
            'You have the latest version running!',
            displayTime: const Duration(seconds: 5),
          ),
        );
      }

      return;
    } else if (resp.statusCode != 200) {
      unawaited(
        SmartDialog.showToast(
          resp.body,
          displayTime: const Duration(seconds: 5),
        ),
      );

      return;
    }

    unawaited(
      SmartDialog.showToast(
        'New version is available! Downloading...',
        displayTime: const Duration(seconds: 30),
      ),
    );

    await download(resp.body);
  } on Exception catch (e) {
    await SmartDialog.dismiss(force: true, status: SmartStatus.allToast);

    await SmartDialog.showToast(
      e.toString().replaceFirst('Exception:', ''),
      displayTime: const Duration(
        seconds: 25,
      ),
    );
  } catch (e) {
    await SmartDialog.dismiss(force: true, status: SmartStatus.allToast);

    await SmartDialog.showToast(
      'OTA - Unexpected Error. ${e.toString().replaceFirst('Exception:', '')}',
      displayTime: const Duration(
        seconds: 25,
      ),
    );
  }
}

Future<void> download(String url) async {
  final tempDir = await getTemporaryDirectory();
  final fullPath =
      '${tempDir.path}/app_${DateTime.now().millisecondsSinceEpoch}.apk';

  final dio = httpDio.Dio();
  await downloadFile(dio, url, fullPath);

  final file = File(fullPath);

  Future.delayed(const Duration(seconds: 1), () async {
    await FlutterInstallApkSilently.installAPK(file: file).then((isInstalled) {
      SmartDialog.showToast('Install status: $isInstalled');
    }).catchError((error) {
      SmartDialog.showToast(error.toString());

      throw Exception('There was a problem installing the new update.');
    });
  });
}

Future<void> downloadFile(
  httpDio.Dio dio,
  String url,
  String savePath,
) async {
  try {
    final response = await dio.get(
      url,
      options: httpDio.Options(
        responseType: httpDio.ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) {
          return (status ?? 500) < 500;
        },
      ),
    );

    final file = File(savePath);
    final raf = file.openSync(mode: FileMode.write)
      ..writeFromSync(response.data as List<int>);
    await raf.close();
  } catch (e) {
    await SmartDialog.showToast(e.toString());
  }
}
