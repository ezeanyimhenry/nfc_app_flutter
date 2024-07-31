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
  static final alertDialogBodyTextSm = GoogleFonts.inter(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14.0,
      color: AppColors.miscellaneousTextColor2,
    ),
  );
  static final paragraphText = GoogleFonts.inter(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
      color: Colors.black,
    ),
  );
  static final susscessHeading1 = GoogleFonts.inter(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20.0,
      color: AppColors.primaryColor,
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
  static final heading3 = GoogleFonts.inter(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20.0,
      color: AppColors.primaryTextColor,
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
  static final welcomeScreenHeading = GoogleFonts.lilitaOne(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20.0,
      color: AppColors.primaryTextColor,
    ),
  );
  static final alertDialogHeading = GoogleFonts.inter(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20.0,
      color: AppColors.primaryTextColor,
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
