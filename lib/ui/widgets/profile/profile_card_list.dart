import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:luvit/shared/theme/app_theme.dart';
import 'package:luvit/ui/controllers/profile_display_controller.dart';
import 'package:luvit/ui/widgets/profile/profile_card.dart';

class ProfileList extends StatelessWidget {
  ProfileList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileDisplayController>(
      builder: (controller) {
        if (controller.currentIndex.value >= controller.profiles.length) {
          return _buildEmptyWidget();
        }

        return Stack(
          children: [
            // Display the current profile card with swipe functionality.
            Positioned(
              child: GestureDetector(
                onHorizontalDragUpdate: controller.handleMainSwipe,
                onVerticalDragUpdate: controller.handleMainSwipe,
                onHorizontalDragEnd: controller.handleMainSwipeEnd,
                onVerticalDragEnd: controller.handleMainSwipeEnd,
                child: Obx(
                  () => Transform.translate(
                    offset: controller.mainCardOffset.value,
                    child: ProfileCard(
                      key: Key(controller.currentIndex.value.toString()),
                      profile:
                          controller.profiles[controller.currentIndex.value],
                    ),
                  ),
                ),
              ),
            ),
            // Show a small part of the next card to indicate more cards are available.
            if (controller.currentIndex.value + 1 < controller.profiles.length)
              Positioned(
                left: 365.w,
                child: GestureDetector(
                  onHorizontalDragUpdate: controller.handleNextSwipe,
                  onVerticalDragUpdate: controller.handleNextSwipe,
                  onHorizontalDragEnd: controller.handleNextSwipeEnd,
                  onVerticalDragEnd: controller.handleNextSwipeEnd,
                  child: Obx(
                    () => Transform.translate(
                      offset: controller.nextCardOffset.value,
                      child: ProfileCard(
                        key: Key(
                          (controller.currentIndex.value + 1).toString(),
                        ),
                        profile: controller
                            .profiles[controller.currentIndex.value + 1],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'preparing friends'.tr,
            textAlign: TextAlign.center,
            style: AppTheme.headline4BoldStyle,
          ),
          const SizedBox(height: 12),
          Text(
            'introduce friends'.tr,
            textAlign: TextAlign.center,
            style: AppTheme.regularTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
