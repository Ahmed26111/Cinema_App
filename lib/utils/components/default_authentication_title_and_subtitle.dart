import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:flutter/material.dart';

List<Widget> defaultAuthenticationTitleAndSubtitle({required String title , required String subTitle, required BuildContext context , bool isLandscape = false}){
  List<Widget> widgets = [];
  widgets.addAll([
    Text(
      title,
      style: (isLandscape)? Theme.of(context).textTheme.displaySmall : Theme.of(context).textTheme.displayMedium,
      textAlign: TextAlign.center,
    ),
    SizedBox(
      height: (isLandscape) ? null : ResponsiveSizeConstants.heightScreen(context) * 0.005,
    ),
    Text(
      subTitle,
      style: (isLandscape)? Theme.of(context).textTheme.bodySmall :Theme.of(context).textTheme.titleSmall,
      textAlign: TextAlign.center,
    ),
  ]);
  return widgets;
}
