import 'package:flutter/material.dart';
import 'package:storemaster/utils/const.dart';
import 'package:storemaster/widgets/customs/cusstom_textfield.dart';
import 'package:storemaster/widgets/items/item_product.dart';

class StorePageScreen extends StatefulWidget {
  const StorePageScreen({super.key});

  @override
  State<StorePageScreen> createState() => _StorePageScreenState();
}

class _StorePageScreenState extends State<StorePageScreen> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
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
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomAppTextField(
                    controller: _textEditingController,
                    hintText: 'Tìm kiếm',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Thịnh hành",
                      style: AppTextStyle.quicksandBold(20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 260,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: index == 0 ? 20 : 0, right: 20),
                        child: const ItemProduct(),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Danh mục",
                      style: AppTextStyle.quicksandBold(20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
