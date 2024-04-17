import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/resources/font_manager.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/styles_manager.dart';

class TraderDealerButton extends StatelessWidget {

  final String text;
  final bool? isSelected;
  final Function onClicked;
  const TraderDealerButton({super.key, required this.text, required this.onClicked, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClicked();
      },
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: Container(
        width: (context.width / 2) - context.dynamicWidth(.2),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: const Color(0xff2C5494), width: 1),
          color: isSelected == true ? AppColors.primary : AppColors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: getSmallStyle(
              fontWeight: FontWeightManager.medium,
              color: isSelected == true ? AppColors.white : AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
