import 'package:flutter/material.dart';
import 'package:fridge/auth/presentation/screens/login_screen.dart';
import 'package:fridge/auth/presentation/screens/start_screen.dart';
import 'package:fridge/home/presentation/screens/home_screen.dart';
import 'package:fridge/home/presentation/screens/main_screen.dart';
import 'package:fridge/onboarding/presentation/screens/onboarding_screen.dart';

import '../enums/auth_enums.dart';

extension NavigateExtension on AuthStatus {
  Widget get firstView {
    switch (this) {
      case AuthStatus.authenticated:
        return const MainScreen();
      case AuthStatus.firstEntry:
        // return OnboardingScreen();
        return const StartScreen();
      case AuthStatus.unknown:
        return const StartScreen();
      case AuthStatus.unAuthenticated:
        return const StartScreen();
    }
  }
}