import 'package:flutter/material.dart';
import 'package:nfc_app/constants/app_colors.dart';

class AppThemeData {
  AppThemeData._();

  static final lightMode = ThemeData(
    colorScheme: const ColorScheme.light(
      surface: AppColors.backgroundColor2,
    ),
  );
}
