import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storemaster/screens/main/main_screen.dart';
import 'package:storemaster/screens/splash/splash_screen.dart';
import 'package:storemaster/services/user_service.dart';
import 'package:storemaster/utils/const.dart';
import 'package:storemaster/widgets/customs/cusstom_textfield.dart';
import 'package:storemaster/widgets/customs/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController controller = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.whiteColor,
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          children: [
            Expanded(child: Container()),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Đăng nhập",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Chào mừng bạn trở lại!",
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(
              height: 40.sp,
            ),
            _textFieldCustom(
              controller: controller,
              icon: Icons.phone_outlined,
              text: "Số điện thoại",
            ),
            SizedBox(
              height: 20.sp,
            ),
            _buttonCustom(),
            SizedBox(
              height: 10.sp,
            ),
            const Row(
              children: <Widget>[
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "hoặc",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.sp,
            ),
            _buttonGoogleCustom(),
            SizedBox(
              height: 20.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tôi chưa có tài khoản",
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(
                  width: 20.sp,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(10.sp),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(4.sp),
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
            SizedBox(
              height: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}

class _buttonCustom extends StatelessWidget {
  const _buttonCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const MainScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.sp),
        ),
        minimumSize: Size(double.infinity, 48.sp),
      ),
      child: Text(
        'Xác thực số điện thoại',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _buttonGoogleCustom extends StatelessWidget {
  const _buttonGoogleCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        User? user = await UserService().signInWithGoogle();
        if (user != null) {
          print('Đăng nhập thành công: ${user.displayName}');
        } else {
          print('Đăng nhập thất bại');
        }
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: const SplashScreen(
                splash: 'assets/lottie/Animation - 1721316132550.json',
                nextScreen: MainScreen(),
              )),
        );
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(
          color: Colors.grey[300]!,
          width: 1.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.sp),
        ),
        minimumSize: Size(double.infinity, 48.sp),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/logoGoogle.png',
            height: 24.sp,
            width: 24.sp,
          ),
          SizedBox(width: 10.sp),
          Text(
            'Tiếp tục với Google',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _textFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final IconData icon;

  const _textFieldCustom({
    super.key,
    required this.controller,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.sp,
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      decoration: BoxDecoration(
        color: AppColors.backGroundButtonColor,
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                hintText: text,
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(icon, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
