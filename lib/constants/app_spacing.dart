import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
/// h mean hieght and w means width
class XPadding {
  static EdgeInsets horizontal24 = const EdgeInsets.symmetric(horizontal: 24.0);
  static EdgeInsets horizontal45 = const EdgeInsets.symmetric(horizontal: 45.0);
  static EdgeInsets horizontal16 = const EdgeInsets.symmetric(horizontal: 16.0);
}

class YPadding {
  static EdgeInsets vertical24 = const EdgeInsets.symmetric(vertical: 24.0);
  static EdgeInsets vertical45 = const EdgeInsets.symmetric(vertical: 45.0);
  static EdgeInsets vertical16 = const EdgeInsets.symmetric(vertical: 16.0);
}


class AllPadding{
  static EdgeInsets padding24 = const EdgeInsets.all(24.0);
  static EdgeInsets padding16 = const EdgeInsets.all(16.0);
  static EdgeInsets padding36 = const EdgeInsets.all(36.0);
  static EdgeInsets padding8 = const EdgeInsets.all(8.0);
}
//Gap for the width
class XGap extends StatelessWidget {
  const XGap({super.key, this.value = 16});
  final double value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: value,
    );
  }
}
//Gap for the height
class YGap extends StatelessWidget {
  const YGap({super.key, this.value = 16});
  final double value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: value ,
    );
  }
}