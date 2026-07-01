import 'package:cinema_app/constants/color%20constants/colors_manager.dart';
import 'package:flutter/material.dart';

class CinemaScreenWidget extends StatelessWidget {
  const CinemaScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          size: const Size(double.infinity, 30),
          painter: _CinemaScreenPainter(),
        ),
        const SizedBox(height: 10),
        Text(
          "Screen",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }
}

class _CinemaScreenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = ColorsManager.primaryBlueAccentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final Path path = Path();
    // Starting point (slightly inward from left)
    path.moveTo(size.width * 0.1, size.height);
    // Draw the curve (control point at the top center)
    path.quadraticBezierTo(
      size.width * 0.5,
      0,
      size.width * 0.9,
      size.height,
    );

    // Glow effect (Outer blurred line)
    final Paint glowPaint = Paint()
      ..color = ColorsManager.primaryBlueAccentColor.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
