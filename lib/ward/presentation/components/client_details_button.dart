import 'package:flutter/material.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/font_manager.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/resources/styles_manager.dart';

class SheetClientDetailsButton extends StatelessWidget {

  final Function onTap;
  const SheetClientDetailsButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Color(0xff2D5AAF)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            AppStrings.productDialogDetailsButton,
            textAlign: TextAlign.center,
            style: getSmallStyle(
              fontWeight: FontWeightManager.medium,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
