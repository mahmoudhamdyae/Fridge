import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../resources/app_strings.dart';
import '../resources/styles_manager.dart';
import 'launch_site.dart';

versionCheck(context, Function openRateDialog) async {
  // Get Current installed version of app
  final PackageInfo info = await PackageInfo.fromPlatform();
  double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));

  // Get Latest version info from firebase config
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(),
    minimumFetchInterval: const Duration(),
  ));

  try {
    // Using default duration to force fetching from remote server.
    await remoteConfig.fetch();
    await remoteConfig.activate();
    String forceUpdateCurrentVersion = remoteConfig.getString(
        Platform.isAndroid ? 'force_update_current_version_android'
            :
        'force_update_current_version_ios'
    );
    double newVersion = double.parse(forceUpdateCurrentVersion
        .trim()
        .replaceAll(".", ""));
    debugPrint('Remote Version $newVersion');
    debugPrint('Current Version $currentVersion');
    if (newVersion > currentVersion) {
      _showVersionDialog(context);
    } else {
      openRateDialog();
    }
  } on Exception catch (exception) {
    // Fetch throttled.
    debugPrint(exception.toString());
  } catch (exception) {
    debugPrint('Unable to fetch remote config. Cached or default values will be used');
  }
}

_showVersionDialog(context) async {
  await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      String title = AppStrings.updateDialogTitle;
      String message = AppStrings.updateDialogMessage;
      String btnLabel = AppStrings.updateDialogButtonLabel;
      String btnLabelCancel = AppStrings.updateDialogButtonLabelCancel;
      return AlertDialog(
        title: Text(
          title,
          style: getLargeStyle(
            fontSize: 24,
              color: AppColors.primary
          ),
        ),
        content: Text(
          message,
          style: getSmallStyle(),
        ),
        actions: [
          MaterialButton(
            child: Text(
              btnLabel,
              style: getSmallStyle(
                color: AppColors.primary
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              Platform.isAndroid ?
            launchSite(AppConstants.playStoreUrl)
                :
            launchSite(AppConstants.appStoreUrl);
              },
          ),
          MaterialButton(
            child: Text(
              btnLabelCancel,
              style: getSmallStyle(),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}