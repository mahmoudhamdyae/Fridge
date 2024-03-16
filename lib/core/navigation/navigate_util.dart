import 'package:flutter/material.dart';

class NavigateUtil {
  void navigateToScreen(BuildContext context, Widget route) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }

  void navigateAndClear(BuildContext context, Widget route) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => route)
    );
  }

  void navigateUp(BuildContext context) {
    Navigator.pop(context);
  }
}