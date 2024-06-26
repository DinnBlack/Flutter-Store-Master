import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storemaster/utils/const.dart';

class MainProductsScreen extends StatefulWidget {
  const MainProductsScreen({super.key});

  @override
  State<MainProductsScreen> createState() => _MainProductsScreenState();
}

class _MainProductsScreenState extends State<MainProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.sp),
        child: AppBar(
          backgroundColor: AppColors.whiteColor,
          centerTitle: true,
          title: const Text(
            "Sản phẩm",
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 18,
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.chevron_left_rounded,
                size: 24.sp,
                color: AppColors.textColor,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search_outlined,
                  size: 24.sp,
                  color: AppColors.textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
