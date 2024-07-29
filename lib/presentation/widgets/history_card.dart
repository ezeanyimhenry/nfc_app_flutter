import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_textstyles.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.28,
      width: MediaQuery.sizeOf(context).width,
      padding: AllPadding.padding16,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.miscellaneousTextColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Source Language - Spanish",
            style: AppTextStyle.heading3,
          ),
          const YGap(
            value: 24,
          ),
          Text(
            "\"Bienvenido al Museo de Historia. Siga las señales para iniciar su recorrido y descubra exposiciones fascinantes sobre nuestra herencia cultural.\"",
            style: AppTextStyle.bodyText,
          ),
          const YGap(
            value: 20,
          ),
          const Divider(
            color: AppColors.dividerColour,
          ),
          const YGap(
            value: 10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.asset("assets/icons/svg/arrow.svg"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "2 days ago",
                style: AppTextStyle.bodyText,
              ),
              Text(
                "Swipe left to delete",
                style: AppTextStyle.bodyText,
              )
            ],
          )
        ],
      ),
    );
  }
}
