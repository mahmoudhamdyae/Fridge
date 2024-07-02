import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/navigation/navigate_extension.dart';
import 'package:fridge/core/resources/app_assets.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_constants.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../../../core/navigation/navigate_util.dart';
import '../bloc/auth_bloc.dart';

class SplashScreen extends StatefulWidget {

  final RateMyApp? rateMyApp;
  const SplashScreen({super.key, this.rateMyApp});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AuthBloc authBloc;
  late StreamSubscription authStream;

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>()..add(AppStarted());

    authStream = authBloc.stream.listen((state) {
      Future.delayed(AppConstants.splashScreenTime).then((_) =>
          NavigateUtil().navigateAndClear(context, state.status.getFirstView(widget.rateMyApp)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Image.asset(
          AppAssets.appLogo,
          height: 260,
          width: 260,
        ),
      ),
    );
  }
}