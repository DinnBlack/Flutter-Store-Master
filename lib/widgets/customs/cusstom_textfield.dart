import 'package:flutter/material.dart';
import 'package:storemaster/utils/const.dart';

class CustomAppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomAppTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, // Increase height
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.backGroundButtonColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        // Use Row to align elements horizontally
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: AppTextStyle.quicksandRegular(18),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.search, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
