import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_svgs.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/presentation/screens/translate/model/language_data.dart';
import 'package:nfc_app/presentation/screens/translate/model/translate_dto.dart';
import 'package:nfc_app/presentation/screens/translate/notifier/language_notifier.dart';
import 'package:nfc_app/presentation/screens/translate/widgets/language_card.dart';
import 'package:nfc_app/presentation/widgets/app_buttons.dart';
import 'package:nfc_app/presentation/widgets/select_language_sheet.dart';
import 'package:provider/provider.dart';

import '../history/logic/shared_preference.dart';
import '../history/models/history_model.dart';

class TranslateScreen extends StatefulWidget {
  final String message;
  const TranslateScreen({super.key, required this.message});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  void translateReadMessage() async {
    final languageNotifier = context.read<LanguageNotifier>();
    languageNotifier.translateMessage(
      TranslateDTO(
        message: widget.message,
        sourceLanguage: "",
        targetLanguage: languageNotifier.languageToBeTranslatedTo,
      ),
    );
    //save to history
    List<HistoryModel> loadedHistoryList =
        await AppSharedPreference().getHistoryList();
    loadedHistoryList.add(HistoryModel(
        language: languageNotifier.languageToBeTranslatedTo,
        date: DateTime.now(),
        actualText: widget.message,
        type: HistoryType.read));
    await AppSharedPreference().saveHistoryList(loadedHistoryList);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      translateReadMessage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageNotifier = context.watch<LanguageNotifier>();

    final screenHeight = MediaQuery.sizeOf(context).height;

    final isTranslating = languageNotifier.isTranslating;
    final translateResponse = languageNotifier.translateResponse;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Translate",
          style: AppTextStyle.heading3,
        ),
      ),
      body: SingleChildScrollView(
        padding: AllPadding.padding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LanguageCard(
              data: LanguageData(
                content: widget.message,
                type: LanguageType.source,
                name: translateResponse.detectedLanguage ?? "",
              ),
            ),
            const YGap(),
            LanguageCard(
              isTranslating: isTranslating,
              hasError: !translateResponse.isSuccessful,
              data: LanguageData(
                content: translateResponse.isSuccessful
                    ? (translateResponse.translatedMessage ?? "")
                    : (translateResponse.errorMessage ?? "Error occurred"),
                type: LanguageType.target,
                name: languageNotifier.languageToBeTranslatedTo,
              ),
            ),
            YGap(value: screenHeight * 0.16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Source Language:",
                  style: AppTextStyle.bodyTextSemiBold,
                ),
                Text(
                  translateResponse.detectedLanguage ?? "",
                  style: AppTextStyle.bodyTextSm.copyWith(
                    color: translateResponse.isSuccessful
                        ? null
                        : AppColors.failureColor,
                  ),
                )
              ],
            ),
            const YGap(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Target Language:",
                  style: AppTextStyle.bodyTextSemiBold,
                ),
                InkWell(
                  onTap: () {
                    showLanguageSelectionSheet(
                            context, languageNotifier.languageToBeTranslatedTo)
                        .then((selected) {
                      languageNotifier.setTargetLanguage(selected ??
                          languageNotifier.languageToBeTranslatedTo);
                      translateReadMessage();
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        languageNotifier.languageToBeTranslatedTo,
                        style: AppTextStyle.bodyTextSm,
                      ),
                      const XGap(value: 4),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.secondaryTextColor,
                      )
                    ],
                  ),
                )
              ],
            ),
            const YGap(value: 24),
            PrimaryButton(
              color: isTranslating ? Colors.grey : null,
              onTap: () {
                isTranslating ? () {} : translateReadMessage();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isTranslating ? "Translating..." : "Translate",
                    style: AppTextStyle.primaryButtonText,
                  ),
                  Visibility(
                    visible: isTranslating,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: SvgPicture.asset(AppSvgs.loader),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
