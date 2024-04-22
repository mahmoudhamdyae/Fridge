import 'package:flutter/material.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/styles_manager.dart';

class ExpensesBox extends StatelessWidget {

  final dynamic expenses;
  const ExpensesBox({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$expenses ${AppStrings.egp}',
            style: getLargeStyle(
                fontSize: 20,
                color: const Color(0xff193263)
            ),
          ),
          Text(
            AppStrings.reportsTabExpenses,
            style: getSmallStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
