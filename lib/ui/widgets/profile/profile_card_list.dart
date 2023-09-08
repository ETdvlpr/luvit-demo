import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:luvit/shared/theme/app_theme.dart';
import 'package:luvit/ui/controllers/home_controller.dart';
import 'package:luvit/ui/widgets/profile/profile_card.dart';
import 'package:luvit/ui/widgets/slide_from_right.dart';

class ProfileList extends StatelessWidget {
  ProfileList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        if (controller.currentIndex.value >= controller.profiles.length) {
          // Display a message when there are no more profiles.
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '추천 드릴 친구들을 준비 중이에요',
                  textAlign: TextAlign.center,
                  style: AppTheme.headline4BoldStyle,
                ),
                const SizedBox(height: 12),
                Text(
                  '매일 새로운 친구들을 소개시켜드려요',
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
        return Stack(
          children: [
            // Display the current profile card with drag functionality.
            SlideInFromRight(
              slideInKey: GlobalKey<SlideInFromRightState>(),
              child: Draggable(
                child: ProfileCard(
                  profile: controller.profiles[controller.currentIndex.value],
                ),
                feedback: ProfileCard(
                  profile: controller.profiles[controller.currentIndex.value],
                ),
                childWhenDragging: const SizedBox(),
                onDragEnd: (details) {
                  if (details.velocity != Velocity.zero) {
                    print("velocity: ${details.velocity}");
                    print("offset: ${details.offset}");
                    // If dragged down or to the left, increment the index.
                    if (details.offset.dx < -50 || details.offset.dy > 50) {
                      controller.incrementIndex();
                    }
                  }
                },
              ),
            ),
            // Show a small part of the next card to indicate more cards are available.
            if (controller.currentIndex.value + 1 < controller.profiles.length)
              Positioned(
                top: 10,
                left: 385.h,
                child: Draggable(
                  child: ProfileCard(
                    profile:
                        controller.profiles[controller.currentIndex.value + 1],
                  ),
                  feedback: ProfileCard(
                    profile:
                        controller.profiles[controller.currentIndex.value + 1],
                  ),
                  childWhenDragging: const SizedBox(),
                  onDragEnd: (details) {
                    // If dragged to the left, increment the index.
                    if (details.offset.dx < 375.h - 100) {
                      controller.incrementIndex();
                    }
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
