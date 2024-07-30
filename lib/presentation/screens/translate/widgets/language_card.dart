import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_svgs.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/presentation/screens/translate/model/language_data.dart';
import 'package:nfc_app/presentation/screens/translate/translate_screen.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({
    required this.data,
    this.isTranslating = false,
    super.key,
  });
  final LanguageData data;
  final bool isTranslating;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AllPadding.padding16,
      decoration: BoxDecoration(
        border: Border.all(color: sidebarColor),
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
              : Text(data.content),

          Padding(
            padding: YPadding.vertical16,
            child: const Divider(
              color: dividerColor,
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
