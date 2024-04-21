import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchSite(String url) async {
  runOnAndroid(url);
}

Future<void> runOnAndroid(String url) async  {
  Uri uri = Uri.parse(url);
  try {
    await launchUrl(uri);
  } catch (e) {
    debugPrint('Error launching URL: $e');
  }
}