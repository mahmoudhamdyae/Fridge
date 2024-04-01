import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/font_manager.dart';
import 'package:fridge/core/resources/styles_manager.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.dynamicHeight(.07),
      child: Text(
        AppStrings.wardsScreenTitle,
        textAlign: TextAlign.center,
        style: getLargeStyle(
          fontSize: 30.0,
          fontWeight: FontWeightManager.medium,
        ),
      ),
    );
  }
}

class SecondaryAppBar extends StatelessWidget {

  final String text;
  final IconData icon;
  const SecondaryAppBar({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.dynamicHeight(.07),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xff193263),
          ),
          16.pw,
          Text(
            text,
            textAlign: TextAlign.center,
            style: getLargeStyle(
              fontSize: 25.0,
              color: const Color(0xff193263),
            ),
          ),
        ],
      ),
    );
  }
}
