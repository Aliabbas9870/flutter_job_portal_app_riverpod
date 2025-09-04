import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job/core/app_color.dart';



class AppTheme {
  static ThemeData light = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: GoogleFonts.robotoTextTheme().apply(
      bodyColor: AppColors.textDark,
      displayColor: AppColors.textDark,
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.accent,
      background: AppColors.background,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      titleTextStyle: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );
}
