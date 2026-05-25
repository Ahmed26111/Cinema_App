import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/utils/components/default_snack_bar.dart';
import 'package:flutter/material.dart';

abstract class FailedToUpdatePasswordSnackBar{
  static SnackBar get(BuildContext context) => DefaultSnackBar.get(
      context,
      "Failed to Update password\nPlease try again",
      EdgeInsets.only(
        bottom: ResponsiveSizeConstants.heightScreen(context) - 180,
        left: 25,
        right: 25,
      )
  );
}