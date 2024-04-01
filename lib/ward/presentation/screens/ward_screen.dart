import 'package:flutter/material.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/resources/app_assets.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/font_manager.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/ward/presentation/components/settings_button.dart';

import '../../../core/components/decorations.dart';

class WardScreen extends StatelessWidget {

  final List<String> _wards = [
    'عنبر ١',
    'عنبر ٢',
    'عنبر ٣',
    'عنبر ٤',
    'عنبر ٥',
  ];
  WardScreen({super.key});

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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SecondaryAppBarWithImage(
                        text: AppStrings.wardsScreenTitle,
                        image: AppAssets.goods,
                    ),
                    SettingsButton(),
                  ],
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
                  crossAxisCount: 4,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.1,
                  children: List.generate(_wards.length, (index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff2E5AAF),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                            _wards[index],
                          style: getSmallStyle(
                            color: AppColors.white,
                            fontSize: 12,
                            fontWeight: FontWeightManager.medium
                          ),
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        )
    );
  }
}
