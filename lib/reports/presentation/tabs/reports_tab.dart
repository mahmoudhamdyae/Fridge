import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/font_manager.dart';
import 'package:fridge/reports/presentation/tabs/month_tab.dart';
import 'package:fridge/reports/presentation/tabs/summary_tab.dart';
import 'package:fridge/reports/presentation/tabs/week_tab.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/styles_manager.dart';

class ReportsTab extends StatefulWidget {
  const ReportsTab({super.key});

  @override
  State<ReportsTab> createState() => _ReportsTabState();
}

class _ReportsTabState extends State<ReportsTab> {

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  selectedTab = 0;
                });
              },
              child: Column(
                children: [
                  Text(
                    AppStrings.reportsTabSummary,
                    style: getSmallStyle(
                      color: selectedTab == 0 ? AppColors.secondary: const Color(0xff000000),
                      fontWeight: selectedTab == 0 ? FontWeightManager.semiBold: FontWeightManager.regular,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  selectedTab = 1;
                });
              },
              child: Column(
                children: [
                  Text(
                    AppStrings.reportsTabWeek,
                    style: getSmallStyle(
                      color: selectedTab == 1 ? AppColors.secondary: const Color(0xff000000),
                      fontWeight: selectedTab == 1 ? FontWeightManager.semiBold: FontWeightManager.regular,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  selectedTab = 2;
                });
              },
              child: Column(
                children: [
                  Text(
                    AppStrings.reportsTabMonth,
                    style: getSmallStyle(
                      color: selectedTab == 2 ? AppColors.secondary: const Color(0xff000000),
                      fontWeight: selectedTab == 2 ? FontWeightManager.semiBold: FontWeightManager.regular,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        16.ph,
        selectedTab == 0 ? const SummaryTab()
            :
        selectedTab == 1 ? const WeekTab()
            :
        const MonthTab()
      ],
    );
  }
}
