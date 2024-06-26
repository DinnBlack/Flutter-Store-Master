import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storemaster/screens/main/main_screen.dart';
import 'package:storemaster/utils/const.dart';
import 'package:storemaster/widgets/customs/cusstom_textfield.dart';
import 'package:storemaster/widgets/customs/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.whiteColor,
        child: Column(
          children: [
            Expanded(child: Container()),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Đăng nhập",
                      style: AppTextStyle.quicksandBold(36),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Chào mừng bạn trở lại!",
                      style: AppTextStyle.quicksandRegular(18),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  CustomAppTextField(
                    controller: TextEditingController(),
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomAppTextField(
                    controller: TextEditingController(),
                    hintText: 'Mật khẩu',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 48,
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
                          type: PageTransitionType.fade,
                          child: const MainScreen(),
                        ),
                      );
                    },
                    text: 'Đăng nhập',
                    backgroundColor: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    child: Text(
                      "Tôi chưa có tài khoản",
                      style: AppTextStyle.quicksandRegular(18),
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
