import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/utils/components/default_snack_bar.dart';
import 'package:flutter/material.dart';

abstract class OldPasswordNotValidSnackBar{
  static SnackBar get(BuildContext context) => DefaultSnackBar.get(
      context,
      "Old Password not valid :-(\nplease write the correct password of this account",
      EdgeInsets.only(
        bottom: ResponsiveSizeConstants.heightScreen(context) - 250,
        left:  ResponsiveSizeConstants.widthScreen(context) * 0.045,
        right: ResponsiveSizeConstants.widthScreen(context) * 0.045,
      ),
  );
}