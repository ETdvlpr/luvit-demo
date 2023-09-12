import 'package:get/get.dart';
import 'package:luvit/core/enums/common_enums.dart';
import 'package:luvit/core/repository/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository repository;

  HomeController({required this.repository});

  final status = Status.success.obs;

  final _selectedTab = 0.obs;
  int get selectedTab => _selectedTab.value;
  set selectedTab(int index) => _selectedTab.value = index;

  // Handle bottom navigation tab tap
  void onBottomNavigationTap(int value) {
    selectedTab = value;
  }
}
