import 'package:cinema_app/constants/responsive%20size%20contants/responsive_size_constants.dart';
import 'package:flutter/material.dart';

class DefaultFailedToLoadWidget extends StatelessWidget {
  const DefaultFailedToLoadWidget({super.key, required this.errorMessage, required this.helpMessage, this.isLandscape = false});

  final String errorMessage;
  final String helpMessage;
  final bool isLandscape;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
            image: AssetImage("images/failed_to_loading.png"),
            width: 80,
            height: 80,
        ),
        SizedBox(height: ResponsiveSizeConstants.widthScreen(context) * 0.01),
        Text(
            errorMessage,
            style: (isLandscape)? Theme.of(context).textTheme.titleLarge : Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
        ),
        SizedBox(height: ResponsiveSizeConstants.widthScreen(context) * 0.01),
        Text(
          helpMessage,
          style: (isLandscape)? Theme.of(context).textTheme.bodyLarge : Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
