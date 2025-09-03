import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job/core/app_color.dart';



class AppTheme {
  static ThemeData light = ThemeData(
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    textTheme: GoogleFonts.robotoTextTheme().apply(
      bodyColor: AppColors.textDark,
      displayColor: AppColors.textDark,
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryBlue,
      secondary: AppColors.secondaryTeal,
      tertiary: AppColors.accentAmber,
      background: AppColors.backgroundLight,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryBlue,
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
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );
}
