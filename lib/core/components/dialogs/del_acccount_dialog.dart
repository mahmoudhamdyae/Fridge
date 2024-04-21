import 'package:flutter/material.dart';
import 'package:fridge/core/navigation/navigate_util.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_strings.dart';
import '../../resources/styles_manager.dart';

showDelAccountDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Text(
          AppStrings.delAccountDialogTitle,
          style: getLargeStyle(),
        ),
        content: Text(
          AppStrings.delAccountDialogText,
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
            onPressed: () => _delAccount(context),
            child: Text(
              AppStrings.delAccountOk,
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

_delAccount(BuildContext context) async {
  // Get.back();
  // showLoading(context);
  // final MeController controller = Get.find<MeController>();
  // controller.delAccount().then((value) {
  //   if (controller.status.isError) {
  //     Get.back();
  //     showError(context, controller.status.errorMessage.toString(), () {});
  //   } else {
  //     Get.showSnackbar(
  //       const GetSnackBar(
  //         title: null,
  //         message: AppStrings.delAccountSuccess,
  //         duration: Duration(seconds: AppConstants.snackBarTime),
  //       ),
  //     );
  //     Get.offAll(() => const LoginScreen());
  //   }
  // });
}