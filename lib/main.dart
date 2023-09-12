import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:luvit/firebase_options.dart';
import 'package:luvit/shared/routes/app_pages.dart';
import 'package:luvit/shared/theme/app_theme.dart';
import 'package:luvit/shared/translations/app_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: GetMaterialApp(
        title: 'app_name'.tr,
        debugShowCheckedModeBanner: false,
        enableLog: true,
        initialRoute: Routes.home,
        defaultTransition: Transition.fade,
        theme: AppTheme.themeData,
        translations: AppTranslations(),
        locale: const Locale('kr', 'kr'),
        fallbackLocale: const Locale('kr', 'kr'),
        getPages: AppPages.pages,
      ),
    );
  }
}
