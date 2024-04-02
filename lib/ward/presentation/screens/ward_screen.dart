import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/ward/presentation/screens/ward_settings_screen.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/decorations.dart';
import '../../../core/navigation/navigate_util.dart';
import '../../../core/resources/app_assets.dart';
import '../components/settings_button.dart';

class WardScreen extends StatelessWidget {

  final String wardName;
  const WardScreen({super.key, required this.wardName});

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
                const MainAppBar(canNavigateUp: true,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SecondaryAppBarWithImage(
                      text: wardName,
                      image: AppAssets.goods,
                    ),
                    SettingsButton(onTab: () {
                      NavigateUtil().navigateToScreen(context, const WardSettingsScreen());
                    },),
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
                  /*children: List.generate(_wards.length, (index) {
                    return InkWell(
                      onTap: () {
                        NavigateUtil().navigateToScreen(context, WardScreen(wardName: _wards[index]));
                      },
                      child: Container(
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
                      ),
                    );
                  })*/
                )
              ],
            ),
          ),
        )
    );
  }
}
