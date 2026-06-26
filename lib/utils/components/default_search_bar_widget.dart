import 'dart:developer';

import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:flutter/material.dart';

class DefaultSearchBarWidget extends StatelessWidget {
  const DefaultSearchBarWidget({super.key, required this.controller, required this.isLandscape, required this.hintText});

  final TextEditingController controller;

  final bool isLandscape;

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextSelectionTheme(
      data: TextSelectionThemeData(
        cursorColor: ColorsManager.primaryBlueAccentColor,
        selectionColor: ColorsManager.primaryBlueAccentColorLessOpacity,
        selectionHandleColor: ColorsManager.primaryBlueAccentColor,
      ),
      child: TextField(
          autofocus: false, // Todo this will changed soon
          controller: controller,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: (isLandscape)? ResponsiveSizeConstants.widthScreen(context) * 0.02 : ResponsiveSizeConstants.widthScreen(context) * 0.04
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: (isLandscape)? ResponsiveSizeConstants.widthScreen(context) * 0.02 : ResponsiveSizeConstants.widthScreen(context) * 0.04
            ),
            filled: true,
            fillColor: ColorsManager.primarySoftColor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsManager.primarySoftColor,
                width: 2
              ),
              borderRadius: BorderRadius.circular(50)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorsManager.primarySoftColor,
                    width: 2
                ),
                borderRadius: BorderRadius.circular(50)
            ),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorsManager.primarySoftColor,
                    width: 2
                ),
                borderRadius: BorderRadius.circular(50)
            ),
            constraints: BoxConstraints(
              maxWidth: (isLandscape)? 700 : 500,
              maxHeight: 50
            ),
            prefixIcon: Icon(Icons.search_outlined , size: 22),
            prefixIconColor: ColorsManager.greyColor,
          ),
          onEditingComplete: (){
            FocusScope.of(context).unfocus();
            // TODO make the search bar go to search screen
          },

      ),
    );
  }
}
