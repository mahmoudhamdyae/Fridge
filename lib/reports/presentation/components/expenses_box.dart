import 'package:flutter/material.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/styles_manager.dart';

class ExpensesBox extends StatelessWidget {

  final double expenses;
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
      child: Stack(
        children: [
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   child: _buildCircle(),
          // ),
          // Positioned(
          //   top: context.dynamicHeight(.012),
          //   left: context.dynamicWidth(.031),
          //   child: _buildCircle(),
          // ),
          // Positioned(
          //   top: context.dynamicHeight(.02),
          //   left: context.dynamicWidth(.07),
          //   child: _buildCircle(),
          // ),
          // Positioned(
          //   top: context.dynamicHeight(.027),
          //   left: context.dynamicWidth(.11),
          //   child: _buildCircle(),
          // ),
          // Positioned(
          //   top: context.dynamicHeight(.0325),
          //   left: context.dynamicWidth(.15),
          //   child: _buildCircle(),
          // ),
          // Positioned(
          //   top: context.dynamicHeight(.035),
          //   left: context.dynamicWidth(.19),
          //   child: _buildCircle(),
          // ),
          // Positioned(
          //   top: context.dynamicHeight(.036),
          //   left: context.dynamicWidth(.23),
          //   child: _buildCircle(),
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ssss ${AppStrings.egp}',
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
        ],
      ),
    );
  }

  Container _buildCircle() {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.secondary
      ),
    );
  }
}
