import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:storemaster/models/categories.dart';
import 'package:storemaster/models/product.dart';
import 'package:storemaster/services/store_service.dart';
import 'package:storemaster/utils/const.dart';
import 'package:storemaster/widgets/items/item_list_products.dart';

class MainProductsScreen extends StatefulWidget {
  const MainProductsScreen({super.key});

  @override
  State<MainProductsScreen> createState() => _MainProductsScreenState();
}

class _MainProductsScreenState extends State<MainProductsScreen> {
  bool _enabled = true;

  String? _selectedCategory;

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

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
              width: double.infinity,
              child: FutureBuilder<List<Categories?>>(
                future: StoreService().fetchCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Lỗi: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Không có danh mục nào'));
                  }

                  final categories = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10.sp),
                        _itemCategory(
                          title: "Tất cả",
                          isSelected: _selectedCategory == '',
                          onSelect: () => _onCategorySelected(''),
                        ),
                        ...categories.map((category) {
                          return _itemCategory(
                            title: category!.name,
                            isSelected: _selectedCategory == category.name,
                            onSelect: () => _onCategorySelected(category.name),
                          );
                        }).toList(),
                        SizedBox(width: 20.sp),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                color: AppColors.whiteColor,
              ),
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
              future: StoreService().fetchProductsByCategory(_selectedCategory),
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
                      return ItemListProducts(
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
  final VoidCallback onSelect;

  const _itemCategory({
    required this.title,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  _itemCategoryState createState() => _itemCategoryState();
}

class _itemCategoryState extends State<_itemCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.sp),
      child: GestureDetector(
        onTap: () {
          widget.onSelect();
        },
        child: Container(
          height: 38.sp,
          padding: EdgeInsets.symmetric(
            horizontal: 10.sp,
          ),
          decoration: widget.isSelected
              ? BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8.sp),
                  border: Border.all(
                    color: AppColors.primaryColor,
                  ),
                )
              : BoxDecoration(
                  color: AppColors.backGroundButtonColor,
                  borderRadius: BorderRadius.circular(10.sp),
                  border: Border.all(
                    color: Colors.grey[300]!,
                  ),
                ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: widget.isSelected
                      ? AppColors.whiteColor
                      : AppColors.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
