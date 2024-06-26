import 'package:flutter/material.dart';
import 'package:storemaster/utils/const.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.whiteColor,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 520,
              padding: AppPadding.all(2),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient(),
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: const Icon3DFb4(),
            ),
            Expanded(
              child: Padding(
                padding: AppPadding.all(1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "START YOUR STORE",
                      style: AppTextStyle.quicksandBoldColor(
                          24, AppColors.primaryColor, FontWeight.w900),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Một ứng dụng quản lý cửa hàng và order dành cho cửa hàng của bạn",
                      style: AppTextStyle.quicksandRegularColor(
                        16,
                        AppColors.secondaryColor,
                        FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryColor,
        child: const Icon(
          Icons.arrow_forward,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}

class Icon3DFb4 extends StatelessWidget {
  const Icon3DFb4({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/3d%20icons%2Fbulb-dynamic-color.png?alt=media&token=6fe7b51a-7267-43cb-9810-76936fb121f5",
      fit: BoxFit.contain,
    );
  }
}
