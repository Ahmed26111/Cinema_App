import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:cinema_app/utils/components/default_pop_back_icon_button.dart';
import 'package:flutter/material.dart';

class LegalAndPoliciesScreen extends StatelessWidget {
  const LegalAndPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privacy Policy",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        leading: DefaultPopBackIconButton(),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(context, "Effective Date: May 2024"),
              _buildBodyText(context,
                  "At Cinema App, we are committed to protecting your privacy. This Privacy Policy explains how we collect, use, and share information about you when you use our mobile application."),
              SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02),
              _buildSectionTitle(context, "1. Information We Collect"),
              _buildBodyText(context,
                  "• Account Information: When you create an account, we collect your first name, last name, email address, and password to provide you with a personalized experience."),
              _buildBodyText(context,
                  "• Booking Data: When you reserve tickets, we collect data regarding the movie, selected seats, showtime, and price. This data is stored locally on your device (using Hive) to display your 'Your Tickets' history."),
              _buildBodyText(context,
                  "• User Preferences: We save your 'Favorite Movies' and 'Watchlist' selections to help you organize your streaming and cinema interests."),
              _buildBodyText(context,
                  "• Device Information: We may collect information about your mobile device (e.g., model, OS version) to ensure the app functions correctly in both portrait and landscape modes."),
              SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02),
              _buildSectionTitle(context, "2. How We Use Your Information"),
              _buildBodyText(context, "We use the collected information to:"),
              _buildBodyText(context, "• Maintain and update your user profile."),
              _buildBodyText(context, "• Process and display your cinema ticket reservations."),
              _buildBodyText(context, "• Personalize movie recommendations based on your favorites."),
              _buildBodyText(context, "• Improve app performance and fix technical bugs."),
              SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02),
              _buildSectionTitle(context, "3. Data Storage (Hive)"),
              _buildBodyText(context,
                  "Most of your data (Tickets, Favorites, and Profile) is stored securely on your local device using the Hive database. This means your sensitive booking history stays on your phone unless you choose to sync it with an external service in the future."),
              SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02),
              _buildSectionTitle(context, "4. Third-Party Services"),
              _buildBodyText(context,
                  "Our app uses the TMDB (The Movie Database) API to fetch movie details, posters, and cast information. TMDB does not receive your personal account data or booking history."),
              SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02),
              _buildSectionTitle(context, "5. Security"),
              _buildBodyText(context,
                  "We implement industry-standard security measures to protect your data. However, no method of transmission over the internet or electronic storage is 100% secure."),
              SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02),
              _buildSectionTitle(context, "6. Your Rights"),
              _buildBodyText(context, "You have the right to:"),
              _buildBodyText(context, "• Update or correct your profile information via the Edit Profile screen."),
              _buildBodyText(context, "• Clear all local data by logging out of the application."),
              _buildBodyText(context, "• Delete your account information at any time."),
              SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02),
              _buildSectionTitle(context, "7. Changes to This Policy"),
              _buildBodyText(context,
                  "We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this screen."),
              SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.02),
              _buildSectionTitle(context, "8. Contact Us"),
              _buildBodyText(context,
                  "If you have any questions about this Privacy Policy, please contact us at: support@cinemaemail.com"),
              SizedBox(height: ResponsiveSizeConstants.heightScreen(context) * 0.04),
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
      ),
    );
  }
}
