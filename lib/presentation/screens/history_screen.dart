import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
                  SvgPicture.asset("assets/icons/svg/filter.svg"),
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
              itemCount: 10,
              itemBuilder: (ctx, index) {
                return Dismissible(
                    key: Key(
                      index.toString(),
                    ),
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
