import 'package:flutter/material.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/resources/app_strings.dart';

class LoginButton extends StatelessWidget {

  final Function()? onTap;
  const LoginButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: getFilledButtonStyle(
        color: AppColors.colorRamps2
      ),
      onPressed: onTap,
      child: Text(
        AppStrings.loginScreenLoginButton,
        style: getSmallStyle(
          fontSize: 18.0,
          color: AppColors.white
        ),
      )
    );
  }
}