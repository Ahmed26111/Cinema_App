import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:flutter/material.dart';

abstract class DefaultSnackBar {
  static SnackBar get(
    BuildContext context,
    String title,
    EdgeInsetsGeometry? margin,
  ) {
    return SnackBar(
      content: Text(title, style: Theme.of(context).textTheme.labelMedium),
      margin: margin,
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      backgroundColor: ColorsManager.primaryBlueAccentColor,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      duration: Duration(seconds: 2),
      elevation: 10,
    );
  }
}
