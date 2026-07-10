import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/utils/components/default_snack_bar.dart';
import 'package:flutter/material.dart';

abstract class FailedToBuyTicketsSnackBar{
  static SnackBar get(BuildContext context) => DefaultSnackBar.get(
      context,
      "Failed to buy tickets\nplease try again",
      EdgeInsets.only(
        bottom: ResponsiveSizeConstants.heightScreen(context) - 180,
        left:  ResponsiveSizeConstants.widthScreen(context) * 0.045,
        right: ResponsiveSizeConstants.widthScreen(context) * 0.045,
      ),
  );
}