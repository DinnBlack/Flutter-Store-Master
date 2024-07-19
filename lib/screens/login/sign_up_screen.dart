import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storemaster/screens/login/create_store_screen.dart';
import 'package:storemaster/screens/login/login_screen.dart';
import 'package:storemaster/utils/const.dart';
import 'package:storemaster/widgets/customs/cusstom_textfield.dart';
import 'package:storemaster/widgets/customs/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final usersRef = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
              'https://store-master-dinnblack-default-rtdb.asia-southeast1.firebasedatabase.app')
      .ref('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.whiteColor,
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          children: [
            Expanded(child: Container()),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Đăng ký tài khoản",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Chào mừng bạn đến với chúng tôi!",
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(height: 40.sp),
                _textFieldCustom(
                  controller: phoneNumberController,
                  icon: Icons.phone_outlined,
                  text: "Số điện thoại",
                  type: TextInputType.phone,
                ),
              ],
            ),
            SizedBox(height: 20.sp),
            Column(
              children: [
                _buttonCustom(
                  phone: phoneNumberController,
                ),
                SizedBox(height: 10.sp),
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
                SizedBox(height: 10.sp),
                _buttonGoogleCustom(
                  nameController: nameController,
                  phoneNumberController: phoneNumberController,
                  usersRef: usersRef,
                ),
                SizedBox(height: 20.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Tôi đã có tài khoản",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(width: 20.sp),
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                        child: Icon(
                          Icons.arrow_forward_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _buttonCustom extends StatelessWidget {
  final TextEditingController phone;
  const _buttonCustom({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+84${phone.text}',
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, int? resendToken) {},
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.rightToLeft,
        //     child: const PhoneVerification(),
        //   ),
        // );
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
  final TextEditingController nameController;
  final TextEditingController phoneNumberController;
  final DatabaseReference usersRef;
  const _buttonGoogleCustom({
    Key? key,
    required this.nameController,
    required this.phoneNumberController,
    required this.usersRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        String? uid = userCredential.user?.uid;
        usersRef.child(uid!).update({
          'email': userCredential.user?.email,
          'name': nameController.text,
          'phone': phoneNumberController.text,
        });
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const CreateStoreScreen(),
          ),
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
  final TextInputType type;

  const _textFieldCustom({
    Key? key,
    required this.controller,
    required this.text,
    required this.icon,
    required this.type,
  }) : super(key: key);

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
              onChanged: (value) {
                controller.text = value;
              },
              style: TextStyle(
                fontSize: 14.sp,
              ),
              keyboardType: type,
              decoration: InputDecoration(
                hintText: text,
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.sp),
            child: Icon(icon, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
