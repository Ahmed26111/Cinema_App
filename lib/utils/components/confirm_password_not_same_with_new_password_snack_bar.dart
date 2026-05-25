import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/utils/components/default_snack_bar.dart';
import 'package:flutter/material.dart';

abstract class ConfirmPasswordNotSameWithNewPasswordSnackBar {
  static SnackBar get (BuildContext context) {
    return DefaultSnackBar.get(
        context,
        "Passwords are not equal\nPlease,try again",
        EdgeInsets.only(
          bottom: ResponsiveSizeConstants.heightScreen(context) - 180,
          left: 25,
          right: 25,
        ),
    );
  }


}