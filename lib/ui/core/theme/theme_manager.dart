import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ThemeManager{
    static ThemeData getLightThemeData(){
      return ThemeData(
        scaffoldBackgroundColor: ColorsManager.primaryDarkColor,
        appBarTheme: AppBarTheme(
          backgroundColor: ColorsManager.primaryDarkColor,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          foregroundColor: ColorsManager.whiteColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorsManager.primaryDarkColor,
            statusBarIconBrightness: Brightness.light
          ),
        ),
        textTheme: TextTheme(
          // Todo put all text theme of the project
          displaySmall: TextStyle(
            fontFamily: "AG",
            fontSize: 28,
            color: ColorsManager.whiteColor
        ),
        ),
      );
    }


}