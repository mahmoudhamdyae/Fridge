import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/auth/presentation/screens/splash_screen.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fridge/core/resources/theme_manager.dart';
import 'package:fridge/settings/presentation/bloc/settings_bloc.dart';
import 'package:fridge/ward/presentation/bloc/wards_bloc.dart';

import 'auth/presentation/bloc/auth_bloc.dart';
import 'core/services/services_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServicesLocator().init();
  runApp(
      BlocProvider(
          create: (BuildContext context) => instance<AuthBloc>(),
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: MultiBlocProvider(
          providers: [
            // BlocProvider(create: (_) => instance<SettingsBloc>()),
            BlocProvider(create: (_) => instance<WardsBloc>()),
          ],
          child: const SplashScreen()
      ),
    );
  }
}
