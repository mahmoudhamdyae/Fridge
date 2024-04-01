import 'package:flutter/cupertino.dart';
import 'package:fridge/core/extensions/context_extension.dart';

import '../resources/app_colors.dart';

BoxDecoration getMainDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.white,
        AppColors.primaryLight,
      ],
    )
);

EdgeInsets getMainPadding(BuildContext context) =>
    EdgeInsets.symmetric(horizontal: context.dynamicWidth(0.04));