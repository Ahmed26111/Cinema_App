import 'package:flutter/material.dart';

import '../../constants/responsive size contants/responsive_size_constants.dart';

class DefaultEmptyListWidget extends StatelessWidget {
  const DefaultEmptyListWidget({super.key, required this.message, required this.helpMessage, this.isLandscape = false});

  final String message;
  final String helpMessage;
  final bool isLandscape;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage("images/empty_list.png"),
          width: 80,
          height: 80,
        ),
        SizedBox(height: ResponsiveSizeConstants.widthScreen(context) * 0.03),
        Text(
          message,
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
