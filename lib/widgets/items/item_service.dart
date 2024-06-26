import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storemaster/utils/const.dart';

class ItemService extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onTap;

  const ItemService({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.28,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 18.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 16,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20.sp,
              backgroundColor: backgroundColor,
              child: Icon(
                icon,
                color: AppColors.whiteColor,
              ),
            ),
            SizedBox(height: 8.sp),
            Text(
              text,
              style: AppTextStyle.quicksandRegular(12.sp),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
