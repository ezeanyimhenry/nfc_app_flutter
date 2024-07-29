import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_textstyles.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
                      SvgPicture.asset("assets/svg/icons/search.svg"),
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
                  SvgPicture.asset("assets/svg/icons/filter.svg"),
                ],
              ),
            ),
            YGap(
              value: MediaQuery.sizeOf(context).height * 0.13,
            ),
            SvgPicture.asset("assets/svg/icons/no_history.svg"),
            const YGap(
              value: 18,
            ),
            Text(
              "No History",
              style: AppTextStyle.heading2,
            ),
            const YGap(
              value: 4,
            ),
            Text(
              "Your Scan history will be appeared here",
              style: AppTextStyle.bodyTextSemiBold,
            )
          ],
        ),
      ),
    );
  }
}
