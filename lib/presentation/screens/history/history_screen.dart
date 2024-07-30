import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/constants/app_colors.dart';

import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/presentation/widgets/history_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const SizedBox(),
        actions: [
          Padding(
            padding: XPadding.horizontal24,
            child: Text(
              "Clear All",
              style: AppTextStyle.smallBodyTextInactive,
            ),
          ),
        ],
        title: Text(
          "History",
          style: AppTextStyle.heading2,
        ),
      ),
      body: Padding(
        padding: XPadding.horizontal16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const YGap(
              value: 24,
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.05,
              padding: AllPadding.padding8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xffCBD5E1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/svg/search.svg"),
                      const XGap(
                        value: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              label: Text(
                                "Search",
                                style: AppTextStyle.bodyText,
                              )),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset("assets/icons/svg/filter.svg")),
                ],
              ),
            ),
            YGap(
              value: MediaQuery.sizeOf(context).height * 0.024,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Your History',
                    style: AppTextStyle.secondaryButtonText,
                  ),
                  TextSpan(
                    text: ' (6)',
                    style: AppTextStyle.bodyTextSm,
                  ),
                ])),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Sort by:',
                    style: AppTextStyle.smallBodyTextInactive,
                  ),
                  TextSpan(
                    text: ' All',
                    style: AppTextStyle.bodyTextSm,
                  ),
                ]))
              ],
            ),
            YGap(
              value: MediaQuery.sizeOf(context).height * 0.016,
            ),
            Expanded(
                child: ListView.separated(
              itemCount: fruits.length,
              itemBuilder: (ctx, index) {
                return Dismissible(
                    key: Key(
                      fruits[index],
                    ),
                    onDismissed: (direction) {
                      // Perform delete action here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Item deleted')),
                      );
                    },
                    confirmDismiss: (direction) async {
                      return await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              // titleTextStyle: AppTextStyle.alertDialogHeading,
                              contentPadding: AllPadding.padding16,
                              title: Container(
                                width: double.infinity,
                                child: Stack(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Are you sure?",
                                        style: AppTextStyle.alertDialogHeading,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () =>
                                            Navigator.of(context).pop(false),
                                        child: SvgPicture.asset(
                                            "assets/icons/svg/cancel.svg"),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              content: Text(
                                "This will delete this record permanently. You cannot undo this action.",
                                style: AppTextStyle.alertDialogBodyTextSm,
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                GestureDetector(
                                  onTap: () {
                                    fruits.remove(fruits[index]);
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Container(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: BoxDecoration(
                                        color: AppColors.alertDialogColor,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Center(
                                      child: Text(
                                        "Delete",
                                        style: AppTextStyle.primaryButtonText,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          });
                    },
                    direction: DismissDirection.endToStart,
                    background: Container(
                      height: MediaQuery.sizeOf(context).height * 0.28,
                      width: MediaQuery.sizeOf(context).width * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child:
                              SvgPicture.asset("assets/icons/svg/delete.svg")),
                    ),
                    child: const HistoryCard());
              },
              separatorBuilder: (BuildContext context, int index) => const YGap(
                value: 24,
              ),
            ))
          ],
        ),
      ),
    );
  }
}

List<String> fruits = [
  'Apple',
  'Banana',
  'Cherry',
  'Date',
  'Elderberry',
  'Fig',
  'Grape',
  'Honeydew',
  'Kiwi',
  'Lemon'
];
