import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/resources/app_assets.dart';
import '../../../core/resources/app_strings.dart';

class LogoAndTitleWidget extends StatelessWidget {
  const LogoAndTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.dynamicHeight(0.06),
      ),
      child: Column(
        children: [
          Image.asset(
            AppAssets.appLogo,
            height: context.dynamicHeight(0.2),
          ),
          30.ph,
          CustomText(
            AppStrings.loginTitle,
            textStyle: context.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}