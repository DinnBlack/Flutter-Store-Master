import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storemaster/screens/login/start_screen.dart';
import 'package:storemaster/utils/const.dart';

class SplashScreen extends StatefulWidget {
  final String splash;
  final Widget nextScreen;
  const SplashScreen(
      {super.key, required this.splash, required this.nextScreen});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: LottieBuilder.asset(
          widget.splash,
        ),
      ),
      nextScreen: widget.nextScreen,
      backgroundColor: AppColors.whiteColor,
      duration: 3000,
      pageTransitionType: PageTransitionType.fade,
      splashIconSize: 240.sp,
    );
  }
}
