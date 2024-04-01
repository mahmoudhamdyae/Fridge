import 'package:flutter/material.dart';
import 'package:fridge/core/resources/app_colors.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff193263),
          borderRadius: BorderRadius.circular(10.0)
        ),
        padding: const EdgeInsets.all(4.0),
        child: const Icon(
          Icons.settings,
          size: 30,
          color: AppColors.white,
        ),
      ),
    );
  }
}
