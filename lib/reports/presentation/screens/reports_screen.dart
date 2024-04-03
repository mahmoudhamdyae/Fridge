import 'package:flutter/material.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/reports/presentation/tabs/details_tab.dart';
import 'package:fridge/reports/presentation/tabs/reports_tab.dart';

import '../../../core/components/decorations.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            height: context.height,
            padding: getMainPadding(context),
            decoration: getMainDecoration(),
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                const MainAppBar(),
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
                            AppStrings.reportsScreenTabReports,
                            style: getLargeStyle(
                              fontSize: 20,
                              color: selectedTab == 0 ? AppColors.secondary: const Color(0xff193263),
                            ),
                          ),
                          selectedTab == 0 ? Container(
                            height: 3,
                            width: 64,
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ) : Container()
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
                            AppStrings.reportsScreenTabDetails,
                            style: getLargeStyle(
                              fontSize: 20,
                              color: selectedTab == 1 ? AppColors.secondary: const Color(0xff193263),
                            ),
                          ),
                          selectedTab == 1 ? Container(
                            height: 3,
                            width: 64,
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ) : Container()
                        ],
                      ),
                    )
                  ],
                ),
                16.ph,
                selectedTab == 0 ? const ReportsTab() : const DetailsTab()
              ],
            ),
          ),
        )
    );
  }
}
