import 'package:flutter/material.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_assets.dart';
import 'package:fridge/core/resources/app_strings.dart';

import '../components/cancel_button.dart';
import '../components/next_button.dart';

class ChooseWardScreen extends StatelessWidget {
  const ChooseWardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        const SecondaryAppBarWithImage(
            text: AppStrings.addClientScreenChooseWard,
            image: AppAssets.person
        ),
        16.ph,
        const ThirdAppBar(
            text: '${AppStrings.addClientScreeFridge} على محمود',
            image: AppAssets.goods
        ),
        16.ph,
        NextButton(onClick: () {
        }),
        const CancelButton(),
      ],
    );
  }
}
