import 'package:flutter/material.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/settings/presentation/screens/settings_screen.dart';

class SettingsButton extends StatelessWidget {

  final Function onTab;
  const SettingsButton({super.key, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { onTab(); },
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
