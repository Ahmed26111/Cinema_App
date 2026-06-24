import 'package:flutter/material.dart';

import '../../constants/color constants/colors_manager.dart';

class DefaultMovieRateContainer extends StatelessWidget {
  const DefaultMovieRateContainer({super.key, required this.movieRate});

  final double movieRate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 56,
      decoration: BoxDecoration(
        color: ColorsManager.primarySoftColorLessOpacity,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star_rate_rounded , color: ColorsManager.orangeColorLessOpacity,),
            Text(
              movieRate.toStringAsFixed(1),
              style: TextStyle(
                  color: ColorsManager.orangeColorLessOpacity,
                  fontWeight: FontWeight.bold,
                  fontSize: 12
              ),
            ),
          ],
        ),
      ),
    );
  }
}
