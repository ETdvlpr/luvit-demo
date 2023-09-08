import 'package:get/get.dart';
import 'package:luvit/core/enums/common_enums.dart';
import 'package:luvit/core/models/profile.dart';
import 'package:luvit/core/repository/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository repository;

  HomeController({required this.repository});

  final status = Status.success.obs;

  final RxInt currentIndex = 0.obs;

  final _selectedTab = 0.obs;
  int get selectedTab => _selectedTab.value;
  set selectedTab(int index) => _selectedTab.value = index;

  final RxList<Profile> _profiles = <Profile>[].obs;
  List<Profile> get profiles => _profiles;
  set profiles(List<Profile> value) => _profiles.value = value;

  @override
  void onInit() async {
    // Initialize data and listen for changes
    fetchProfiles();
    repository.ref.onValue.listen((event) {
      final data = event.snapshot.value as Map<Object?, Object?>;
      final profiles = data.entries
          .map((e) => Profile.fromJson(
              Map<String, dynamic>.from(e.value as Map<Object?, Object?>)))
          .toList();
      this.profiles = profiles;
    }, onError: (error) {
      print("error updating profiles: $error");
    });
    super.onInit();
  }

  // Handle bottom navigation tab tap
  void onBottomNavigationTap(int value) {
    selectedTab = value;
  }

  // Fetch profiles from the repository
  fetchProfiles() {
    status(Status.loading);
    return repository.fetchProfiles().then((value) {
      if (value != null) profiles = value;
      update();
      status(Status.success);
    }).catchError((error) {
      print("error fetching profiles: $error");
      status(Status.error);
    });
  }

  // Increment the current index
  void incrementIndex() {
    currentIndex.value++;
    update();
  }

  // Handle like button press
  void onLikeButtonPressed() {}

  // Handle more icon press
  void onMoreIconPressed() {}
}
