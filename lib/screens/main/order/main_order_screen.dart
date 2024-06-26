import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storemaster/utils/const.dart';

class MainOrderScreen extends StatefulWidget {
  const MainOrderScreen({super.key});

  @override
  State<MainOrderScreen> createState() => _MainOrderScreenState();
}

class _MainOrderScreenState extends State<MainOrderScreen> {
  @override
  Widget build(BuildContext context) {
    double tabWidth = 100.0.sp;
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.sp),
          child: AppBar(
            backgroundColor: AppColors.whiteColor,
            centerTitle: true,
            title: const Text(
              "Đơn hàng",
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
            bottom: TabBar(
              isScrollable: true,
              dividerColor: Colors.grey.withOpacity(0.5),
              indicatorColor: AppColors.primaryColor,
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: AppColors.textColor,
              tabs: [
                Tab(
                  child: Container(
                    width: tabWidth,
                    alignment: Alignment.center,
                    child: const Text("Tất cả"),
                  ),
                ),
                Tab(
                  child: Container(
                    width: tabWidth,
                    alignment: Alignment.center,
                    child: const Text("Chờ xác nhận"),
                  ),
                ),
                Tab(
                  child: Container(
                    width: tabWidth,
                    alignment: Alignment.center,
                    child: const Text("Đang xử lý"),
                  ),
                ),
                Tab(
                  child: Container(
                    width: tabWidth,
                    alignment: Alignment.center,
                    child: const Text("Hoàn thành"),
                  ),
                ),
                Tab(
                  child: Container(
                    width: tabWidth,
                    alignment: Alignment.center,
                    child: const Text("Trả hàng"),
                  ),
                ),
                Tab(
                  child: Container(
                    width: tabWidth,
                    alignment: Alignment.center,
                    child: const Text("Hủy"),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          color: AppColors.backGroundButtonColor,
          width: double.infinity,
          height: double.infinity,
          child: TabBarView(
            children: [
              Container(),
              const Center(child: Text("Chờ xác nhận")),
              const Center(child: Text("Đang xử lý")),
              const Center(child: Text("Hoàn thành")),
              const Center(child: Text("Trả hàng")),
              const Center(child: Text("Hủy")),
            ],
          ),
        ),
      ),
    );
  }
}
