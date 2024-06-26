import 'package:flutter/material.dart';
import 'package:storemaster/utils/const.dart';

class CustomAppCategoryButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const CustomAppCategoryButton({super.key, 
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primaryColor,
            child: Icon(
              Icons.person_rounded,
              color: AppColors.whiteColor,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            text,
            style: AppTextStyle.quicksandRegularColor(
              16,
              AppColors.textColor,
              FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
