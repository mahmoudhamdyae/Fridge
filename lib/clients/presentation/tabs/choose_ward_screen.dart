import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_assets.dart';
import 'package:fridge/core/resources/app_colors.dart';
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
        GridView.count(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 28),
          crossAxisCount: 4,
          crossAxisSpacing: 15,
          mainAxisSpacing: 20,
          childAspectRatio: 1.1,
          children: List.generate(['s', 's', 's'].length, (index) {
            return InkWell(
              onTap: () {
              },
              child: DottedBorder(
                color: const Color(0xff1F3A6F),
                strokeWidth: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Container()/*Text(
                      state.wards[index].name ?? '',
                      style: getSmallStyle(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeightManager.medium),
                    )*/,
                  ),
                ),
              ),
            );
          }),
        ),
        16.ph,
        NextButton(onClick: () {
        }),
        const CancelButton(),
      ],
    );
  }
}
