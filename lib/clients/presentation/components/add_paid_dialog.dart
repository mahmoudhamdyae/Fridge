import 'package:flutter/material.dart';
import 'package:fridge/clients/presentation/components/paid_form_field.dart';
import 'package:fridge/core/navigation/navigate_util.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/styles_manager.dart';

showAddPaidDialog({
  required BuildContext context,
  required Function(String) action,
}) {
  TextEditingController paidController = TextEditingController();
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Text(
          AppStrings.addPaidDialogTitle,
          style: getSmallStyle(),
        ),
        content: PaidFormField(paidController: paidController,),
        actions: [
          TextButton(
            onPressed: () => NavigateUtil().navigateUp(context),
            child: Text(
                AppStrings.cancel,
                style: getSmallStyle()),
          ),
          FilledButton(
            style: getFilledButtonStyle(),
            onPressed: () => action(paidController.text),
            child: Text(
              AppStrings.addPaidDialogOk,
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