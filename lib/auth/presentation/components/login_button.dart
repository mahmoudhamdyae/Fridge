import 'package:flutter/material.dart';

import '../../../core/components/button.dart';
import '../../../core/resources/app_strings.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      buttonText: AppStrings.loginButtonText,
      onTap: onTap,
    );
  }
}