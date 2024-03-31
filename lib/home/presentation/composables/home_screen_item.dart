import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/context_extension.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/styles_manager.dart';

class HomeScreenItem extends StatelessWidget {

  final String text;
  final Function onTab;
  const HomeScreenItem({super.key, required this.text, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
        child: InkWell(
          onTap: () => onTab(),
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          child: Container(
            decoration: const BoxDecoration(
                color: AppColors.colorRamps1,
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: getSmallStyle(
                  fontSize: 35.0,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
