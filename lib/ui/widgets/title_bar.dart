import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luvit/shared/theme/app_theme.dart';
import 'package:luvit/shared/theme/custom_icons.dart';
import 'package:luvit/ui/widgets/gradient_icon.dart';

class TitleBar extends StatelessWidget {
  final Widget title;
  final int starCount;
  final bool hasNotification;

  TitleBar({
    required this.title,
    required this.starCount,
    this.hasNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(color: AppTheme.black13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                CustomIcons.location,
                color: AppTheme.white245,
                size: 16,
              ),
              SizedBox(width: 6),
              title,
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    width: 0.50,
                    color: AppTheme.black31,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GradientIcon(
                      CustomIcons.star,
                      LinearGradient(
                        begin: Alignment(0.75, -0.67),
                        end: Alignment(-0.75, 0.67),
                        colors: [
                          AppTheme.primaryColor,
                          AppTheme.primaryLight,
                        ],
                      ),
                      size: 14,
                    ),
                    SizedBox(width: 2),
                    Text(
                      NumberFormat('###,###,###,###').format(starCount),
                      style: AppTheme.regularTextStyle,
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    child: Icon(
                      CustomIcons.notification,
                      color: Colors.white,
                      size: 19,
                    ),
                  ),
                  if (hasNotification)
                    Positioned(
                      right: 9,
                      top: 9,
                      child: Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.red,
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
