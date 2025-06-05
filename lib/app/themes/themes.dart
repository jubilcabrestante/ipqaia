import 'package:flutter/material.dart';
import 'package:ipqaia/app/themes/colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.backgroundSecondary,
      surface: AppColors.backgroundPrimary,
      error: AppColors.delete,
      tertiary: AppColors.secondary,
      onPrimary: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
      onError: Colors.white,
    ),
    // fontFamily: Assets.fonts.robotoRegular,
    scaffoldBackgroundColor: AppColors.backgroundPrimary,
    textTheme: _getTextTheme(),

    // Dialog Theme
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.backgroundPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      contentTextStyle: TextStyle(
        fontSize: 14,
        color: AppColors.textPrimary,
      ),
    ),

    // InkWell Theme
    splashColor: AppColors.secondary.withValues(alpha: 0.2),
    highlightColor: AppColors.secondary.withValues(alpha: 0.1),

    // SnackBar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.primary,
      contentTextStyle: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      behavior: SnackBarBehavior.floating,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundPrimary,
      elevation: 0,
      titleTextStyle: _getTextTheme().headlineSmall!.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          fontSize: 21),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkGreen,
        foregroundColor: AppColors.textPrimary,
        textStyle: _getTextTheme()
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        minimumSize: const Size(double.infinity, 50),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.primary),
        textStyle: _getTextTheme()
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        minimumSize: const Size(double.infinity, 50),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.secondary,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
  );

  static TextTheme _getTextTheme() => TextTheme(
        displayLarge: TextStyle(
          fontSize: 57.0,
          height: 64.0 / 57.0,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          color: AppColors.textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 45.0,
          height: 52.0 / 45.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          color: AppColors.textPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: 36.0,
          height: 44.0 / 36.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          color: AppColors.textPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: 32.0,
          height: 40.0 / 32.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          color: AppColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 28.0,
          height: 36.0 / 28.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          color: AppColors.textPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: 24.0,
          height: 32.0 / 24.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 22.0,
          height: 28.0 / 22.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16.0,
          height: 24.0 / 16.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: AppColors.textPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: 14.0,
          height: 20.0 / 14.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.0,
          height: 24.0 / 16.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          height: 20.0 / 14.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: AppColors.textPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: 12.0,
          height: 16.0 / 12.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: AppColors.textPrimary,
        ),
        labelLarge: TextStyle(
          fontSize: 14.0,
          height: 20.0 / 14.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: AppColors.gray,
        ),
        labelMedium: TextStyle(
          fontSize: 12.0,
          height: 16.0 / 12.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: AppColors.gray,
        ),
        labelSmall: TextStyle(
          fontSize: 11.0,
          height: 16.0 / 11.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: AppColors.gray,
        ),
      );
}
