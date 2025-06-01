// lib/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xFF126EB2);
  static const secondary = Color(0xFFEFF1F5);
  static const background = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF000000);
  static const textSecondary = Color(0xFF292D32);
  static const inputHint = Color(0xFF919191);
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const red = Color(0xFFD32F2F);
  static const lightGray = Color(0xFFE5E5E5);
  static const darkGray = Color(0xFF292D32);
  static const gray = Color(0xFF919191);
}

class AppTextStyles {
  static const title = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const subtitle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const smallNote = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: AppColors.textSecondary,
  );

  static const button = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
}

ThemeData buildAppTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      bodyLarge: AppTextStyles.title,
      bodyMedium: AppTextStyles.subtitle,
      bodySmall: AppTextStyles.smallNote,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        textStyle: AppTextStyles.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
  );
}

ThemeData buildDarkTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      bodyLarge: AppTextStyles.title,
      bodyMedium: AppTextStyles.subtitle,
      bodySmall: AppTextStyles.smallNote,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        textStyle: AppTextStyles.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
    brightness: Brightness.dark,
  );
}
