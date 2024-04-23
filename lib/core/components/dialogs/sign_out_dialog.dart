import 'package:flutter/material.dart';
import 'package:fridge/auth/presentation/screens/start_screen.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:fridge/core/services/services_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../navigation/navigate_util.dart';
import '../../network/api_constants.dart';
import '../../resources/app_strings.dart';
import '../../resources/styles_manager.dart';

showSignOutDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Text(
          AppStrings.logoutDialogTitle,
          style: getSmallStyle(),
        ),
        content: Text(
          AppStrings.logoutDialogText,
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
            onPressed: () { _signOut(context); },
            child: Text(
              AppStrings.logoutOk,
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

_signOut(BuildContext context) async {
  var sharedPref = instance<SharedPreferences>();
  await sharedPref.setString('TOKEN', '');
  await sharedPref.setBool('AUTH_STATE', false);
  ApiConstants.token = '';
  NavigateUtil().navigateAndClear(context, const StartScreen());
}