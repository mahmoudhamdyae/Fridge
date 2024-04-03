import 'package:flutter/material.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_assets.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/ward/presentation/components/back_button.dart';
import 'package:fridge/ward/presentation/components/enter_button.dart';
import 'package:fridge/ward/presentation/components/size_column.dart';

import '../../../core/components/decorations.dart';

class WardSettingsScreen extends StatelessWidget {
  const WardSettingsScreen({super.key});

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
                const MainAppBar(canNavigateUp: true),
                const SecondaryAppBarWithImage(
                    text: AppStrings.wardSettingsScreenTitle,
                    image: AppAssets.goods,
                ),
                16.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizeColumn(text: AppStrings.wardSettingsScreenLength, onChanged: (value) {},),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Icon(Icons.close, size: 16,),
                    ),
                    SizeColumn(text: AppStrings.wardSettingsScreenWidth, onChanged: (value) {},),
                  ],
                ),
                32.ph,
                EnterButton(onTap: () {}),
                const BackButton2()
              ],
            ),
          ),
        )
    );
  }
}
