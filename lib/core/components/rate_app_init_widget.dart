import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RateAppInitWidget extends StatefulWidget {
  final Widget Function(RateMyApp) builder;

  const RateAppInitWidget({
    super.key,
    required this.builder,
  });

  @override
  State<RateAppInitWidget> createState() => _RateAppInitWidgetState();
}

class _RateAppInitWidgetState extends State<RateAppInitWidget> {
  RateMyApp? rateMyApp;

  static const playStoreId = 'com.codingsite.fridge';
  static const appstoreId = 'com.codingsite.fridge';

  @override
  Widget build(BuildContext context) => RateMyAppBuilder(
    rateMyApp: RateMyApp(
      googlePlayIdentifier: playStoreId,
      appStoreIdentifier: appstoreId,
        minDays: 2,
        minLaunches: 7,
        remindDays: 2,
        remindLaunches: 5
    ),
    onInitialized: (context, rateMyApp) {
      setState(() => this.rateMyApp = rateMyApp);

      if (rateMyApp.shouldOpenDialog) {
        rateMyApp.showRateDialog(context);
      }
    },
    builder: (context) => rateMyApp == null
        ? const Center(child: CircularProgressIndicator())
        : widget.builder(rateMyApp!),
  );
}