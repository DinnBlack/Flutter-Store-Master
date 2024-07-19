import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:storemaster/screens/main/main_screen.dart';
import 'package:storemaster/screens/splash/splash_screen.dart';
import 'package:storemaster/services/store_service.dart';
import 'package:storemaster/utils/const.dart';

class CreateStoreScreen extends StatefulWidget {
  const CreateStoreScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CreateStoreScreenState createState() => _CreateStoreScreenState();
}

class _CreateStoreScreenState extends State<CreateStoreScreen> {
  final TextEditingController storeNameController = TextEditingController();

  @override
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
                "Tạo cửa hàng của bạn",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hãy tạo cửa hàng của bạn nhé!",
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(height: 40.sp),
            _textFieldCustom(
              controller: storeNameController,
              icon: Icons.store_outlined,
              text: "Tên cửa hàng",
            ),
            SizedBox(height: 20.sp),
            _buttonCustom(
              storeNameController: storeNameController,
            ),
            SizedBox(height: 20.sp),
          ],
        ),
      ),
    );
  }
}

class _buttonCustom extends StatelessWidget {
  final TextEditingController storeNameController;

  const _buttonCustom({
    Key? key,
    required this.storeNameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DatabaseReference usersRef = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          'https://store-master-dinnblack-default-rtdb.asia-southeast1.firebasedatabase.app',
    ).ref('users');

    return ElevatedButton(
      onPressed: () async {
        await StoreService().createStore(storeNameController.text);
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const SplashScreen(
              splash: 'assets/lottie/Animation - 1721316132550.json',
              nextScreen: MainScreen(),
            ),
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
        'Tạo cửa hàng',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _textFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final IconData icon;

  const _textFieldCustom({
    Key? key,
    required this.controller,
    required this.text,
    required this.icon,
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
              onChanged: (value) {
                controller.text = value;
              },
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
