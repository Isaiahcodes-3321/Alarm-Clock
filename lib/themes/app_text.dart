import 'package:flutter/material.dart';

class AppTextStyle {
  static String fontFamilyBold = 'LibreBaskerville-Bold';
  static String fontFamilyRegular = 'LibreBaskerville-Regular';

  static double boldFont = 23;
  static double largeBoldFont = 50;
  static double mediumBoldFont = 40;
  static double mediumFont = 18;
  static double smallFont = 13;

  // bold font
  static TextStyle largeBold(Color color, {double? fontSize}) {
    return TextStyle(
        color: color,
        fontSize: fontSize ?? largeBoldFont,
        fontFamily: fontFamilyBold);
  }

  // bold font
  static TextStyle bold(
    Color color,
  ) {
    return TextStyle(
        color: color, fontSize: boldFont, fontFamily: fontFamilyBold);
  }

  static TextStyle boldMedium(
    Color color,
  ) {
    return TextStyle(
        color: color, fontSize: mediumFont, fontFamily: fontFamilyBold);
  }

  static TextStyle boldSmall(
    Color color,
  ) {
    return TextStyle(
        color: color, fontSize: smallFont, fontFamily: fontFamilyBold);
  }

  // medium font
  static TextStyle medium(
    Color color,
  ) {
    return TextStyle(
        color: color, fontSize: mediumFont, fontFamily: fontFamilyRegular);
  }

  static TextStyle mediumSmall(
    Color color,
  ) {
    return TextStyle(
        color: color, fontSize: smallFont, fontFamily: fontFamilyRegular);
  }
}
