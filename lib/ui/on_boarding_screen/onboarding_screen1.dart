import 'dart:developer';

import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/ui/core/theme/theme_manager.dart';
import 'package:flutter/material.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = ResponsiveSizeConstants.isLandscape(context);
    log(ResponsiveSizeConstants.widthScreen(context).toString());
    log(ResponsiveSizeConstants.heightScreen(context).toString());
    return Scaffold(
      backgroundColor: ColorsManager.blackColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              children: [
                Image.asset(
                  "images/onboarding_1.png",
                  width: ResponsiveSizeConstants.widthScreen(context),
                  height: ResponsiveSizeConstants.heightScreen(context) * (isLandscape?0.4:0.5),
                ),
                SizedBox(
                  height: ResponsiveSizeConstants.heightScreen(context) * (isLandscape? 0.03 : 0.05),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Every Movie. One Place.",
                    style: (isLandscape)? Theme.of(context).textTheme.labelLarge :Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: ResponsiveSizeConstants.heightScreen(context) * (isLandscape? 0.01 : 0.027),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "From blockbusters to hidden gems, your ultimate movie library is right here.",
                    textAlign: TextAlign.center,
                    style: (isLandscape)?Theme.of(context).textTheme.bodyLarge :Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
