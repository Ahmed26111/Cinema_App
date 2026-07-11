import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:flutter/material.dart';

import '../../utils/components/default_pop_back_icon_button.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Us",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        leading: DefaultPopBackIconButton(),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo placeholder
                    Card(
                      color: ColorsManager.primarySoftColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Icon(
                          Icons.movie_filter_rounded,
                          size: 60,
                          color: ColorsManager.primaryBlueAccentColor,
                        ),
                      ),
                    ),
                    SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.01),
                    Text(
                      "Cinema Max",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Version 1.0.0",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02),
              _buildSectionTitle(
                  context,
                  "Our Mission",
              ),
              _buildBodyText(
                  context,
                  "Cinema Max is dedicated to bringing the magic of the big screen directly to your fingertips. Our mission is to simplify the movie-going experience, providing film enthusiasts with a seamless platform to discover, track, and reserve their favorite cinematic adventures.",
              ),
              SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02),
              _buildSectionTitle(context, "What We Offer"),
              _buildBodyText(context,
                  "• Discover the latest popular, top-rated, and upcoming movies."),
              _buildBodyText(context,
                  "• Detailed information about casts, production companies, and storylines."),
              _buildBodyText(
                  context, "• Easy and intuitive seat reservation system."),
              _buildBodyText(context,
                  "• Personalized watch lists and favorite lists to keep track of movies you love."),
              _buildBodyText(context,
                  "• Secure local storage for your tickets and profile."),
              SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02),
              _buildSectionTitle(context, "The Experience"),
              _buildBodyText(context,
                  "Designed with a focus on modern UI/UX principles, Cinema Max ensures that whether you are browsing in portrait or landscape mode, your experience remains immersive and responsive. We utilize the powerful TMDB API to ensure you always have access to the most up-to-date movie database in the world."),
              SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: ColorsManager.primaryBlueAccentColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBodyText(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          height: 1.5,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

}
