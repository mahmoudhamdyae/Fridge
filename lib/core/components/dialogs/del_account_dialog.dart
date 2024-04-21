import 'package:flutter/material.dart';
import 'package:fridge/core/navigation/navigate_util.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/screens/start_screen.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_strings.dart';
import '../../resources/styles_manager.dart';
import '../../services/services_locator.dart';

showDelAccountDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Text(
          AppStrings.delAccountDialogTitle,
          style: getSmallStyle(),
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
  instance<AuthBloc>().add(SignOutRequested());
  NavigateUtil().navigateAndClear(context, const StartScreen());
}