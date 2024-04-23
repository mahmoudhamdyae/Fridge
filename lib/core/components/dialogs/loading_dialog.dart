import 'package:flutter/material.dart';

import '../../resources/app_strings.dart';

showLoading(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          // The shape of the dialog
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          // The content of the dialog
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // The loading indicator
                CircularProgressIndicator(),
                SizedBox(
                  height: 16,
                ),
                // Some text
                Text(AppStrings.loading)
              ],
            ),
          ),
        );
      }
  );
}