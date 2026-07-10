import 'package:flutter/material.dart';

import '../../constants/color constants/colors_manager.dart';
import '../../constants/responsive size contants/responsive_size_constants.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.blackColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Column(
              children: [
                Image.asset(
                  "images/Onboarding_2.png",
                  width: ResponsiveSizeConstants.widthScreen(context),
                  height:  ResponsiveSizeConstants.heightScreen(context) *  0.6,
                ),
                SizedBox(
                  height: ResponsiveSizeConstants.heightScreen(context) * 0.001,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Discover Your Next Favorite Film.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                SizedBox(
                  height: ResponsiveSizeConstants.heightScreen(context) *  0.027,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Explore a vast library of movies — new releases, classics, and everything in between.",
                    style: Theme.of(context).textTheme.titleSmall,
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
