import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/services/services_locator.dart';
import 'package:fridge/ward/domain/entities/ward.dart';
import 'package:fridge/ward/presentation/bloc/wards_bloc.dart';
import 'package:fridge/ward/presentation/screens/ward_settings_screen.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/decorations.dart';
import '../../../core/navigation/navigate_util.dart';
import '../../../core/resources/app_assets.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../components/settings_button.dart';

class WardScreen extends StatelessWidget {

  final Ward ward;
  const WardScreen({super.key, required this.ward});

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
                      text: ward.name ?? '',
                      image: AppAssets.goods,
                    ),
                    SettingsButton(onTab: () {
                      NavigateUtil().navigateToScreen(context,
                          BlocProvider.value(value: instance<WardsBloc>(),
                              child: WardSettingsScreen(ward: ward,)));
                      },
                    ),
                  ],
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
                  crossAxisCount: ward.width ?? 1,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.1,
                  children: List.generate((ward.width ?? 1) * (ward.height ?? 1), (index) {
                    return InkWell(
                      onTap: () {
                      },
                      child: DottedBorder(
                        color: const Color(0xff1F3A6F),
                        strokeWidth: 1,
                        child: Center(
                          child: Text(
                            '',
                            style: getSmallStyle(
                                fontSize: 12,
                                fontWeight: FontWeightManager.medium
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                )
              ],
            ),
          ),
        )
    );
  }
}
