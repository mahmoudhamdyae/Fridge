import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/navigation/navigate_extension.dart';
import 'package:fridge/core/resources/app_assets.dart';
import 'package:fridge/core/resources/app_constants.dart';

import '../../../core/navigation/navigate_util.dart';
import '../bloc/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
          NavigateUtil().navigateAndClear(context, state.status.firstView));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssets.appLogo,
          height: context.dynamicHeight(0.2),
          width: context.dynamicWidth(0.9),
        ),
      ),
    );
  }
}