import 'package:flutter/material.dart';
import 'package:luvit/shared/theme/app_theme.dart';

final kCornerRadius = 12.0;
final yOffset = 15.0;
_bottomClipPath(Size size) => Path()
  ..lineTo(0, kCornerRadius + yOffset)
  ..quadraticBezierTo(0, yOffset, kCornerRadius, yOffset)
  ..lineTo(size.width / 2 - 35, yOffset)
  ..quadraticBezierTo(
      size.width / 2 - 25, yOffset, size.width / 2 - yOffset, yOffset / 2)
  ..quadraticBezierTo(size.width / 2, 0, size.width / 2 + yOffset, yOffset / 2)
  ..quadraticBezierTo(
      size.width / 2 + 25, yOffset, size.width / 2 + 35, yOffset)
  ..lineTo(size.width - kCornerRadius, yOffset)
  ..quadraticBezierTo(size.width, yOffset, size.width, kCornerRadius + yOffset)
  ..lineTo(size.width, size.height)
  ..lineTo(0, size.height)
  ..close();

class BottomNavbarShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = _bottomClipPath(size);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw the shadow
    final paint = Paint()
      ..color = AppTheme.shadowColor
      ..style = PaintingStyle.stroke
      // ..maskFilter = MaskFilter.blur(BlurStyle.inner, 3);
      ..strokeWidth = 1.0;

    canvas.drawPath(_bottomClipPath(size), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
