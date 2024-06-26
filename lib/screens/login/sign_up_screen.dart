import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storemaster/screens/login/login_screen.dart';
import 'package:storemaster/utils/const.dart';
import 'package:storemaster/widgets/customs/cusstom_textfield.dart';
import 'package:storemaster/widgets/customs/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                      "Tạo tài khoản",
                      style: AppTextStyle.quicksandBold(36),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Chào mừng bạn đến với chúng tôi!",
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
                  const SizedBox(
                    height: 12,
                  ),
                  CustomAppTextField(
                    controller: TextEditingController(),
                    hintText: 'Số điện thoại',
                  )
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
                          type: PageTransitionType.rightToLeft,
                          child: const LoginScreen(),
                        ),
                      );
                    },
                    text: 'Đăng ký',
                    backgroundColor: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Tôi đã có tài khoản",
                        style: AppTextStyle.quicksandRegular(18),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
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
