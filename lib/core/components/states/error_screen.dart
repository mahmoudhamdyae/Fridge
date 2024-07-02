import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/resources/app_assets.dart';
import 'package:fridge/core/resources/app_colors.dart';

import '../../resources/styles_manager.dart';

class ErrorScreen extends StatelessWidget {

  final String error;
  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            75.ph,
            error == 'يرجي التفعيل من الشركة' ?
                Image.asset(AppAssets.contact)
                : Container(),
            error == 'يرجي التفعيل من الشركة' ? 40.ph : Container(),
            Text(
              error == 'يرجي التفعيل من الشركة' ? 'يرجى الانتظار سيتم التواصل معك لتفعيل الحساب' : error.replaceFirst('Exception: ', ''),
              style: getSmallStyle(
                color: error == 'يرجي التفعيل من الشركة' ? AppColors.h1 : const Color(0xffff0000),
              ),
            ),
          ],
        )
    );
  }
}
