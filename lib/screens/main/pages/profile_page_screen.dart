import 'package:flutter/material.dart';
import 'package:storemaster/utils/const.dart';
import 'package:storemaster/widgets/items/item_revenue_summary.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({super.key});

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.primaryColor,
              child: Icon(
                Icons.person_rounded,
                color: AppColors.whiteColor,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              "Xin chào!",
              style: AppTextStyle.quicksandBold(24),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: AppColors.whiteColor,
          child: const Column(
            children: [
              SizedBox(
                height: 20,
              ),
              ItemRevenueSummary(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
