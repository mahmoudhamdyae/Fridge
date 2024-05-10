import 'package:flutter/material.dart';
import 'package:fridge/core/navigation/navigate_util.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_strings.dart';
import '../../resources/styles_manager.dart';

showDelDialog({
  required BuildContext context,
  required Function action,
  String text = AppStrings.delDialogText,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Text(
          AppStrings.delDialogTitle,
          style: getSmallStyle(),
        ),
        content: Text(
          text,
          style: getSmallStyle(),
        ),
        actions: [
          TextButton(
            onPressed: () => NavigateUtil().navigateUp(context),
            child: Text(
                AppStrings.cancel,
                style: getSmallStyle()),
          ),
          FilledButton(
            style: getFilledButtonStyle(),
            onPressed: () => action(),
            child: Text(
              AppStrings.delDialogOk,
              style: getSmallStyle(
                  color: AppColors.white
              ),
            ),
          )
        ],
      );
    },
  );
}