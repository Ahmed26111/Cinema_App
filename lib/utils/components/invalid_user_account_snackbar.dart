import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:flutter/material.dart';

abstract class InvalidUserAccountSnackBar {
  static SnackBar get(BuildContext context){
    return SnackBar(
        content: Text("Invalid Username or Password\nPlease Try again" , style: Theme.of(context).textTheme.labelMedium,),
        margin: EdgeInsets.only(
          bottom: ResponsiveSizeConstants.heightScreen(context) - 170,
          left: 25,
          right: 25,
        ),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        backgroundColor: ColorsManager.primaryBlueAccentColor,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        duration: Duration(seconds: 2),
        elevation: 10,
        
    );
  }
}