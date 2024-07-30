import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_svgs.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/presentation/screens/translate/model/language_data.dart';
import 'package:nfc_app/presentation/screens/translate/widgets/language_card.dart';
import 'package:nfc_app/presentation/widgets/app_buttons.dart';
import 'package:nfc_app/presentation/widgets/select_language_sheet.dart';

class TranslateScreen extends StatefulWidget {
  final String message;
  const TranslateScreen({super.key, required this.message});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  bool isTranslating = false;
  bool isResultVisible = false;
  String generatedResult = '';
  String theDetectedLanguage = '';
  String? _selectedLanguage = "English";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      translateContent(widget.message);
    });
  }

  Future<void> translateContent(String input) async {
    try {
      if (apiKey.isEmpty) {
        // print('No \$API_KEY environment variable');
      }
      setState(() {
        isTranslating = true;
      });
      // The Gemini 1.5 models are versatile and work with both text-only and multimodal prompts
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final content1 = [
        Content.text(
            'Translate simply to general $_selectedLanguage language, no unneccessary comments, just the translated result: ${widget.message}'),
      ];
      final content2 = [
        Content.text(
            'Detect and display only the language of this text, no unneccessary comments, just the detected language name: ${widget.message}'),
      ];
      final response1 = await model.generateContent(content1);
      final response2 = await model.generateContent(content2);

      setState(() {
        generatedResult = response1.text ?? 'No response received';
        theDetectedLanguage = response2.text ?? 'No response recieved';
        isResultVisible = true;
        isTranslating = false;
      });
    } catch (e) {
      setState(() {
        generatedResult = 'Sorry, I am not trained enough to translate this';
        theDetectedLanguage = '';
        // print(generatedResult);
        isResultVisible = true;
        isTranslating = false;
      });
    }
  }

  // showDetectedLanguage() {
  //   setState(() {
  //     DetectLanguage(
  //         content: (textEditingController.text.isNotEmpty)
  //             ? textEditingController.text
  //             : "I am a boy");
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Translate",
          style: header2Bold,
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
                name: theDetectedLanguage,
              ),
            ),
            const YGap(),
            LanguageCard(
              isTranslating: isTranslating,
              data: LanguageData(
                content:  generatedResult,
                type: LanguageType.target,
                name: _selectedLanguage ?? "English",
              ),
            ),
            YGap(value: screenHeight * 0.16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Source Language:",
                  style: AppTextStyle.bodyTextSemiBold,
                ),
                Text(
                  theDetectedLanguage,
                  style: regularBody,
                )
              ],
            ),
            const YGap(value: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Target Language:",
                  style: AppTextStyle.bodyTextSemiBold,
                ),
                InkWell(
                  onTap: () {
                    showLanguageSelectionSheet(context).then((selected) {
                      setState(() {
                        _selectedLanguage = selected;
                        translateContent(widget.message);
                      });
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        _selectedLanguage ?? "English",
                        style: regularBody,
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
            PrimaryButton(color: isTranslating?Colors.grey:null,
              onTap:  () {
                     isTranslating
                  ?(){}: translateContent(widget.message);
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

//To be added to the style guide
const header2Bold = TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
const regularBody = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryTextColor);
const dividerColor = Color(0xFFD9D9D9);
const sidebarColor = Color(0xFFF2F2F7);
