import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF2445EF);
  static const Color textColor = Color(0xFF202020);
  static const Color backGroundButtonColor = Color(0xFFF8F8F8);
  static const Color backGroundColor = Color(0xFFEAEBEC);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color accentColor = Color(0xFFFEB052);
  static const Color secondaryColor = Color(0xFF373234);
  static const Color tertiaryColor = Color(0xFFC8D7D2);
  static LinearGradient primaryGradient() {
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [primaryColor, whiteColor],
    );
  }
}

class AppPadding {
  static const double basePadding = 12.0;

  static EdgeInsets all(double multiplier) {
    return EdgeInsets.all(basePadding * multiplier);
  }

  static EdgeInsets symmetric(
      {double vertical = 1.0, double horizontal = 1.0}) {
    return EdgeInsets.symmetric(
      vertical: basePadding * vertical,
      horizontal: basePadding * horizontal,
    );
  }

  static EdgeInsets only(
      {double top = 0, double bottom = 0, double left = 0, double right = 0}) {
    return EdgeInsets.only(
      top: basePadding * top,
      bottom: basePadding * bottom,
      left: basePadding * left,
      right: basePadding * right,
    );
  }
}

class AppTextStyle {
  static TextStyle quicksandBold(double size) {
    return TextStyle(
      // fontFamily: 'QuicksandBold',
      fontWeight: FontWeight.bold,
      fontSize: size.sp,
    );
  }

  static TextStyle quicksandRegular(double size) {
    return TextStyle(
      // fontFamily: 'QuicksandRegular',
      fontWeight: FontWeight.normal,
      fontSize: size.sp,
    );
  }

  static TextStyle quicksandBoldColor(
      double size, Color color, FontWeight fontWeight) {
    return TextStyle(
      // fontFamily: 'QuicksandBold',
      fontWeight: fontWeight,
      fontSize: size.sp,
      color: color,
    );
  }

  static TextStyle quicksandRegularColor(
      double size, Color color, FontWeight fontWeight) {
    return TextStyle(
      // fontFamily: 'QuicksandRegular',
      fontWeight: fontWeight,
      fontSize: size.sp,
      color: color,
    );
  }
}
