import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/presentation/widgets/app_bottom_nav.dart';
import 'package:nfc_app/presentation/widgets/app_buttons.dart';

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
                            'Spanish',
                            style: AppTextStyle.bodyText,
                          ),
                          trailing: SvgPicture.asset(
                              "assets/icons/svg/caret_down.svg"),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  // const YGap(
                  //   value: 20,
                  // ),

                  YGap(
                    value: MediaQuery.sizeOf(context).height * 0.5,
                  ),
                  PrimaryButton(
                    onTap: () {},
                    text: 'Save',
                    color: const Color(0xFFD3D3D3),
                    textColor: AppColors.secondaryTextColor,
                  )
                  // PrimaryButton(onTap: () {}, text: 'Save')
                ],
              ),
            ),
          ),
          // Positioned(
          //   top: MediaQuery.sizeOf(context).height * 0.1,
          //   left: 16.0,
          //   right: 16.0,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Container(
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(5),
          //           border: Border.all(
          //             color: const Color(0xFFF2F2F7),
          //             width: 1.0,
          //           ),
          //         ),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             ListTile(
          //               leading:
          //                   SvgPicture.asset("assets/icons/svg/search.svg"),
          //               title: Text(
          //                 'Search Language',
          //                 style: AppTextStyle.bodyText,
          //               ),
          //               onTap: () {},
          //             ),
          //           ],
          //         ),
          //       ),
          //       const YGap(
          //         value: 8,
          //       ),
          //       Container(
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(8),
          //           border: Border.all(
          //             color: const Color(0xFFF2F2F7),
          //             width: 1.0,
          //           ),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.black.withOpacity(0.25), // Shadow color
          //               offset: const Offset(0, 4), // Shadow offset
          //               blurRadius: 4, // Blur radius of the shadow
          //               spreadRadius: 0, // Spread radius of the shadow
          //             ),
          //           ],
          //         ),
          //         child: Column(children: [
          //           Container(
          //             color: const Color(0xFFF4F3F3),
          //             child: ListTile(
          //               title: Text(
          //                 'Spanish',
          //                 style: AppTextStyle.bodyText,
          //               ),
          //               onTap: () {},
          //             ),
          //           ),
          //           Container(
          //             color: Colors.white,
          //             child: ListTile(
          //               title: Text(
          //                 'English',
          //                 style: AppTextStyle.bodyText,
          //               ),
          //               onTap: () {},
          //             ),
          //           ),
          //           Container(
          //             color: Colors.white,
          //             child: ListTile(
          //               title: Text(
          //                 'Korean',
          //                 style: AppTextStyle.bodyText,
          //               ),
          //               onTap: () {},
          //             ),
          //           ),
          //           Container(
          //             color: Colors.white,
          //             child: ListTile(
          //               title: Text(
          //                 'German',
          //                 style: AppTextStyle.bodyText,
          //               ),
          //               onTap: () {},
          //             ),
          //           ),
          //           Container(
          //             color: Colors.white,
          //             child: ListTile(
          //               title: Text(
          //                 'French',
          //                 style: AppTextStyle.bodyText,
          //               ),
          //               onTap: () {},
          //             ),
          //           ),
          //           Container(
          //             color: Colors.white,
          //             child: ListTile(
          //               title: Text(
          //                 'Mandarin',
          //                 style: AppTextStyle.bodyText,
          //               ),
          //               onTap: () {},
          //             ),
          //           ),
          //           Container(
          //             color: Colors.white,
          //             child: ListTile(
          //               title: Text(
          //                 'Japanese',
          //                 style: AppTextStyle.bodyText,
          //               ),
          //               onTap: () {},
          //             ),
          //           ),
          //           Container(
          //             color: Colors.white,
          //             child: ListTile(
          //               title: Text(
          //                 'Portuguese',
          //                 style: AppTextStyle.bodyText,
          //               ),
          //               onTap: () {},
          //             ),
          //           ),
          //           Container(
          //             color: Colors.white,
          //             child: ListTile(
          //               title: Text(
          //                 'Igbo',
          //                 style: AppTextStyle.bodyText,
          //               ),
          //               onTap: () {},
          //             ),
          //           ),
          //           Container(
          //             color: Colors.white,
          //             child: ListTile(
          //               title: Text(
          //                 'Yoruba',
          //                 style: AppTextStyle.bodyText,
          //               ),
          //               onTap: () {},
          //             ),
          //           ),
          //           Container(
          //             color: Colors.white,
          //             child: ListTile(
          //               title: Text(
          //                 'Hausa',
          //                 style: AppTextStyle.bodyText,
          //               ),
          //               onTap: () {},
          //             ),
          //           ),
          //         ]),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
      bottomNavigationBar: const AppBottomNav(selectedindex: 2),
    );
  }
}
