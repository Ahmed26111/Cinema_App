import 'package:flutter/material.dart';

abstract class ColorsManager{
  static final Color primaryDarkColor = Color(0xFF1F1D2B);
  static final Color primaryBlueAccentColor = Color(0xFF12CDD9);
  static final Color primaryBlueAccentColorLessOpacity = Color.fromRGBO(18, 205, 217,0.3);
  static final Color primarySoftColor = Color(0xFF252836);
  static final Color primarySoftColorLessOpacity = Color.fromRGBO(37, 40, 54, 0.3);
  static final Color primarySoftColorLessOpacityLinearGradientEnd = Color.fromRGBO(37, 40, 54, 0.01);
  static final Color primarySoftColorLessOpacityLinearGradientStart = Color.fromRGBO(37, 40, 54, 0.5);
  static final Color whiteGreyColor = Color(0xFFEBEBEF);
  static final Color whiteColor = Color(0xFFFFFFFF);
  static final Color lineDarkColor = Color(0xFFEAEAEA);
  static final Color blackColor = Color(0xFF171725);
  static final Color greyColor = Color(0xFF92929D);
  static final Color greyColorLessOpacity = Color.fromRGBO(146, 146, 157, 0.5);
  static final Color redColor = Color(0xFFED3737);
  static final Color orangeColorLessOpacity = Color.fromRGBO(255, 135, 0, 0.8);
  static final Color orangeColor = Color(0xFFFF8700);
  static final Color transparent = Colors.transparent;
}