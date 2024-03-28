import 'package:flutter/material.dart';
import 'package:fridge/core/resources/app_colors.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.primaryLight,
  );
}
