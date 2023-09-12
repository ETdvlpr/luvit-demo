import 'package:get/get.dart';
import 'package:luvit/core/repository/home_repository.dart';
import 'package:luvit/ui/controllers/home_controller.dart';
import 'package:luvit/ui/controllers/profile_display_controller.dart';

/*
  Binding and DI for home flow.
*/
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeRepository>(() => HomeRepository(), fenix: true);
    Get.lazyPut(() => HomeController(repository: Get.find()));
    Get.lazyPut(() => ProfileDisplayController(repository: Get.find()));
  }
}
