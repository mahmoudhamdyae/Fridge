import 'package:flutter/material.dart';

class NavigateUtil {
  void navigateToScreen(BuildContext context, Widget route) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }

  void navigateAndClear(BuildContext context, Widget route) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => route), (_) => false
    );
  }

  void navigateUp(BuildContext context) {
    Navigator.pop(context);
  }
}