import 'package:flutter/material.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/styles_manager.dart';

class AuthButton extends StatelessWidget {

  final Function()? onTap;
  final String text;
  const AuthButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: getFilledButtonStyle(
        color: AppColors.primary
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: getSmallStyle(
          fontSize: 18.0,
          color: AppColors.white
        ),
      )
    );
  }
}