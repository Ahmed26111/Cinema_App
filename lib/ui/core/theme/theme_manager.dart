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
          displayMedium: TextStyle(
            fontFamily: "AG",
            fontSize: 24,
            color: ColorsManager.whiteColor
          ),
          displayLarge: TextStyle(
            fontFamily: "AG",
            fontSize: 12,
            color: ColorsManager.greyColor ,
          ),
          labelMedium: TextStyle(
              fontFamily: "AG",
              fontSize: 16,
              color: ColorsManager.whiteColor
          ),
        ),
      );
    }

    static ButtonStyle getOnboardingFilledButtonStyle(){
        return FilledButton.styleFrom(
            backgroundColor: ColorsManager.primaryBlueAccentColor ,
            foregroundColor: ColorsManager.primaryDarkColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
        );
    }

}