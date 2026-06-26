import 'package:flutter/material.dart';

import '../../constants/responsive size contants/responsive_size_constants.dart';

class DefaultEmptyMovieWidget extends StatelessWidget {
  const DefaultEmptyMovieWidget({super.key, required this.searchQuery, required this.isLandscape});

  final String searchQuery;
  final bool isLandscape;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        Image(
          image: AssetImage("images/no-results.png"),
          width: 80,
          height: 80,
        ),
        SizedBox(height: ResponsiveSizeConstants.widthScreen(context) * 0.01),
        Text(
          "we are sorry, we can not find the \"$searchQuery\" ",
          style: (isLandscape)? Theme.of(context).textTheme.titleLarge : Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: ResponsiveSizeConstants.widthScreen(context) * 0.01),
        Text(
          "Find your movie by Type title, categories, years, etc",
          style: (isLandscape)? Theme.of(context).textTheme.bodyLarge : Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
