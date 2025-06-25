// lib/themes/app_theme.dart
import 'package:flutter/material.dart';
import '../colors/app_color.dart';
import 'text_theme.dart';

class AppTheme {
  static ThemeData lightTheme(String fontFamily) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColor.primaryColor,
      scaffoldBackgroundColor: AppColor.whiteColor,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColor.primaryColor,
        onPrimary: Colors.white,
        secondary: AppColor.secondaryColor,
        onSecondary: Colors.white,
        surface: AppColor.whiteColor,
        onSurface: AppColor.primaryTextColor,
        error: AppColor.errorColor,
        onError: Colors.white,
      ),
      iconTheme: const IconThemeData(color: AppColor.primaryColor, size: 20),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      buttonTheme: const ButtonThemeData(),
      pageTransitionsTheme: const PageTransitionsTheme(),
      textTheme: AppTextTheme.lightTextTheme(fontFamily),
      cardColor: Colors.white,
      dividerColor: AppColor.whiteColor,
    );
  }

  static ThemeData darkTheme(String fontFamily) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColor.primaryColor,
      scaffoldBackgroundColor: AppColor.blackColor,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColor.secondaryColor,
        onPrimary: Colors.black,
        secondary: AppColor.primaryColor,
        onSecondary: Colors.black,
        surface: AppColor.blackColor,
        onSurface: AppColor.primaryDarkTextColor,
        error: AppColor.errorColor,
        onError: Colors.black,
      ),
      iconTheme: const IconThemeData(color: AppColor.whiteColor, size: 20),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.secondaryColor,
        foregroundColor: Color.fromARGB(255, 228, 228, 228),
        elevation: 0,
      ),
      textTheme: AppTextTheme.darkTextTheme(fontFamily),
      cardColor: AppColor.greyColor.withValues(alpha: 0.2),
      dividerColor: AppColor.greyColor.withValues(alpha: 0.3),
    );
  }
}
