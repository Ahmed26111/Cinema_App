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
          displayLarge: TextStyle(
            fontFamily: "AG",
            fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.08,
            color: ColorsManager.whiteColor ,
          ),
          displayMedium: TextStyle(
              fontFamily: "AG",
              fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.07,
              color: ColorsManager.whiteColor
          ),
          displaySmall: TextStyle(
            fontFamily: "AG",
            fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.06,
            color: ColorsManager.whiteColor
        ),
          labelLarge: TextStyle(
              fontFamily: "AG",
              fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.05,
              color: ColorsManager.whiteColor
          ),
          labelMedium: TextStyle(
              fontFamily: "AG",
              fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.04,
              color: ColorsManager.whiteColor
          ),
          labelSmall: TextStyle(
            fontFamily: "AG",
            fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.03,
            color: ColorsManager.whiteColor ,
          ),
          titleLarge: TextStyle(
            fontFamily: "AG",
            fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.02,
            color: ColorsManager.whiteColor ,
          ),
          titleMedium: TextStyle(
            fontFamily: "AG",
            fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.01,
            color: ColorsManager.whiteColor ,
          ),
          titleSmall: TextStyle(
            fontFamily: "AG",
            fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.03,
            color: ColorsManager.greyColor ,
          ),
          bodyLarge: TextStyle(
            fontFamily: "AG",
            fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.01,
            color: ColorsManager.greyColor ,
          ),
          bodyMedium: TextStyle(
            fontFamily: "AG",
            fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.03,
            color: ColorsManager.primaryBlueAccentColor ,
          ),
          headlineLarge:  TextStyle(
            fontFamily: "AG",
            fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.035,
            color: ColorsManager.greyColor ,
          ),
          bodySmall:  TextStyle(
            fontFamily: "AG",
            fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.017,
            color: ColorsManager.greyColor ,
          ),
          headlineMedium: TextStyle(
            fontFamily: "AG",
            fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.017,
            color: ColorsManager.primaryBlueAccentColor ,
          ),
          headlineSmall:  TextStyle(
            fontFamily: "AG",
            fontSize: ResponsiveSizeConstants.widthScreen(context) * 0.03,
            color: ColorsManager.redColor ,
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