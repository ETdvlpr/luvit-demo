import 'package:get/route_manager.dart';
import 'package:luvit/ui/bindings/home_binding.dart';
import 'package:luvit/ui/pages/home/home_page.dart';
part 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    // Home page
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
