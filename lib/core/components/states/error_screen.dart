import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridge/core/extensions/num_extensions.dart';
import 'package:fridge/core/navigation/navigate_util.dart';
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
            // SvgPicture.asset(
            //   ImageAssets.error,
            //   height: AppSize.s190,
            // ),
            const SizedBox(height: 40,),
            Text(
              error.replaceFirst('Exception: ', ''),
              style: getSmallStyle(
                color: const Color(0xffff0000),
              ),
            ),
            // 15.ph,
            // FilledButton(
            //   style: getFilledButtonStyle(),
            //     onPressed: () {
            //       NavigateUtil().navigateUp(context);
            //     },
            //     child: Text(
            //       'الرجوع للخلف',
            //       style: getSmallStyle(
            //         color: AppColors.white
            //       ),
            //     )
            // )
          ],
        )
    );
  }
}
