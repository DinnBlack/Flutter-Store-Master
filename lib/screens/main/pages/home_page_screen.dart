import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storemaster/models/daily_stats.dart';
import 'package:storemaster/models/store_details.dart';
import 'package:storemaster/screens/main/customer/list_customers_screen.dart';
import 'package:storemaster/screens/main/order/main_order_screen.dart';
import 'package:storemaster/screens/main/product/main_products_screen.dart';
import 'package:storemaster/services/store_service.dart';
import 'package:storemaster/utils/const.dart';
import 'package:storemaster/widgets/items/item_service.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.dispose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.backGroundButtonColor,
          child: Column(
            children: [
              _topBody(),
              SizedBox(
                height: 20.sp,
              ),
              //items Service
              const _serviceItems(),
            ],
          ),
        ),
      ),
    );
  }
}

PreferredSize appBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(56.sp),
    child: AppBar(
      backgroundColor: AppColors.primaryColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<StoreDetails?>(
            future: StoreService().fetchStoreDetails(),
            builder: (context, snapshot) {
              return Text(
                '${snapshot.data?.storeName}',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              );
            },
          ),
          Text(
            "quản trị viên",
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: 28.sp,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.mark_unread_chat_alt,
            color: AppColors.whiteColor,
            size: 24.sp,
          ),
          onPressed: () {},
        ),
        Padding(
          padding: EdgeInsets.only(right: 10.sp),
          child: IconButton(
            icon: Icon(
              Icons.notifications,
              color: AppColors.whiteColor,
              size: 24.sp,
            ),
            onPressed: () {},
          ),
        ),
      ],
    ),
  );
}

class _serviceItems extends StatelessWidget {
  const _serviceItems();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemService(
                text: "Đơn hàng",
                backgroundColor: Colors.blue,
                icon: Icons.receipt_long,
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const MainOrderScreen(),
                    ),
                  );
                },
              ),
              ItemService(
                text: "Khách hàng",
                backgroundColor: Colors.teal,
                icon: Icons.person_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const ListCustomersScreen(),
                    ),
                  );
                },
              ),
              ItemService(
                text: "Sản phẩm",
                backgroundColor: Colors.cyan,
                icon: Icons.shopping_cart,
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const MainProductsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemService(
                text: "Báo cáo",
                backgroundColor: Colors.orange,
                icon: Icons.bar_chart,
                onTap: () {},
              ),
              ItemService(
                text: "Tin nhắn",
                backgroundColor: Colors.purple,
                icon: Icons.message,
                onTap: () {},
              ),
              ItemService(
                text: "Cài đặt",
                backgroundColor: Colors.grey,
                icon: Icons.settings,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _topBody extends StatelessWidget {
  const _topBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16.sp),
        ),
      ),
      padding: EdgeInsets.only(
        top: 10.sp,
        left: 20.sp,
        right: 20.sp,
        bottom: 20.sp,
      ),
      child: Column(
        children: [
          const _textfieldSearch(),
          SizedBox(
            height: 20.sp,
          ),
          _revenueSummary(),
        ],
      ),
    );
  }
}

class _revenueSummary extends StatelessWidget {
  const _revenueSummary();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Doanh thu ngày",
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(
                              width: 12.sp,
                            ),
                            Icon(
                              Icons.visibility_outlined,
                              size: 16.sp,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.sp,
                        ),
                        FutureBuilder<DailyStats?>(
                          future: StoreService().fetchDailyStats(),
                          builder: (context, snapshot) {
                            final value = StoreService().formatCurrency(
                                snapshot.data?.dailyRevenue ?? 0);
                            return Text(
                              value,
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Xem doanh thu",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(
                  width: 8.sp,
                ),
                Icon(
                  Icons.next_plan,
                  size: 16.sp,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 12.sp,
                  horizontal: 12.sp,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3CD6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 28.sp,
                          color: AppColors.whiteColor,
                        ),
                        SizedBox(
                          width: 12.sp,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Đơn hàng",
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 14.sp,
                              ),
                            ),
                            FutureBuilder<DailyStats?>(
                              future: StoreService().fetchDailyStats(),
                              builder: (context, snapshot) {
                                final value = snapshot.data?.currentOrders ?? 0;
                                return Text(
                                  '$value',
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 12.sp,
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 12.sp,
                  horizontal: 12.sp,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3CD6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_outlined,
                          size: 28.sp,
                          color: AppColors.whiteColor,
                        ),
                        SizedBox(
                          width: 12.sp,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hoàn thành",
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 14.sp,
                              ),
                            ),
                            FutureBuilder<DailyStats?>(
                              future: StoreService().fetchDailyStats(),
                              builder: (context, snapshot) {
                                final value =
                                    snapshot.data?.completedOrdersToday ?? 0;
                                return Text(
                                  '$value',
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _textfieldSearch extends StatelessWidget {
  const _textfieldSearch();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      decoration: BoxDecoration(
        color: AppColors.backGroundButtonColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: AppTextStyle.quicksandRegular(16),
              decoration: InputDecoration(
                hintText: "Tìm kiếm",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16.sp),
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.sp),
            child: const Icon(Icons.search, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
