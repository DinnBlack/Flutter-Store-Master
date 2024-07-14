import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storemaster/screens/main/example/floating.dart';
import 'package:storemaster/screens/main/order/create_order.dart';
import 'package:storemaster/screens/main/pages/community_page_screen.dart';
import 'package:storemaster/screens/main/pages/home_page_screen.dart';
import 'package:storemaster/screens/main/product/add_new_product.dart';
import 'package:storemaster/screens/main/pages/profile_page_screen.dart';
import 'package:storemaster/screens/main/pages/store_page_screen.dart';
import 'package:storemaster/utils/const.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _bottomNavIndex = 0;

  final List<Widget> _widgetOptions = [
    const HomePageScreen(),
    const StorePageScreen(),
    const CommunityPageScreen(),
    const ProfilePageScreen(),
  ];

  List<IconData> iconList = [
    Icons.store_rounded,
    Icons.favorite,
    Icons.equalizer,
    Icons.person,
  ];

  void _navigateToPage(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: AppColors.whiteColor,
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: _widgetOptions[_bottomNavIndex],
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
        spacing: 4.sp,
        spaceBetweenChildren: 12.sp,
        backgroundColor: AppColors.primaryColor,
        overlayColor: AppColors.textColor,
        overlayOpacity: 0.4,
        childrenButtonSize: Size(
          52.sp,
          52.sp,
        ),
        childPadding: const EdgeInsets.all(0),
        renderOverlay: true,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.shopping_cart),
            label: "Thêm sản phẩm",
            backgroundColor: Colors.cyan,
            foregroundColor: Colors.white,
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                    child: const AddNewProduct(),
                    type: PageTransitionType.rightToLeft),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.person),
            label: "Thêm khách hàng",
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          SpeedDialChild(
            child: const Icon(Icons.receipt_long),
            label: "Tạo đơn hàng",
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const CreateOrder(),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        splashColor: AppColors.primaryColor,
        activeColor: AppColors.primaryColor,
        inactiveColor: Colors.black.withOpacity(.5),
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.end,
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: (index) => _navigateToPage(index),
      ),
    );
  }
}
