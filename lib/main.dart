
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/auth/presentation/screens/splash_screen.dart';
import 'package:fridge/core/network/connectivity_controller.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fridge/core/resources/theme_manager.dart';
import 'package:rate_my_app/rate_my_app.dart';

import 'auth/presentation/bloc/auth_bloc.dart';
import 'core/components/rate_app_init_widget.dart';
import 'core/services/services_locator.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServicesLocator().init();
  await ConnectivityController().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: RateAppInitWidget(
          builder: (RateMyApp rateMyApp ) {
            return SplashScreen(rateMyApp: rateMyApp,);
          },
      ),
    );
  }
}
