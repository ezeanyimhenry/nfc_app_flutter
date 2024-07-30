import 'package:flutter/material.dart';

class ProgressIndicatorWithText extends StatefulWidget {
  final double progress; // Value between 0.0 and 1.0 (0 to 100%)

  const ProgressIndicatorWithText({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  _ProgressIndicatorWithTextState createState() =>
      _ProgressIndicatorWithTextState();
}

class _ProgressIndicatorWithTextState extends State<ProgressIndicatorWithText> {
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
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              backgroundColor: Color(0xFFF0F2F5),
            ),
          ),
          Text(
            '${(_progress * 100).toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
