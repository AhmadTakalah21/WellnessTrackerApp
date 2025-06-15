import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: AppColors.mainColor,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.mainColor,
    onPrimary: AppColors.mainColor,
    secondary: AppColors.secondaryColor,
    onSecondary: Colors.black54,
    error: AppColors.red,
    onError: AppColors.mainColor,
    surface: AppColors.white,
    onSurface: AppColors.white,
    onTertiary: Colors.black
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontFamily: GoogleFonts.lexend().fontFamily,
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.w700,
      height: 1.48,
      fontSize: 32,
    ),
    headlineMedium: TextStyle(
      fontFamily: GoogleFonts.lexend().fontFamily,
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.w700,
      height: 1.36,
      fontSize: 24,
    ),
    headlineSmall: TextStyle(
      fontFamily: GoogleFonts.lexend().fontFamily,
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.w700,
      height: 1.34,
      fontSize: 22,
    ),
    titleLarge: TextStyle(
      fontFamily: GoogleFonts.lexend().fontFamily,
      color: AppColors.secondaryColor,
      height: 1.26,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
    titleMedium: const TextStyle(
      color: AppColors.secondaryColor,
      height: 1.4,
      fontSize: 16,
    ),
    titleSmall: TextStyle(
      fontFamily: GoogleFonts.lexend().fontFamily,
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.w600,
      height: 1.22,
      fontSize: 14,
    ),
    labelLarge: const TextStyle(
      fontSize: 14,
      height: 1.22,
      color: AppColors.secondaryColor,
    ),
    labelMedium: TextStyle(
      fontSize: 16,
      height: 1.4,
      color: AppColors.secondaryColor,
    ),
    labelSmall: const TextStyle(
      fontSize: 11,
      height: 1.18,
      color: AppColors.secondaryColor,
    ),
    bodyLarge: const TextStyle(
      color: AppColors.secondaryColor,
      height: 1.26,
      fontSize: 16,
    ),
    bodyMedium: const TextStyle(
      color: AppColors.secondaryColor,
      height: 1.22,
      fontSize: 14,
    ),
    bodySmall: const TextStyle(
      color: AppColors.secondaryColor,
      height: 1.12,
      fontSize: 12,
    ),
  ),
  scaffoldBackgroundColor: AppColors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.black,
    iconTheme: IconThemeData(color: AppColors.secondaryColor),
  ),
  iconTheme: IconThemeData(color: AppColors.secondaryColor),
  useMaterial3: true,
);
