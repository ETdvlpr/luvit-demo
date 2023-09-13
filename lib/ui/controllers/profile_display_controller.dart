import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luvit/core/enums/common_enums.dart';
import 'package:luvit/core/models/profile.dart';
import 'package:luvit/core/repository/home_repository.dart';

class ProfileDisplayController extends GetxController {
  final HomeRepository repository;

  ProfileDisplayController({required this.repository});

  final status = Status.success.obs;

  final RxInt currentIndex = 0.obs;

  final RxList<Profile> _profiles = <Profile>[].obs;
  List<Profile> get profiles => _profiles;
  set profiles(List<Profile> value) => _profiles.value = value;

  Offset? mainDragStartPosition;
  Offset? nextDragStartPosition;
  final Rx<Offset> mainCardOffset = Offset(0, 0).obs;
  final Rx<Offset> nextCardOffset = Offset(0, 0).obs;

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

  void handleMainSwipe(DragUpdateDetails details) {
    mainDragStartPosition ??= details.localPosition;
    final dx = details.localPosition.dx - mainDragStartPosition!.dx;
    final dy = details.localPosition.dy - mainDragStartPosition!.dy;

    mainCardOffset.value = Offset(
      dx.clamp(double.negativeInfinity, 10),
      dy.clamp(-20, double.infinity),
    );
  }

  void handleMainSwipeEnd(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dx < -50 ||
        details.velocity.pixelsPerSecond.dy > 50 ||
        mainCardOffset.value.dx < -150 ||
        mainCardOffset.value.dy > 150) {
      incrementIndex();
    }

    mainDragStartPosition = null;
    mainCardOffset.value = Offset.zero;
  }

  void handleNextSwipe(DragUpdateDetails details) {
    nextDragStartPosition ??= details.localPosition;
    final dx = details.localPosition.dx - nextDragStartPosition!.dx;
    final dy = details.localPosition.dy - nextDragStartPosition!.dy;

    nextCardOffset.value = Offset(dx, dy);
  }

  void handleNextSwipeEnd(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dx < -50 ||
        nextCardOffset.value.dx < -150) {
      incrementIndex();
    }

    nextDragStartPosition = null;
    nextCardOffset.value = Offset(0, 0);
  }

  // Handle like button press
  void onLikeButtonPressed() {}

  // Handle more icon press
  void onMoreIconPressed() {}
}
