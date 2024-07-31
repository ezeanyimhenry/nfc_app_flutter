import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/presentation/screens/settings/privacy_policy.dart';
import 'package:nfc_app/presentation/screens/settings/settings_language_screen.dart';
import 'package:nfc_app/presentation/screens/translate/translate_screen.dart';
import 'package:nfc_app/presentation/widgets/app_buttons.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const SizedBox(),
        title: Text(
          "Settings",
          style: AppTextStyle.heading2,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: XPadding.horizontal16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const YGap(
                value: 24,
              ),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/svg/language.svg"),
                  const XGap(
                    value: 8,
                  ),
                  Text(
                    'Preferred Languages',
                    style: AppTextStyle.bodyTextSemiBold,
                  )
                ],
              ),
              const YGap(
                value: 16,
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFF2F2F7),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        'Target Language',
                        style: AppTextStyle.bodyTextSm,
                      ),
                      trailing:
                          SvgPicture.asset("assets/icons/svg/caret_right.svg"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SettingsLanguagecreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const YGap(
                value: 24,
              ),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/svg/help.svg"),
                  const XGap(
                    value: 8,
                  ),
                  Text(
                    'Support',
                    style: AppTextStyle.bodyTextSemiBold,
                  )
                ],
              ),
              const YGap(
                value: 16,
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFF2F2F7),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        'Help Center',
                        style: AppTextStyle.bodyTextSm,
                      ),
                      trailing:
                          SvgPicture.asset("assets/icons/svg/caret_right.svg"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TranslateScreen(message: "I am a boy")),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Contact Us',
                        style: AppTextStyle.bodyTextSm,
                      ),
                      trailing:
                          SvgPicture.asset("assets/icons/svg/caret_right.svg"),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        'FAQs',
                        style: AppTextStyle.bodyTextSm,
                      ),
                      trailing:
                          SvgPicture.asset("assets/icons/svg/caret_right.svg"),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const YGap(
                value: 24,
              ),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/svg/more.svg"),
                  const XGap(
                    value: 8,
                  ),
                  Text(
                    'More',
                    style: AppTextStyle.bodyTextSemiBold,
                  )
                ],
              ),
              const YGap(
                value: 16,
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFF2F2F7),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        'Terms of Use',
                        style: AppTextStyle.bodyTextSm,
                      ),
                      trailing:
                          SvgPicture.asset("assets/icons/svg/caret_right.svg"),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        'Privacy Policy',
                        style: AppTextStyle.bodyTextSm,
                      ),
                      trailing:
                          SvgPicture.asset("assets/icons/svg/caret_right.svg"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PrivacyPolicyScreen()),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Rate Us',
                        style: AppTextStyle.bodyTextSm,
                      ),
                      trailing:
                          SvgPicture.asset("assets/icons/svg/caret_right.svg"),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const YGap(
                value: 24,
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFF2F2F7),
                      width: 1.0,
                    ),
                  ),
                ),
                child: PrimaryButton(onTap: () {}, text: 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
