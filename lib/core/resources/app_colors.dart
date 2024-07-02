import 'dart:math';

import 'package:flutter/cupertino.dart';

@immutable
class AppColors {
  static const Color primary = Color(0xff153D8B);
  static const Color h1 = Color(0xff241A4D);
  static const Color h2 = Color(0xff302755);
  static const Color h3 = Color(0xff797199);
  static const Color notSelected = Color(0xffA19CB8);









  static const Color teal = Color(0xff37A492);




  static const Color primaryLight = Color(0xffB7C3DB);
  static const Color primaryDark = Color(0xff37A492);
  static const Color secondary = Color(0xffEE8626);
  static const Color secondaryLight = Color(0xffFECC5E);
  static const Color grey = Color(0xffDEDEDE);
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color dark1 = Color(0xff464646);
  static const Color dark2 = Color(0xff6B6B6B);
  static const Color dark3 = Color(0xff979797);
  static const Color colorRamps1 = Color(0xff101A32);
  static const Color colorRamps2 = Color(0xff1B2C56);
  static const Color colorRamps3 = Color(0xff224383);
  static const Color colorRamps4 = Color(0xff3265C5);
  static const Color colorRamps5 = Color(0xffC1D3F4);

  static Color getRandomColor() => [
    const Color(0xffB7C3DB),
    const Color(0xff000A4F),
    const Color(0xffD8E8F8),
    const Color(0xffEE8626),
    const Color(0xff000A4F),
    const Color(0xffFECC5E),
    const Color(0xffD8E8F8),
  ][Random().nextInt(7)];
}