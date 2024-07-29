import 'package:flutter/material.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_textstyles.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.width,
    this.height,
    this.color,
    this.textColor,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: color ?? AppColors.primaryColor,
        minimumSize: Size(
          width ?? double.infinity,
          height ?? 48,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: AppTextStyle.primaryButtonText,
      ),
    );
  }
}

// Secondary Button
class SecondaryButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  const SecondaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.width,
    this.height,
    this.color,
    this.textColor,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: color ?? AppColors.backgroundColor,
        minimumSize: Size(
          width ?? double.infinity,
          height ?? 48,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: const BorderSide(width: 1, color: AppColors.secondaryColor),
      ),
      child: Text(
        text,
        style: AppTextStyle.secondaryButtonText,
      ),
    );
  }
}

// Inactive Button
class InactiveButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  const InactiveButton({
    super.key,
    required this.onTap,
    required this.text,
    this.width,
    this.height,
    this.color,
    this.textColor,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: color ?? AppColors.inactiveColor,
        minimumSize: Size(
          width ?? double.infinity,
          height ?? 48,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: AppTextStyle.inactiveButtonText,
      ),
    );
  }
}
