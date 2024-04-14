import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/font_manager.dart';
import 'package:fridge/core/resources/styles_manager.dart';

class SummaryTab extends StatelessWidget {
  const SummaryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        16.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '25.000 ${AppStrings.egp}',
                  style: getSmallStyle(
                    fontWeight: FontWeightManager.semiBold,
                    color: AppColors.secondary
                  ),
                ),
                Text(
                  AppStrings.reportsTabIncome,
                  style: getSmallStyle(
                    fontSize: 12.0,
                    color: AppColors.dark2
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '70.000 ${AppStrings.egp}',
                  style: getSmallStyle(
                      fontWeight: FontWeightManager.semiBold,
                      color: const Color(0xff193263)
                  ),
                ),
                Text(
                  AppStrings.reportsTabProfit,
                  style: getSmallStyle(
                      fontSize: 12.0,
                      color: AppColors.dark2
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
