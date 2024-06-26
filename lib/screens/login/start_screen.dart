import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storemaster/screens/login/login_screen.dart';
import 'package:storemaster/screens/login/sign_up_screen.dart';
import 'package:storemaster/utils/const.dart';
import 'package:storemaster/widgets/customs/custom_button.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.fill,
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "StoreMaster",
                      style: AppTextStyle.quicksandBold(36),
                    ),
                    Container(
                      width: 300,
                      alignment: Alignment.center,
                      child: Text(
                        "Môt công cụ quản lý cửa hàng dành cho bạn",
                        style: AppTextStyle.quicksandRegular(18),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  CustomAppButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const SignUpScreen(),
                        ),
                      );
                    },
                    text: 'Bắt đầu',
                    backgroundColor: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const LoginScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Bạn đã có tài khoản",
                          style: AppTextStyle.quicksandRegular(18),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_sharp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
