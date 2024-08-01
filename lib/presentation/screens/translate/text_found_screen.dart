import 'package:flutter/material.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/presentation/screens/translate/model/language_data.dart';
import 'package:nfc_app/presentation/screens/translate/notifier/language_notifier.dart';
import 'package:nfc_app/presentation/screens/translate/translate_screen.dart';
import 'package:nfc_app/presentation/screens/translate/widgets/language_card.dart';
import 'package:nfc_app/presentation/widgets/app_buttons.dart';
import 'package:nfc_app/presentation/widgets/select_language_sheet.dart';
import 'package:provider/provider.dart';

class TextFoundScreen extends StatefulWidget {
  const TextFoundScreen({
    required this.foundText,
    super.key,
  });
  final String foundText;

  @override
  State<TextFoundScreen> createState() => _TextFoundScreenState();
}

class _TextFoundScreenState extends State<TextFoundScreen> {
  void detectLanguage() {
    final languageNotifier = context.read<LanguageNotifier>();
    languageNotifier.detectLanguage(widget.foundText);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      detectLanguage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final languageNotifier = context.watch<LanguageNotifier>();
    final detectResponse = languageNotifier.detectResponse;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Text Found",
          style: AppTextStyle.heading3,
        ),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: AllPadding.padding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Review your scanned text below.",
              style: AppTextStyle.bodyText,
            ),
            const YGap(),
            LanguageCard(
              forfoundText: true,
              data: LanguageData(
                content: widget.foundText,
                type: LanguageType.source,
                name: languageNotifier.isDetecting
                    ? "..."
                    : detectResponse.detectedLanguage ?? "",
              ),
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
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.miscellaneousTextColor),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Text(
                          languageNotifier.languageToBeTranslatedTo,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.bodyTextSm,
                        ),
                        const XGap(),
                        const Icon(
                          Icons.arrow_drop_down,
                          size: 16,
                          color: AppColors.secondaryTextColor,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            YGap(value: screenHeight * 0.12),
            PrimaryButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TranslateScreen(
                      message: widget.foundText,
                    ),
                  ),
                );
              },
              text: "Confirm",
            ),
            YGap(),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                fixedSize: Size(double.maxFinite, 44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(width: 1, color: AppColors.primaryColor),
              ),
              child: Text(
                'Rescan',
                style: AppTextStyle.secondaryButtonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
