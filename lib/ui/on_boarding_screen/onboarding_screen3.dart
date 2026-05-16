import 'package:flutter/material.dart';

import '../../constants/color constants/colors_manager.dart';
import '../../constants/responsive size contants/responsive_size_constants.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.blackColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    "images/onboarding_3.png",
                    width: ResponsiveSizeConstants.widthScreen(context),
                    height: ResponsiveSizeConstants.heightScreen(context) * 0.5,
                  ),
                  Positioned(
                      left: 20,
                      top: 50,
                      child: getRatingCard(context)
                  ),
                  Positioned(
                      left: 250,
                      top: 70,
                      child: getDurationCard(context)
                  ),
                ],
              ),
              SizedBox(
                height: ResponsiveSizeConstants.heightScreen(context) * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  "Skip the Line, Catch the Film.",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              SizedBox(
                height: ResponsiveSizeConstants.heightScreen(context) * 0.027,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Buy tickets instantly and secure your seat before it's gone.",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRatingCard(BuildContext context){
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
            Text("Rating" , style: Theme.of(context).textTheme.displayLarge,),
            Text("9 / 10" , style: Theme.of(context).textTheme.labelMedium,),
          ],
        ),
      ),
    );
  }

  Widget getDurationCard(BuildContext context){
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
            Text("Duration" , style: Theme.of(context).textTheme.displayLarge,),
            Text("1h 20m" , style: Theme.of(context).textTheme.labelMedium,),
          ],
        ),
      ),
    );
  }


}
