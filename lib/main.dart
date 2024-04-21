import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/auth/presentation/screens/splash_screen.dart';
import 'package:fridge/core/navigation/navigate_extension.dart';
import 'package:fridge/core/network/connectivity_controller.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fridge/core/resources/theme_manager.dart';

import 'auth/presentation/bloc/auth_bloc.dart';
import 'core/navigation/navigate_util.dart';
import 'core/resources/app_constants.dart';
import 'core/services/services_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServicesLocator().init();
  await ConnectivityController().init();
  runApp(
      BlocProvider(
          create: (BuildContext context) => instance<AuthBloc>(),
          child: const MyApp()
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

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
    return MaterialApp(
      title: AppStrings.appName,
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar', ''), // Arabic
        Locale('en', ''), // English
      ],
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: const SplashScreen(),
    );
  }
}
