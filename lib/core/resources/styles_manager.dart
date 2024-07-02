import 'package:flutter/material.dart';
import 'package:fridge/core/resources/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize,
    FontWeight fontWeight,
    Color color, TextDecoration decoration
    ) {
  return GoogleFonts.roboto(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      decoration: decoration
  );
}

TextStyle getLargeStyle({
  double fontSize = 32,
  FontWeight fontWeight = FontWeightManager.semiBold,
  Color color = AppColors.black,
  TextDecoration decoration = TextDecoration.none
}) {
  return _getTextStyle(fontSize, fontWeight, color, decoration);
}

TextStyle getSmallStyle({
  double fontSize = 16,
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

ButtonStyle getOutlinedButtonStyle({Color color = AppColors.primary}) {
  return OutlinedButton.styleFrom(
    side: BorderSide(
      width: 1.0,
      color: color,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}

InputDecoration getFilledTextFieldDecoration({
  required String hint,
  double radius = 15.0,
  IconData? prefixIcon,
  TextStyle? textStyle
}) {
  return InputDecoration(
    hintStyle: textStyle ?? getSmallStyle(
      fontSize: 14.0,
      color: AppColors.dark2,
    ),
    filled: true,
    fillColor: AppColors.grey,
    prefixIconConstraints: const BoxConstraints(
      maxWidth: 32.0,
      minWidth: 32.0,
    ),
    prefixIcon: Icon(prefixIcon, color: const Color(0xff545454), size: 17,),
    hintText: hint,
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.grey),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    ),
  );
}

InputDecoration getFilledTextFieldDecorationWithLabel({
  required String label,
  double radius = 15.0,
  IconData? prefixIcon,
  IconData? suffixIcon,
  TextStyle? textStyle
}) {
  return InputDecoration(
    hintStyle: textStyle ?? getSmallStyle(
      fontSize: 14.0,
      color: AppColors.dark2,
    ),
    prefixIconConstraints: const BoxConstraints(
      maxWidth: 32.0,
      minWidth: 32.0,
    ),
    prefixIcon: Icon(prefixIcon, color: const Color(0xff545454), size: 17,),
    suffixIcon: Icon(suffixIcon, color: const Color(0xff545454)),
    label: Text(
      label,
      style: getSmallStyle(
          fontWeight: FontWeightManager.medium
      ),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.grey),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    ),
  );
}