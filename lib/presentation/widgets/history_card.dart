import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/presentation/screens/history/models/history_model.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_textstyles.dart';
import 'package:timeago/timeago.dart' as timeago;

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key, this.historyModel});
  final HistoryModel? historyModel;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            "Source Language - ${historyModel!.language}",
            style: AppTextStyle.bodyTextSemiBold,
          ),
          const YGap(
            value: 24,
          ),
          Text(
            "\"${historyModel!.actualText}\"",
            style: AppTextStyle.bodyTextSm,
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
                timeago.format(historyModel!.date),
                style: AppTextStyle.bodyTextSm,
              ),
              Text(
                "Swipe left to delete",
                style: AppTextStyle.bodyTextSm,
              )
            ],
          )
        ],
      ),
    );
  }
}
