import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:storemaster/models/product.dart';
import 'package:storemaster/screens/main/order/create_order_product.dart';
import 'package:storemaster/services/store_service.dart';
import 'package:storemaster/utils/const.dart';
import 'package:storemaster/widgets/items/item_list_products_create_order.dart';

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
    Future.delayed(const Duration(seconds: 1), () {
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
            child: FutureBuilder<List<Product>>(
              future: StoreService().fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No products found'));
                } else {
                  final products = snapshot.data!;
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ItemListProductsCreateOrder(
                        product: product,
                      );
                    },
                  );
                }
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

class _itemCategory extends StatefulWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? onDelete;

  const _itemCategory({
    required this.title,
    required this.isSelected,
    this.onDelete,
  });

  @override
  _itemCategoryState createState() => _itemCategoryState();
}

class _itemCategoryState extends State<_itemCategory> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 12.sp),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
              decoration: _isSelected
                  ? BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8.sp),
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : BoxDecoration(
                      color: AppColors.backGroundButtonColor,
                      borderRadius: BorderRadius.circular(8.sp),
                      border: Border.all(
                        color: Colors.grey[300]!,
                      ),
                    ),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 14.sp,
                  color:
                      _isSelected ? AppColors.whiteColor : AppColors.textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
