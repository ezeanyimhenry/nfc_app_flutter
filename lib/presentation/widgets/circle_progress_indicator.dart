import 'package:flutter/material.dart';
import 'package:nfc_app/constants/app_textstyles.dart';

class ProgressIndicatorWithText extends StatefulWidget {
  final double progress; // Value between 0.0 and 1.0 (0 to 100%)

  const ProgressIndicatorWithText({
    super.key,
    required this.progress,
  });

  @override
  ProgressIndicatorWithTextState createState() =>
      ProgressIndicatorWithTextState();
}

class ProgressIndicatorWithTextState extends State<ProgressIndicatorWithText> {
  double _progress = 0.5;

  void updateProgress(double progress) {
    setState(() {
      _progress = progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 90.0,
            height: 90.0,
            child: CircularProgressIndicator(
              value: _progress,
              strokeWidth: 10.0,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              backgroundColor: const Color(0xFFF0F2F5),
            ),
          ),
          Text(
            '${(_progress * 100).toStringAsFixed(0)}%',
            style: AppTextStyle.paragraphText,
          ),
        ],
      ),
    );
  }
}
