import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ThemeManager{
    static ThemeData getLightThemeData(BuildContext context){
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
          displaySmall: TextStyle(
            fontFamily: "AG",
            fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.09,
            color: ColorsManager.whiteColor
        ),
          displayMedium: TextStyle(
            fontFamily: "AG",
            fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.07,
            color: ColorsManager.whiteColor
          ),
          displayLarge: TextStyle(
            fontFamily: "AG",
            fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.03,
            color: ColorsManager.greyColor ,
          ),
          labelSmall: TextStyle(
            fontFamily: "AG",
            fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.01,
            color: ColorsManager.greyColor ,
          ),
          labelMedium: TextStyle(
              fontFamily: "AG",
              fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.05,
              color: ColorsManager.whiteColor
          ),
          labelLarge: TextStyle(
              fontFamily: "AG",
              fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.02,
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