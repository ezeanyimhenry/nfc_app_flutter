import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/presentation/screens/translate/model/language_data.dart';
import 'package:nfc_app/presentation/screens/translate/widgets/language_card.dart';
import 'package:nfc_app/presentation/screens/translate/widgets/select_language_sheet.dart';
import 'package:nfc_app/presentation/widgets/app_bottom_sheet.dart';
import 'package:nfc_app/presentation/widgets/app_buttons.dart';

class TranslateScreen extends StatefulWidget {
  final String message;
  const TranslateScreen({super.key, required this.message});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
  bool isResultVisible = false;
  String generatedResult = '';
  String theDetectedLanguage = '';
  String? _selectedLanguage = "English";
  // String selectedLanguage = "Select";

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
      });
    } catch (e) {
      setState(() {
        generatedResult = 'Sorry, I am not trained enough to translate this';
        theDetectedLanguage = '';
        // print(generatedResult);
        isResultVisible = true;
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
    return Scaffold(
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
              data: LanguageData(
                content: generatedResult,
                type: LanguageType.target,
                name: _selectedLanguage ?? "English",
              ),
            ),
            const YGap(value: 24),
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
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const AppBottomsheet(
                            message: "",
                            title: "Select Target Language",
                            centerContent: SelectTargetLanguageSheet(),
                          );
                        }).then((selected) {
                      setState(() {
                        _selectedLanguage = selected;
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
            const YGap(value: 32),
            PrimaryButton(
              onTap: () {
                translateContent(widget.message);
              },
              text: "Translate",
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
