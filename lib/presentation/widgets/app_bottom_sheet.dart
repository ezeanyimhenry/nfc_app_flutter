import 'package:flutter/material.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/presentation/widgets/app_buttons.dart';

class AppBottomsheet extends StatelessWidget {
  final String message;
  final String title;
  final String primaryButtonText;
  final String secondaryButtonText;
  final bool hasCenterContent;
  final bool hasPrimaryButton;
  final bool hasSecondaryButton;
  final bool hasBothButton;
  final VoidCallback? primaryButtonOnTap;
  final VoidCallback? secondaryButtonOnTap;
  final Widget? centerContent;
  const AppBottomsheet({
    super.key,
    required this.message,
    required this.title,
    this.primaryButtonText = 'Allow',
    this.secondaryButtonText = 'Deny',
    this.primaryButtonOnTap,
    this.secondaryButtonOnTap,
    this.hasCenterContent = true,
    this.hasPrimaryButton = false,
    this.hasSecondaryButton = false,
    this.hasBothButton = false,
    this.centerContent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: hasCenterContent ? AllPadding.padding36 : AllPadding.padding24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyle.heading2,
          ),
          const YGap(value: 24),
          if (centerContent != null) ...[
            const YGap(value: 16),
            centerContent!,
          ],
          const YGap(value: 5),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyle.bodyText,
          ),
          const YGap(value: 16),
          if (hasBothButton)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (secondaryButtonOnTap != null)
                  SecondaryButton(
                      onTap: secondaryButtonOnTap!, text: secondaryButtonText),
                if (primaryButtonOnTap != null)
                  PrimaryButton(
                      onTap: primaryButtonOnTap!, text: primaryButtonText),
              ],
            )
          else if (hasPrimaryButton && primaryButtonOnTap != null)
            PrimaryButton(onTap: primaryButtonOnTap!, text: primaryButtonText)
          else if (hasSecondaryButton && secondaryButtonOnTap != null)
            SecondaryButton(
                onTap: secondaryButtonOnTap!, text: secondaryButtonText)
          else
            const SizedBox(
              width: double.infinity,
            )
        ],
      ),
    );
  }
}
