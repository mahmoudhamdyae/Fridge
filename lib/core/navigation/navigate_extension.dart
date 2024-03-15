import 'package:flutter/material.dart';
import 'package:fridge/auth/presentation/screens/login_screen.dart';
import 'package:fridge/home/presentation/screens/home_screen.dart';
import 'package:fridge/onboarding/presentation/screens/onboarding_screen.dart';

import '../enums/auth_enums.dart';

extension NavigateExtension on AuthStatus {
  Widget get firstView {
    switch (this) {
      case AuthStatus.authenticated:
        return const HomeScreen();
      case AuthStatus.firstEntry:
        return OnboardingScreen();
      case AuthStatus.unknown:
        return const LoginScreen();
      case AuthStatus.unAuthenticated:
        return const LoginScreen();
    }
  }
}