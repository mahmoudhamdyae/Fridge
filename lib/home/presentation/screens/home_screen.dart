import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge/core/components/decorations.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
import 'package:fridge/expenses/presentation/bloc/expenses_bloc.dart';
import 'package:fridge/expenses/presentation/screens/expenses_screen.dart';
import 'package:fridge/settings/presentation/screens/settings_screen.dart';
import 'package:upgrader/upgrader.dart';

import '../../../core/components/appbar.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/services/services_locator.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../components/home_screen_item.dart';

class HomeScreen extends StatelessWidget {

  final Function(int) onItemClick;
  const HomeScreen({super.key, required this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: UpgradeAlert(
          dialogStyle: Platform.isIOS
              ? UpgradeDialogStyle.cupertino
              : UpgradeDialogStyle.material,
          child: Container(
            height: context.height,
            padding: getMainPadding(context),
            decoration: getMainDecoration(),
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                const MainAppBar(isInHomeScreen: true,),
                HomeScreenItem(
                  text: AppStrings.homeScreenClients,
                  onTab: () { onItemClick(1); },
                ),
                HomeScreenItem(
                  text: AppStrings.homeScreenSettings,
                  onTab: () {
                    NavigateUtil().navigateToScreen(
                        context,
                        BlocProvider.value(
                            value: instance<SettingsBloc>(),
                            child: const SettingsScreen()
                        )
                    );
                  },
                ),
                HomeScreenItem(
                  text: AppStrings.homeScreenWards,
                  onTab: () { onItemClick(2); },
                ),
                HomeScreenItem(
                  text: AppStrings.homeScreenExpenses,
                  onTab: () { NavigateUtil().navigateToScreen(context, BlocProvider.value(
                      value: instance<ExpensesBloc>(),
                      child: const ExpensesScreen()
                  )); },
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
      ),
    );
  }
}
