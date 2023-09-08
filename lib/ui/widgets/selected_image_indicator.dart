import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luvit/shared/theme/app_theme.dart';

class SelectedImageIndicator extends StatefulWidget {
  final int selectedIndex;
  final int itemCount;
  final Function(int)? onItemSelected;

  SelectedImageIndicator(
      {required this.selectedIndex, this.onItemSelected, this.itemCount = 5});

  @override
  _SelectedImageIndicatorState createState() => _SelectedImageIndicatorState();
}

class _SelectedImageIndicatorState extends State<SelectedImageIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(widget.itemCount, (index) {
          bool isSelected = index == widget.selectedIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                if (widget.onItemSelected != null) {
                  widget.onItemSelected!(index);
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 3,
                decoration: ShapeDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          begin: Alignment(0.75, -0.67),
                          end: Alignment(-0.75, 0.67),
                          colors: [
                            AppTheme.primaryColor,
                            AppTheme.primaryLight
                          ],
                        )
                      : null,
                  color: isSelected ? null : AppTheme.black31,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1000),
                  ),
                ),
                //large bottom margin to increase the clickable area
                margin: EdgeInsets.only(
                  left: 2.0,
                  right: 2.0,
                  top: 5.0,
                  bottom: 20.0,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
