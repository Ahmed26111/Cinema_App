import 'package:flutter/material.dart';

import '../../constants/color constants/colors_manager.dart';
import '../../constants/responsive size contants/responsive_size_constants.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

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
                  height:  ResponsiveSizeConstants.heightScreen(context) * (isLandscape? 0.4 : 0.6),
                ),
                SizedBox(
                  height: ResponsiveSizeConstants.heightScreen(context) * (isLandscape?0.0004 :0.001),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Discover Your Next Favorite Film.",
                    textAlign: TextAlign.center,
                    style: (isLandscape)? Theme.of(context).textTheme.labelLarge :Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                SizedBox(
                  height: ResponsiveSizeConstants.heightScreen(context) * (isLandscape? 0.01 : 0.027),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Explore a vast library of movies — new releases, classics, and everything in between.",
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
