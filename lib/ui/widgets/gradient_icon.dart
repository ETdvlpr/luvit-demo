import 'package:flutter/material.dart';

/// A widget that adds a gradient overlay to an icon.
class GradientIcon extends StatelessWidget {
  /// The icon data for the icon to overlay.
  final IconData icon;

  /// The size of the icon.
  final double size;

  /// The gradient to place over the icon.
  final Gradient gradient;

  /// Creates a `GradientIcon` widget.
  ///
  /// The `icon` parameter is the icon data, `size` specifies the icon size,
  /// and `gradient` is the gradient to overlay the icon with.
  GradientIcon(
    this.icon,
    this.gradient, {
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
