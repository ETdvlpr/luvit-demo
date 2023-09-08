import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Color(0xFFFF016B);
  static const Color primaryLight = Color(0xFFFF4593);
  static const Color primaryPartial = Color(0xB2611132);

  static const Color textWhite = Color(0xFFFBFBFB);
  static const Color textWhiteThin = Color(0xFFD9D9D9);
  static const Color red = Color(0xFFE90000);
  static const Color blue = Color(0xFF45FFF4);
  static const Color purple = Color(0xFF7000FF);
  static const Color black58 = Color(0xFF3A3A3A);
  static const Color black31 = Color(0xFF1F1F1F);
  static const Color black13 = Color(0xFF0D0C0D);
  static const Color white245 = Color(0xFFF5F5F5);
  static const Color shadowColor = Color(0xFF595959);

  static ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'Pretendard',
  );

  static TextStyle thinTextStyle = TextStyle(
    color: textWhiteThin,
    fontSize: 14,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w300,
    height: 1.50,
    letterSpacing: -0.60,
  );

  static TextStyle regularTextStyle = TextStyle(
    color: textWhite,
    fontSize: 14,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    letterSpacing: -0.60,
  );

  static TextStyle boldTextStyle = TextStyle(
    color: textWhite,
    fontSize: 14,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    letterSpacing: -0.60,
  );

  static TextStyle headline4ThinStyle = TextStyle(
    color: textWhite,
    fontSize: 24,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w300,
    height: 1.20,
    letterSpacing: -0.60,
  );

  static TextStyle headline4BoldStyle = TextStyle(
    color: textWhite,
    fontSize: 24,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    height: 1.20,
    letterSpacing: -0.60,
  );

  static TextStyle headline3BoldStyle = TextStyle(
    color: textWhite,
    fontSize: 28,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    height: 1.20,
    letterSpacing: -0.60,
  );
}
