import 'package:flutter/material.dart';
import 'package:fridge/core/resources/app_colors.dart';

import '../resources/app_strings.dart';
import '../resources/styles_manager.dart';
import '../utils/launch_site.dart';

class CodingSiteWidget extends StatelessWidget {

  final Color textColor;
  const CodingSiteWidget({super.key, this.textColor = AppColors.black});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        launchSite('https://coding-site.com/');
      },
      child: Text(
        AppStrings.madeBy,
        style: getLargeStyle(
          fontSize: 18,
          color: textColor
        ),
      ),
    );
  }
}
