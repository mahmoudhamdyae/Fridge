import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/context_extension.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/styles_manager.dart';

class ExpensesBox extends StatelessWidget {

  final String firstLabel;
  final String firstValue;
  final String secondLabel;
  final String secondValue;

  const ExpensesBox({
    super.key,
    required this.firstLabel,
    required this.firstValue,
    required this.secondLabel,
    required this.secondValue,
  });

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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidth(.1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  firstValue,
                  style: getLargeStyle(
                      fontSize: 20,
                      color: const Color(0xff193263)
                  ),
                ),
                Text(
                 firstLabel,
                  style: getSmallStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  secondValue,
                  style: getLargeStyle(
                      fontSize: 20,
                      color: const Color(0xff193263)
                  ),
                ),
                Text(
                  secondLabel,
                  style: getSmallStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
