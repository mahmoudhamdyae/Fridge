import 'package:flutter/material.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize,
    FontWeight fontWeight,
    Color color, TextDecoration decoration
    ) {
  return GoogleFonts.inter(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      decoration: decoration
  );
}

TextStyle getLargeStyle({
  double fontSize = 16,
  FontWeight fontWeight = FontWeightManager.bold,
  Color color = AppColors.black,
  TextDecoration decoration = TextDecoration.none
}) {
  return _getTextStyle(fontSize, fontWeight, color, decoration);
}

TextStyle getSmallStyle({
  double fontSize = 14,
  FontWeight fontWeight = FontWeightManager.regular,
  Color color = AppColors.black,
  TextDecoration decoration = TextDecoration.none
}) {
  return _getTextStyle(fontSize, fontWeight, color, decoration);
}

TextStyle getRegularStyle({
  double fontSize = 12,
  required Color color
}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color, TextDecoration.none);
}

ButtonStyle getFilledButtonStyle({Color color = AppColors.primary}) {
  return ButtonStyle(
    shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        )
    ),
    backgroundColor: MaterialStateProperty.all(color),
  );
}

ButtonStyle getOutlinedButtonStyle() {
  return OutlinedButton.styleFrom(
    side: const BorderSide(
      width: 1.0,
      color: AppColors.primary,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}

InputDecoration getTextFieldDecoration({
  required String hint,
  required IconData? prefixIcon,
  IconData? suffixIcon,
  required Function onPressed
}) {
  return InputDecoration(
    prefixIconConstraints: BoxConstraints(
      maxWidth: prefixIcon == null ? 16.0 : 32.0,
      minWidth: prefixIcon == null ? 16.0 : 32.0,
    ),
      prefixIcon: Icon(prefixIcon, color: const Color(0xff545454), size: 17,),
      suffixIcon: IconButton(
        icon: Icon(
          suffixIcon,
          color: const Color(0xff545454),
          size: 17,
        ),
        onPressed: () {
          onPressed();
        },
      ),
      hintText: hint,
      border: const OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: AppColors.primaryLight),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
  );
}