import 'package:flutter/material.dart';
import 'package:luvit/shared/theme/app_theme.dart';
import 'package:luvit/shared/theme/custom_icons.dart';
import 'package:luvit/ui/widgets/gradient_icon.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment(-0.75, -0.57),
                end: Alignment(0.75, 0.67),
                colors: [
                  AppTheme.blue,
                  AppTheme.purple,
                ],
              ).createShader(bounds);
            },
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            left: 12.41,
            top: 12.41,
            child: Container(
              width: 23.17,
              height: 23.17,
              child: GradientIcon(
                CustomIcons.heart,
                LinearGradient(
                  begin: Alignment(-0.75, -0.57),
                  end: Alignment(0.75, 0.67),
                  colors: [
                    AppTheme.blue,
                    AppTheme.purple,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
