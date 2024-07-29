import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_app/constants/app_colors.dart';

class AppTextStyle {
  AppTextStyle._();

  //nav active and inactive
  static final smallBodyTextActive = GoogleFonts.inter(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12.0,
      color: AppColors.primaryColor,
    ),
  );
  static final smallBodyTextInactive = GoogleFonts.inter(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12.0,
      color: AppColors.secondaryTextColor,
    ),
  );

  // Normal text
  static final bodyText = GoogleFonts.inter(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      color: AppColors.primaryTextColor,
    ),
  );
  static final bodyTextSemiBold = GoogleFonts.inter(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
      color: AppColors.semiBoldTextColor,
    ),
  );
  static final bodyTextSm = GoogleFonts.inter(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      color: AppColors.primaryTextColor,
    ),
  );
  //heading text(Bottombar)
  static final heading2 = GoogleFonts.inter(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20.0,
      color: AppColors.secondaryTextColor,
    ),
  );
  static final primaryButtonText = GoogleFonts.inter(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      color: AppColors.backgroundColor,
    ),
  );
  static final secondaryButtonText = GoogleFonts.inter(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      color: AppColors.primaryColor,
    ),
  );
  static final inactiveButtonText = GoogleFonts.inter(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      color: AppColors.secondaryTextColor,
    ),
  );
}
