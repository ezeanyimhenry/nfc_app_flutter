import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_svgs.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/presentation/screens/history/logic/shared_preference.dart';
import 'package:nfc_app/presentation/screens/history/models/history_model.dart';
import 'package:nfc_app/presentation/screens/translate/model/language_data.dart';
import 'package:share_plus/share_plus.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({
    required this.data,
    this.hasError = false,
    this.forfoundText = false,
    this.isLoading = false,
    super.key,
  });
  final LanguageData data;
  final bool isLoading, forfoundText;
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
          isLoading
              ? Center(
                  child: SvgPicture.asset(
                    AppSvgs.loader,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                )
              : 
              SelectableText(
                  data.content.trim(),
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
            children: forfoundText
                ? [
                    InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: data.content))
                            .then(
                          (_) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Copied",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: AppColors.primaryColor,
                            ),
                          ),
                        );
                      },
                      child: SvgPicture.asset(AppSvgs.copy),
                    ),
                  ]
                : [
                    InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: data.content))
                            .then(
                          (_) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Copied",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: AppColors.primaryColor,
                            ),
                          ),
                        );
                      },
                      child: SvgPicture.asset(AppSvgs.copy),
                    ),
                    const XGap(value: 8),
                    InkWell(
                      onTap: () async {
                        List<HistoryModel> loadedHistoryList =
                            await AppSharedPreference().getHistoryList();
                        loadedHistoryList.add(HistoryModel(
                            language: data.name,
                            date: DateTime.now(),
                            actualText: data.content,
                            type: HistoryType.read));
                         AppSharedPreference()
                            .saveHistoryList(loadedHistoryList) .then(
                          (_) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Saved",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: AppColors.primaryColor,
                            ),
                          ),
                        );
                      },
                      child: SvgPicture.asset(AppSvgs.save),
                    ),
                    const XGap(value: 8),
                    InkWell(
                      onTap: () =>Share.share(data.content),
                      child: SvgPicture.asset(AppSvgs.upload),
                    )
                  ],
          )
        ],
      ),
    );
  }
}
