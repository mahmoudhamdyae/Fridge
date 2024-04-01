import 'package:flutter/material.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/font_manager.dart';
import 'package:fridge/core/resources/styles_manager.dart';

import '../../../core/components/decorations.dart';
import '../components/cancel_button.dart';
import '../components/next_button.dart';
import '../components/trader_dealer_button.dart';

class AddNewClientScreen extends StatelessWidget {
  const AddNewClientScreen({super.key});

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
                const SecondaryAppBar(
                    text: AppStrings.addClientScreenAddClient,
                    icon: Icons.person_add_sharp
                ),
                Text(
                  AppStrings.addClientScreenChooseType,
                  style: getSmallStyle(fontWeight: FontWeightManager.medium),
                ),
                16.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    8.pw,
                    TraderDealerButton(
                      text: AppStrings.addClientScreenTrader,
                      onClicked: () {},
                    ),
                    16.pw,
                    TraderDealerButton(
                      text: AppStrings.addClientScreenDealer,
                      onClicked: () {},
                    ),
                    8.pw,
                  ],
                ),
                32.ph,
                const NextButton(),
                8.ph,
                const CancelButton(),
              ],
            ),
          ),
        )
    );
  }
}