import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: AppColors.mainColor,
  colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.mainColor,
      onPrimary: AppColors.secondaryColor,
      secondary: AppColors.secondaryColor,
      onSecondary: Colors.black54,
      error: AppColors.red,
      onError: AppColors.mainColor,
      surface: AppColors.white,
      onSurface: AppColors.secondaryColor,
      onTertiary: Colors.black,
      onSecondaryFixed: AppColors.grey,
      onPrimaryFixed: AppColors.blue),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontFamily: GoogleFonts.lexend().fontFamily,
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.w700,
      height: 1.48,
      fontSize: 32,
    ),
    headlineLarge: TextStyle(
      fontFamily: GoogleFonts.lexend().fontFamily,
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.w700,
      height: 1.36,
      fontSize: 28,
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
      fontWeight: FontWeight.w600,
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
    titleTextStyle: TextStyle(
      fontFamily: GoogleFonts.lexend().fontFamily,
      color: AppColors.secondaryColor,
      height: 1.26,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
    centerTitle: true,
    elevation: 10,
    backgroundColor: AppColors.mainColor,
    iconTheme: IconThemeData(color: AppColors.secondaryColor),
  ),
  iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(AppColors.secondaryColor))),
  iconTheme: IconThemeData(color: AppColors.secondaryColor),
  useMaterial3: true,
  // textSelectionToolbarTheme: TextSelectionToolbarThemeData(
  //   toolbarTextStyle: TextStyle(
  //     color: AppColors.secondaryColor,  // Color of "Copy", "Paste" etc.
  //     fontSize: 14,
  //   ),
  // ),

  datePickerTheme: DatePickerThemeData(
    backgroundColor: AppColors.white,
    headerForegroundColor: AppColors.secondaryColor,
    headerBackgroundColor: AppColors.mainColor,
    dividerColor: AppColors.mainColor,
    weekdayStyle: TextStyle(
      color: AppColors.secondaryColor,
    ),
    yearStyle: TextStyle(
      color: AppColors.secondaryColor,
    ),
    todayForegroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.white;
      }
      if (states.contains(WidgetState.disabled)) {
        return AppColors.grey;
      }
      return AppColors.mainColor;
    }),
    todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.mainColor;
      }
      return null;
    }),
    dayForegroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.white;
      }
      if (states.contains(WidgetState.disabled)) {
        return AppColors.grey;
      }
      return AppColors.secondaryColor;
    }),
    dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.mainColor;
      }
      return null;
    }),
    yearForegroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.secondaryColor;
      }
      return AppColors.secondaryColor;
    }),
    yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.mainColor;
      }
      return null;
    }),
    cancelButtonStyle: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(AppColors.mainColor),
      side: WidgetStatePropertyAll(BorderSide(color: AppColors.mainColor)),
    ),
    confirmButtonStyle: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(AppColors.white),
      backgroundColor: WidgetStatePropertyAll(AppColors.mainColor),
    ),
  ),
);
