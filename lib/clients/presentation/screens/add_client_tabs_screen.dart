import 'package:flutter/material.dart';
import 'package:fridge/clients/presentation/tabs/add_new_client_screen.dart';
import 'package:fridge/clients/presentation/tabs/add_product_screen.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/decorations.dart';

class AddClientTabsScreen extends StatefulWidget {
  const AddClientTabsScreen({super.key});

  @override
  State<AddClientTabsScreen> createState() => _AddClientTabsScreenState();
}

class _AddClientTabsScreenState extends State<AddClientTabsScreen> {

  int currentTab = 0;

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
              const MainAppBar(
                canNavigateUp: true,
              ),
              LinearProgressBar(
                maxSteps: 3,
                progressType: LinearProgressBar.progressTypeLinear, // Use Linear progress
                currentStep: currentTab + 1,
                progressColor: AppColors.primary,
                backgroundColor: AppColors.grey,
              ),
              currentTab == 0 ? const AddNewClientScreen()
                  :
                  currentTab == 1 ? const AddProductScreen()
                      : const AddProductScreen()
            ],
          ),
        ),
      ),
    );
  }
}
