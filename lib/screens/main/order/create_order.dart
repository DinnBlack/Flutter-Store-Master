import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:storemaster/screens/main/order/create_order_product.dart';
import 'package:storemaster/utils/const.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  bool _enabled = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _enabled = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(96.sp),
        child: Column(
          children: [
            AppBar(
              backgroundColor: AppColors.whiteColor,
              centerTitle: true,
              title: const Text(
                "Sản phẩm",
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 18,
                  fontFamily: "QuicksandBold",
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
            Container(
              color: AppColors.whiteColor,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10.sp,
                    ),
                    const _itemCategory(
                      title: "Tất cả",
                      isSelected: true,
                    ),
                    const _itemCategory(
                      title: "Nước ngọt",
                      isSelected: false,
                    ),
                    const _itemCategory(
                      title: "Trà sữa",
                      isSelected: false,
                    ),
                    const _itemCategory(
                      title: "Mì Cay",
                      isSelected: false,
                    ),
                    SizedBox(
                      width: 20.sp,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 6.sp,
              color: AppColors.whiteColor,
            ),
          ],
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          color: AppColors.whiteColor,
          child: Skeletonizer(
            enabled: _enabled,
            ignoreContainers: true,
            justifyMultiLineText: true,
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (context, index) {
                return _itemCardProduct();
              },
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     _enabled
      //         ? Icons.hourglass_bottom_rounded
      //         : Icons.hourglass_disabled_outlined,
      //   ),
      //   onPressed: () {
      //     setState(() {
      //       _enabled = !_enabled;
      //     });
      //   },
      // ),
    );
  }
}

class _itemCardProduct extends StatelessWidget {
  const _itemCardProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: const CreateOrderProduct(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20.sp,
          vertical: 8.sp,
        ),
        child: Row(
          children: [
            Container(
              width: 72.sp,
              height: 72.sp,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/product1.png',
                  fit: BoxFit.cover,
                  width: 72.sp,
                  height: 72.sp,
                ),
              ),
            ),
            SizedBox(
              width: 12.sp,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 36.sp,
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Trà sữa vải thiều',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 14.sp,
                        fontFamily: "QuicksandBold",
                      ),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ly',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '16.000đ',
                          style: TextStyle(
                            color: Colors.red[300],
                            fontSize: 14.sp,
                            fontFamily: "QuicksandBold",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12.sp,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '18.000đ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                            fontFamily: "QuicksandBold",
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: Icon(
                Icons.add_circle,
                size: 32.sp,
                color: Colors.red[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _itemCategory extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? onDelete;

  const _itemCategory({
    required this.title,
    required this.isSelected,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12.sp),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
            decoration: isSelected
                ? BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8.sp),
                  )
                : BoxDecoration(
                    color: AppColors.backGroundButtonColor,
                    borderRadius: BorderRadius.circular(8.sp),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: isSelected ? AppColors.whiteColor : AppColors.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
