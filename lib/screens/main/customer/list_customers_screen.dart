import 'package:flutter/material.dart';
import 'package:storemaster/utils/const.dart';

class ListCustomersScreen extends StatefulWidget {
  const ListCustomersScreen({super.key});

  @override
  State<ListCustomersScreen> createState() => _ListCustomersScreenState();
}

class _ListCustomersScreenState extends State<ListCustomersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "Khách hàng",
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.whiteColor,
              child: Icon(
                Icons.arrow_back_sharp,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primaryColor,
              child: Icon(
                Icons.add_circle,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
