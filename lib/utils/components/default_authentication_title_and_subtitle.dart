import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:flutter/material.dart';

List<Widget> defaultAuthenticationTitleAndSubtitle({required String title , required String subTitle, required BuildContext context}){
  List<Widget> widgets = [];
  widgets.addAll([
    Text(
      title,
      style: Theme.of(context).textTheme.displayMedium,
      textAlign: TextAlign.center,
    ),
    SizedBox(
      height: ResponsiveSizeConstants.heightScreen(context) * 0.005,
    ),
    Text(
      subTitle,
      style: Theme.of(context).textTheme.titleSmall,
      textAlign: TextAlign.center,
    ),
  ]);
  return widgets;
}
