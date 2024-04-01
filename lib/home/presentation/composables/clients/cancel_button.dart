import 'package:flutter/material.dart';
import 'package:fridge/core/resources/font_manager.dart';

import '../../../../core/resources/app_strings.dart';
import '../../../../core/resources/styles_manager.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
      },
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          AppStrings.addClientScreenCancelButton,
          textAlign: TextAlign.center,
          style: getSmallStyle(
            fontWeight: FontWeightManager.medium,
            color: const Color(0xff303030),
          ),
        ),
      ),
    );
  }
}
