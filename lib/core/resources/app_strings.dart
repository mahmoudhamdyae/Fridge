import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AppStrings {
  static const String appName = 'Fridge';

  // Onboarding Screen
  static const String getStarted = 'Get Started';
  static const String skip = 'Skip';
  static const String onboardingTitle1 = 'onboardingTitle1';
  static const String onboardingDesc1 = 'onboardingDesc1';
  static const String onboardingTitle2 = 'onboardingTitle2';
  static const String onboardingDesc2 = 'onboardingDesc2';
  static const String onboardingTitle3 = 'onboardingTitle3';
  static const String onboardingDesc3 = 'onboardingDesc3';

  // Login Screen
  static const String loginTitle = "You can log in with your information.";
  static const String loginButtonText = "LOGIN";
  static const String emailTitle = "Email";
  static const String passwordTitle = "Password";
  static const String emailHint = 'example@gmail.com';
  static const String passwordHint = '···········';
  static const String unknownError = 'خطأ غير معروف';
  static const String wrongData = 'بيانات الدخول غير صحيحة';
  // Validators
  static const String requiredField = "Required field";
  static const String makeSureCorrectMail = "Please make sure you enter the correct email.";

  // Dialogs
  // Loading
  static const loading = 'جاري التحميل...';
  // Error
  static const errorDialogTitle = 'خطأ!';
  static const retryAgain = 'حاول مرة أخرى';
  static const cancel = 'الغاء';
}