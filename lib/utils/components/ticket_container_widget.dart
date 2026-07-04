import 'package:flutter/material.dart';

class TicketContainerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Color color;
  final Widget? child;

  const TicketContainerWidget({
    super.key,
    this.width,
    this.height,
    this.color = Colors.white,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(),
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 150,
        color: color,
        child: child,
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start at top left
    path.lineTo(0.0, 0.0);

    // Top edge
    path.lineTo(size.width, 0.0);

    // Right edge with small semi-circle cutouts
    double cutoutRadius = 5.0;
    double spacing = 6.0;
    double currentY = spacing;

    while (currentY + cutoutRadius * 2 < size.height) {
      path.lineTo(size.width, currentY);
      path.arcToPoint(
        Offset(size.width, currentY + cutoutRadius * 2),
        radius: Radius.circular(cutoutRadius),
        clockwise: false,
      );
      currentY += cutoutRadius * 2 + spacing;
    }
    path.lineTo(size.width, size.height);

    // Bottom edge
    path.lineTo(0.0, size.height);

    // Left edge with small semi-circle cutouts (bottom to top)
    currentY = size.height - spacing;
    while (currentY - cutoutRadius * 2 > 0) {
      path.lineTo(0.0, currentY);
      path.arcToPoint(
        Offset(0.0, currentY - cutoutRadius * 2),
        radius: Radius.circular(cutoutRadius),
        clockwise: false,
      );
      currentY -= cutoutRadius * 2 + spacing;
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
