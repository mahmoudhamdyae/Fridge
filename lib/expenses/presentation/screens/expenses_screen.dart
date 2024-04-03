import 'package:flutter/material.dart';
import 'package:fridge/core/components/appbar.dart';
import 'package:fridge/core/extensions/context_extension.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/core/resources/styles_manager.dart';
import 'package:fridge/expenses/presentation/components/back_button.dart';
import 'package:fridge/expenses/presentation/components/register_button.dart';

import '../../../core/components/decorations.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

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
                Text(
                  AppStrings.expensesScreenTitle,
                  style: getLargeStyle(
                    fontSize: 20
                  ),
                ),
                RegisterButton(onTap: () {}),
                BackButton2(),
              ],
            ),
          ),
        )
    );
  }
}
