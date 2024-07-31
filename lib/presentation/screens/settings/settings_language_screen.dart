import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/presentation/widgets/app_bottom_nav.dart';
import 'package:nfc_app/presentation/widgets/app_buttons.dart';
import 'package:nfc_app/presentation/widgets/select_language_sheet.dart';

class SettingsLanguagecreen extends StatefulWidget {
  const SettingsLanguagecreen({super.key});

  @override
  State<SettingsLanguagecreen> createState() => _SettingsLanguagecreenState();
}

class _SettingsLanguagecreenState extends State<SettingsLanguagecreen> {
  String _selectedLanguage = 'Spanish';
  bool _languageSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset("assets/icons/svg/arrow_left.svg")),
        ),
        leadingWidth: 40,
        title: Text(
          "Set Target Language",
          style: AppTextStyle.heading2,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: XPadding.horizontal16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const YGap(
                    value: 24,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: const Color(0xFFF2F2F7),
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            _selectedLanguage,
                            style: AppTextStyle.bodyText,
                          ),
                          trailing: SvgPicture.asset(
                              "assets/icons/svg/caret_down.svg"),
                          onTap: () {
                            showLanguageSelectionSheet(
                                    context, _selectedLanguage)
                                .then((selected) {
                              if (selected != null) {
                                setState(() {
                                  _selectedLanguage = selected;
                                  _languageSelected = true;
                                });
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  YGap(
                    value: MediaQuery.sizeOf(context).height * 0.5,
                  ),
                  if (_languageSelected)
                    PrimaryButton(
                      onTap: () {},
                      text: 'Save',
                    )
                  else
                    InactiveButton(
                      onTap: () {},
                      text: 'Save',
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(selectedindex: 2),
    );
  }
}
