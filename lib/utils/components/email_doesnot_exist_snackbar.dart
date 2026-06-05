import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/utils/components/default_snack_bar.dart';
import 'package:flutter/material.dart';

abstract class EmailDoesNotExistSnackBar {
  static SnackBar get(BuildContext context , bool isLandscape) {
    return DefaultSnackBar.get(
        context,
        "Email doesn't exist \nPlease Try again",
        EdgeInsets.only(
          bottom: (isLandscape && ResponsiveSizeConstants.heightScreen(context) > 500 )?ResponsiveSizeConstants.heightScreen(context) - 255 :ResponsiveSizeConstants.heightScreen(context) - 180,
          left: (isLandscape)? ResponsiveSizeConstants.widthScreen(context) * 0.07 : ResponsiveSizeConstants.widthScreen(context) * 0.045,
          right: (isLandscape)? ResponsiveSizeConstants.widthScreen(context) * 0.07 :ResponsiveSizeConstants.widthScreen(context) * 0.045,
        ),
        isLandscape
    );
  }
}
