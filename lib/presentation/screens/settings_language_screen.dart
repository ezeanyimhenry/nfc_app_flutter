import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_textstyles.dart';

class SettingsLanguagecreen extends StatelessWidget {
  const SettingsLanguagecreen({super.key});

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
      body: Padding(
        padding: XPadding.horizontal16,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                    'Spanish',
                    style: AppTextStyle.bodyText,
                  ),
                  trailing: SvgPicture.asset("assets/icons/svg/caret_down.svg"),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const YGap(
            value: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      leading: SvgPicture.asset("assets/icons/svg/search.svg"),
                      title: Text(
                        'Search Language',
                        style: AppTextStyle.bodyText,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: XPadding.horizontal16,
                child: Column(children: [
                  const YGap(
                    value: 20,
                  ),
                  Text(
                    'Spanish',
                    style: AppTextStyle.bodyText,
                  ),
                  const YGap(
                    value: 20,
                  ),
                  Text(
                    'English',
                    style: AppTextStyle.bodyText,
                  ),
                  const YGap(
                    value: 20,
                  ),
                  Text(
                    'Korean',
                    style: AppTextStyle.bodyText,
                  ),
                ]),
              ),
            ],
          ),
          const YGap(
            value: 24,
          ),
        ]),
      ),
    );
  }
}
