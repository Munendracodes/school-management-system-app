import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle headingLarge = GoogleFonts.poppins(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static TextStyle headingMedium = GoogleFonts.poppins(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static TextStyle headingSmall = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static TextStyle bodyMedium = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textGrey,
  );

  static TextStyle bodySmall = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrey,
  );
}