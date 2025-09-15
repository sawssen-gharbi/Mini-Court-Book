import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_court_book/core/theme/app_palette.dart';

class AppTheme {
  late double defaultFontSize = 16.0;

  static final theme = ThemeData.light().copyWith(
    primaryColor: AppPalette.primaryColor,

    colorScheme: const ColorScheme.light(
      primary: AppPalette.primaryColor,
      error: AppPalette.errorColor,
      surface: AppPalette.surfaceColor,
    ),

    scaffoldBackgroundColor: AppPalette.backgroundColor,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppPalette.backgroundColor,
      foregroundColor: AppPalette.textPrimaryColor,
      centerTitle: true,
      scrolledUnderElevation: 0,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppPalette.primaryColor,
      selectedColor: AppPalette.primaryColor.withValues(),
      labelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppPalette.primaryColor, width: 2.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppPalette.errorColor, width: 1.w),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: AppPalette.textPrimaryColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppPalette.textPrimaryColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppPalette.textPrimaryColor,
      ),
      titleLarge: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppPalette.textPrimaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppPalette.textPrimaryColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 20.sp,
        color: AppPalette.textPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        color: AppPalette.textPrimaryColor,
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppPalette.textPrimaryColor,
      ),
    ),
  );
}
