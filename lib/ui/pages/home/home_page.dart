import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:luvit/shared/theme/app_theme.dart';
import 'package:luvit/shared/theme/custom_icons.dart';
import 'package:luvit/ui/controllers/home_controller.dart';
import 'package:luvit/ui/controllers/profile_display_controller.dart';
import 'package:luvit/ui/widgets/bottom_navbar.dart';
import 'package:luvit/ui/widgets/profile/profile_card_list.dart';
import 'package:luvit/ui/widgets/title_bar.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileDisplayController profileDisplayController = Get.find();
    return Scaffold(
      backgroundColor: AppTheme.black13,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.black13,
        elevation: 0,
        titleSpacing: 0.0,
        title: TitleBar(
          starCount: 323233,
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '목이길어슬픈기린',
                  style: AppTheme.boldTextStyle,
                ),
                TextSpan(
                  text: '님의 새로운 ',
                  style: AppTheme.thinTextStyle,
                ),
                TextSpan(
                  text: '스팟',
                  style: AppTheme.boldTextStyle,
                ),
              ],
            ),
          ),
          hasNotification: true,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await profileDisplayController.fetchProfiles();
          profileDisplayController.currentIndex.value = 0;
        },
        child: ListView(
          children: [
            Container(
              constraints: BoxConstraints(minHeight: 700.h),
              child: ProfileList(),
            ),
          ],
          shrinkWrap: true,
        ),
      ),
      extendBody: true,
      bottomNavigationBar: CustomPaint(
        painter: ShadowPainter(),
        child: ClipPath(
          clipper: BottomNavbarShape(),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Obx(
              () => BottomNavigationBar(
                currentIndex: controller.selectedTab,
                selectedItemColor: AppTheme.primaryColor,
                unselectedItemColor: AppTheme.black58,
                onTap: controller.onBottomNavigationTap,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.black,
                items: <BottomNavigationBarItem>[
                  _bottomNavItem(CustomIcons.home, 'home'.tr, 0),
                  _bottomNavItem(CustomIcons.location, 'spot'.tr, 1),
                  _bottomNavCenterItem(controller.selectedTab == 2),
                  _bottomNavItem(CustomIcons.chat, 'chat'.tr, 3),
                  _bottomNavItem(CustomIcons.group, 'my page'.tr, 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavItem(
    IconData icon,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  BottomNavigationBarItem _bottomNavCenterItem(bool isSelected) {
    return BottomNavigationBarItem(
      icon: Container(
        width: 50,
        height: 50,
        child: Stack(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.44, -0.90),
                  end: Alignment(-0.44, 0.9),
                  colors: [Color(0xFF0F0F0F), Color(0xFF2E2E2E)],
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: isSelected ? AppTheme.primaryColor : Colors.black,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? AppTheme.primaryColor.withOpacity(0.2)
                        : AppTheme.shadowColor,
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 11.21,
              top: 11.21,
              child: Container(
                width: 27.59,
                height: 27.59,
                child: Icon(
                  CustomIcons.star,
                  color: isSelected ? AppTheme.primaryColor : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      label: '',
    );
  }
}
