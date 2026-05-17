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
                        left: (isLandscape)? 220 : 20,
                        top: (isLandscape)? 25 : 60,
                        child: _getRatingCard(context , isLandscape)
                    ),
                    Positioned(
                        left: (isLandscape)? 450 :250,
                        top: (isLandscape)? 35 :70,
                        child: _getDurationCard(context , isLandscape)
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
                    style: (isLandscape)? Theme.of(context).textTheme.labelMedium :Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                SizedBox(
                  height: ResponsiveSizeConstants.heightScreen(context) * (isLandscape? 0.01 : 0.027),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Buy tickets instantly and secure your seat before it's gone.",
                    style: (isLandscape)?Theme.of(context).textTheme.labelSmall :Theme.of(context).textTheme.displayLarge,
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
            Text("Rating" , style: (isLandScape)?Theme.of(context).textTheme.labelSmall:Theme.of(context).textTheme.displayLarge,),
            Text("9 / 10" , style: (isLandScape)?Theme.of(context).textTheme.labelLarge:Theme.of(context).textTheme.labelMedium,),
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
            Text("Duration" , style: (isLandScape)?Theme.of(context).textTheme.labelSmall:Theme.of(context).textTheme.displayLarge,),
            Text("1h 20m" , style: (isLandScape)?Theme.of(context).textTheme.labelLarge:Theme.of(context).textTheme.labelMedium,),
          ],
        ),
      ),
    );
  }


}
