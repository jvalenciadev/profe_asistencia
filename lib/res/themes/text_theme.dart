import 'package:flutter/material.dart';
import '../colors/app_color.dart';

class AppTextTheme {
  static TextStyle _baseStyle({
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    required Color color,
    required String fontFamily,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: fontFamily,
      letterSpacing: letterSpacing ?? 0.2,
      height: height,
    );
  }

  static TextTheme lightTextTheme(String fontFamily) => TextTheme(
    displayLarge: _baseStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColor.primaryTextColor,
      fontFamily: fontFamily,
    ),
    displayMedium: _baseStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColor.primaryTextColor,
      fontFamily: fontFamily,
    ),
    displaySmall: _baseStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: AppColor.primaryTextColor,
      fontFamily: fontFamily,
    ),

    headlineLarge: _baseStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: AppColor.primaryTextColor,
      fontFamily: fontFamily,
    ),
    headlineMedium: _baseStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColor.primaryTextColor,
      fontFamily: fontFamily,
    ),
    headlineSmall: _baseStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColor.secondaryTextColor,
      fontFamily: fontFamily,
    ),

    titleLarge: _baseStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColor.primaryTextColor,
      fontFamily: fontFamily,
    ),
    titleMedium: _baseStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColor.secondaryTextColor,
      fontFamily: fontFamily,
    ),
    titleSmall: _baseStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColor.secondaryTextColor,
      fontFamily: fontFamily,
    ),

    bodyLarge: _baseStyle(
      fontSize: 16,
      color: AppColor.primaryTextColor,
      fontFamily: fontFamily,
    ),
    bodyMedium: _baseStyle(
      fontSize: 14,
      color: AppColor.secondaryTextColor,
      fontFamily: fontFamily,
    ),
    bodySmall: _baseStyle(
      fontSize: 12,
      color: AppColor.secondaryTextColor,
      fontFamily: fontFamily,
    ),

    labelLarge: _baseStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: AppColor.whiteColor,
      fontFamily: fontFamily,
    ),
    labelMedium: _baseStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColor.secondaryTextColor,
      fontFamily: fontFamily,
    ),
    labelSmall: _baseStyle(
      fontSize: 10,
      color: AppColor.secondaryTextColor,
      fontFamily: fontFamily,
    ),
  );

  static TextTheme darkTextTheme(String fontFamily) => TextTheme(
    displayLarge: _baseStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColor.primaryDarkTextColor,
      fontFamily: fontFamily,
    ),
    displayMedium: _baseStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColor.primaryDarkTextColor,
      fontFamily: fontFamily,
    ),
    displaySmall: _baseStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: AppColor.primaryDarkTextColor,
      fontFamily: fontFamily,
    ),

    headlineLarge: _baseStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: AppColor.primaryDarkTextColor,
      fontFamily: fontFamily,
    ),
    headlineMedium: _baseStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColor.primaryDarkTextColor,
      fontFamily: fontFamily,
    ),
    headlineSmall: _baseStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColor.secondaryDrakTextColor,
      fontFamily: fontFamily,
    ),

    titleLarge: _baseStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColor.primaryDarkTextColor,
      fontFamily: fontFamily,
    ),
    titleMedium: _baseStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColor.secondaryDrakTextColor,
      fontFamily: fontFamily,
    ),
    titleSmall: _baseStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColor.secondaryDrakTextColor,
      fontFamily: fontFamily,
    ),

    bodyLarge: _baseStyle(
      fontSize: 16,
      color: AppColor.primaryDarkTextColor,
      fontFamily: fontFamily,
    ),
    bodyMedium: _baseStyle(
      fontSize: 14,
      color: AppColor.secondaryDrakTextColor,
      fontFamily: fontFamily,
    ),
    bodySmall: _baseStyle(
      fontSize: 12,
      color: AppColor.secondaryDrakTextColor,
      fontFamily: fontFamily,
    ),

    labelLarge: _baseStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: AppColor.whiteColor,
      fontFamily: fontFamily,
    ),
    labelMedium: _baseStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColor.secondaryDrakTextColor,
      fontFamily: fontFamily,
    ),
    labelSmall: _baseStyle(
      fontSize: 10,
      color: AppColor.secondaryDrakTextColor,
      fontFamily: fontFamily,
    ),
  );
}
