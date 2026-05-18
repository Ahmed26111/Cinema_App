import 'package:flutter/material.dart';

import '../../constants/color constants/colors_manager.dart';
import '../../constants/responsive size contants/responsive_size_constants.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: ColorsManager.blackColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      "images/onboarding_3.png",
                      width: ResponsiveSizeConstants.widthScreen(context),
                      height: ResponsiveSizeConstants.heightScreen(context) * (isLandscape? 0.4 :0.5),
                    ),
                    Positioned(
                      // Portrait: 6.5% from left | Landscape: 25% from left
                      left: ResponsiveSizeConstants.widthScreen(context) * (isLandscape ? 0.25 : 0.065),
                      // Portrait: 8% from top | Landscape: 5% from top
                      top: ResponsiveSizeConstants.heightScreen(context) * (isLandscape ? 0.05 : 0.08),
                      child: _getRatingCard(context, isLandscape),
                    ),
                    Positioned(
                      // Portrait: 70% from left | Landscape: 60% from left
                      left: ResponsiveSizeConstants.widthScreen(context) * (isLandscape ? 0.6 : 0.7),
                      // Portrait: 10% from top | Landscape: 8% from top
                      top: ResponsiveSizeConstants.heightScreen(context) * (isLandscape ? 0.08 : 0.1),
                      child: _getDurationCard(context, isLandscape),
                    ),
                  ],
                ),
                SizedBox(
                  height: ResponsiveSizeConstants.heightScreen(context) * (isLandscape? 0.03 : 0.05),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    "Skip the Line, Catch the Film.",
                    style: (isLandscape)? Theme.of(context).textTheme.labelLarge :Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                SizedBox(
                  height: ResponsiveSizeConstants.heightScreen(context) * (isLandscape? 0.01 : 0.027),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Buy tickets instantly and secure your seat before it's gone.",
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

  Widget _getRatingCard(BuildContext context , bool isLandScape){
    return Card(
      color: ColorsManager.blackColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: ColorsManager.greyColor,
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 5,
          children: [
            Icon(Icons.star , color: ColorsManager.primaryBlueAccentColor,),
            Text("Rating" , style: (isLandScape)?Theme.of(context).textTheme.bodyLarge:Theme.of(context).textTheme.titleSmall,),
            Text("9 / 10" , style: (isLandScape)?Theme.of(context).textTheme.titleLarge:Theme.of(context).textTheme.labelMedium,),
          ],
        ),
      ),
    );
  }

  Widget _getDurationCard(BuildContext context ,  bool isLandScape){
    return Card(
      color: ColorsManager.blackColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: ColorsManager.greyColor,
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 5,
          children: [
            Icon(Icons.access_time_outlined , color: ColorsManager.primaryBlueAccentColor,),
            Text("Duration" , style: (isLandScape)?Theme.of(context).textTheme.bodyLarge:Theme.of(context).textTheme.titleSmall,),
            Text("1h 20m" , style: (isLandScape)?Theme.of(context).textTheme.titleLarge:Theme.of(context).textTheme.labelMedium,),
          ],
        ),
      ),
    );
  }


}
