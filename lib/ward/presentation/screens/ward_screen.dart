import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/resources/app_assets.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/ward/presentation/components/settings_button.dart';

import '../../../core/components/decorations.dart';

class WardScreen extends StatelessWidget {
  const WardScreen({super.key});

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
                MainAppBar(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SecondaryAppBarWithImage(
                        text: AppStrings.wardsScreenTitle,
                        image: AppAssets.goods,
                    ),
                    SettingsButton(),
                  ],
                ),
                // GridView(gridDelegate: null,)
              ],
            ),
          ),
        )
    );
  }
}
