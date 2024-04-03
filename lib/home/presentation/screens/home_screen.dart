import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/components/decorations.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/expenses/presentation/screens/expenses_screen.dart';
import 'package:fridge/settings/presentation/screens/settings_screen.dart';

import '../../../core/components/appbar.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../../../core/services/services_locator.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../components/home_screen_item.dart';

class HomeScreen extends StatelessWidget {

  final Function(int) onItemClick;
  final BuildContext blocContext;
  const HomeScreen({super.key, required this.onItemClick, required this.blocContext});

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
              // TextFormField(
              //   decoration: getFilledTextFieldDecoration(
              //     hint: AppStrings.homeScreenSearchHint,
              //     radius: 20.0,
              //     prefixIcon: Icons.search,
              //     textStyle: getSmallStyle(
              //         fontSize: 12.0,
              //         fontWeight: FontWeightManager.medium,
              //         color: AppColors.dark2
              //     )
              //   ),
              //   textInputAction: TextInputAction.done,
              //   keyboardType: TextInputType.text,
              // ),
              // 12.ph,
              HomeScreenItem(
                text: AppStrings.homeScreenClients,
                onTab: () { onItemClick(1); },
              ),
              HomeScreenItem(
                text: AppStrings.homeScreenSettings,
                onTab: () {
                  NavigateUtil().navigateToScreen(context, BlocProvider.value(
                      value: instance<SettingsBloc>(),
                      child: SettingsScreen(blocContext: blocContext,)));
                },
              ),
              HomeScreenItem(
                text: AppStrings.homeScreenWards,
                onTab: () { onItemClick(2); },
              ),
              HomeScreenItem(
                text: AppStrings.homeScreenExpenses,
                onTab: () { NavigateUtil().navigateToScreen(context, const ExpensesScreen()); },
              ),
              HomeScreenItem(
                text: AppStrings.homeScreenReports,
                onTab: () { onItemClick(3); },
              ),
              16.ph,
            ],
          ),
        ),
      ),
    );
  }
}
