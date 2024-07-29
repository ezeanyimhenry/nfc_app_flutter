import 'package:flutter/material.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/presentation/screens/translate/model/language_data.dart';
import 'package:nfc_app/presentation/screens/translate/widgets/language_card.dart';
import 'package:nfc_app/presentation/screens/translate/widgets/select_language_sheet.dart';
import 'package:nfc_app/presentation/widgets/app_bottom_sheet.dart';
import 'package:nfc_app/presentation/widgets/app_buttons.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  String selectedLanguage = "Select";
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
            const LanguageCard(
              data: LanguageData(
                content:
                    "Bienvenido al Museo de Historia. Siga las señales para iniciar su recorrido y descubra exposiciones fascinantes sobre nuestra herencia cultural.",
                type: LanguageType.source,
                name: "Spanish",
              ),
            ),
            const YGap(),
            const LanguageCard(
              data: LanguageData(
                content:
                    "Welcome to the History Museum. Follow the signs to start your tour and discover fascinating exhibits about our cultural heritage.",
                type: LanguageType.target,
                name: "English",
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
                const Text(
                  "Spanish",
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
                        selectedLanguage = selected;
                      });
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        selectedLanguage,
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
              onTap: () {},
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
