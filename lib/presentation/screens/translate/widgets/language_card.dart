import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_svgs.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/presentation/screens/translate/model/language_data.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({
    required this.data,
    this.hasError = false,
    this.isTranslating = false,
    super.key,
  });
  final LanguageData data;
  final bool isTranslating;
  final bool hasError;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AllPadding.padding16,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.miscellaneousTextColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${data.type.label} Language - ${data.name}",
            style: AppTextStyle.bodyTextSemiBold,
          ),
          const YGap(value: 24),
          isTranslating
              ? Center(
                  child: SvgPicture.asset(
                    AppSvgs.loader,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                )
              : SelectableText(
                  data.content,
                  cursorColor: AppColors.primaryColor,
                  style: TextStyle(
                    color: hasError ? AppColors.failureColor : null,
                  ),
                ),
          Padding(
            padding: YPadding.vertical16,
            child: const Divider(
              color: AppColors.dividerColour,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(AppSvgs.copy),
              ),
              const XGap(value: 8),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(AppSvgs.save),
              ),
              const XGap(value: 8),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(AppSvgs.upload),
              )
            ],
          )
        ],
      ),
    );
  }
}
