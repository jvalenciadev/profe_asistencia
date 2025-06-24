// lib/themes/app_theme.dart
import 'package:flutter/material.dart';
import '../colors/app_color.dart';
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColor.primaryColor,
      scaffoldBackgroundColor: AppColor.whiteColor,
      colorScheme: ColorScheme.light(
        primary: AppColor.primaryColor,
        secondary: AppColor.secondaryColor,
        surface: AppColor.whiteColor,
        onSurface: AppColor.blackColor,
      ),
      iconTheme: const IconThemeData(
        color: AppColor.primaryColor,
        size: 20,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
      ),
      buttonTheme: const ButtonThemeData(),
      pageTransitionsTheme: const PageTransitionsTheme(),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColor.primaryColor,
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.dark(
        primary: AppColor.whiteColor,
        secondary: AppColor.secondaryColor,
        surface: AppColor.blackColor,
        onSurface: AppColor.whiteColor,
      ),
      iconTheme: const IconThemeData(
        color: AppColor.whiteColor,
        size: 20,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.secondaryColor,
        foregroundColor: Color.fromARGB(255, 228, 228, 228),
      ),
    );
  }
}
