import 'package:flutter/material.dart';
import 'package:fridge/auth/presentation/screens/start_screen.dart';
import 'package:fridge/home/presentation/screens/main_screen.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../enums/auth_enums.dart';

extension NavigateExtension on AuthStatus {
  Widget getFirstView(RateMyApp? rateMyApp) {
    switch (this) {
      case AuthStatus.authenticated:
        return MainScreen(rateMyApp: rateMyApp);
      case AuthStatus.firstEntry:
        return StartScreen(rateMyApp: rateMyApp);
      case AuthStatus.unknown:
        return StartScreen(rateMyApp: rateMyApp);
      case AuthStatus.unAuthenticated:
        return StartScreen(rateMyApp: rateMyApp);
    }
  }
}