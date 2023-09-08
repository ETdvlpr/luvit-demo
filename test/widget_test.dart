import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:luvit/firebase_options.dart';
import 'package:luvit/ui/bindings/home_binding.dart';
import 'package:luvit/ui/pages/home/home_page.dart';

void main() {
  testWidgets('HomePage Widget Test', (WidgetTester tester) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        child: GetMaterialApp(
          home: HomePage(),
          initialBinding: HomeBinding(),
        ),
      ),
    );

    expect(find.byType(RefreshIndicator), findsOneWidget);

    expect(find.byType(ListView), findsOneWidget);

    expect(find.text('목이길어슬픈기린'), findsOneWidget);
  });
}
