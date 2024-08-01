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
import 'package:share/share.dart';

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

  // Method to copy text to clipboard
  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: data.content)).then((_) {
      // Show a snackbar to confirm the copy action
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Copied to clipboard'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  // Method to share text
  void _shareText(BuildContext context) {
    Share.share(data.content, subject: 'Shared content from Translate Buddy');
  }

  Future<void> _saveToHistory(BuildContext context) async {
    try {
      // Fetch existing history list
      List<HistoryModel> loadedHistoryList =
          await AppSharedPreference().getHistoryList();

      // Validate data before adding to the history list
      // final String label = data.type.label ?? 'Unknown';
      final String language = data.name;
      final String content = data.content;

      // Add new history entry
      loadedHistoryList.add(HistoryModel(
        label: LanguageType.source,
        language: language,
        date: DateTime.now(),
        actualText: content,
        type: HistoryType.read,
      ));

      // Save updated history list
      await AppSharedPreference().saveHistoryList(loadedHistoryList);

      // Optionally show a message to indicate success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved to history!')),
      );
    } catch (e) {
      // Optionally show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save to history')),
      );
    }
  }

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
                onTap: () {
                  _copyToClipboard(context);
                },
                child: SvgPicture.asset(AppSvgs.copy),
              ),
              const XGap(value: 8),
              InkWell(
                onTap: () {
                  _saveToHistory(context);
                },
                child: SvgPicture.asset(AppSvgs.save),
              ),
              const XGap(value: 8),
              InkWell(
                onTap: () {
                  _shareText(context);
                },
                child: SvgPicture.asset(AppSvgs.upload),
              )
            ],
          )
        ],
      ),
    );
  }
}
