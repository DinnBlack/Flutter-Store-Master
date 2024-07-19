import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storemaster/models/product.dart';
import 'package:storemaster/services/store_service.dart';
import 'package:storemaster/utils/const.dart';
import 'package:toastification/toastification.dart';

class CreateOrderProduct extends StatefulWidget {
  final Product? product;
  const CreateOrderProduct({super.key, required this.product});

  @override
  State<CreateOrderProduct> createState() => _CreateOrderProductState();
}

class _CreateOrderProductState extends State<CreateOrderProduct> {
  bool _expanded = false;
  int? selectedValue;
  List<bool> isCheckedList = List.filled(6, false);
  ScrollController _scrollController = ScrollController();
  int quantity = 1;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxLines = !_expanded ? 2 : 10;
    var top = 0.0;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: AppColors.whiteColor,
              stretch: true,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: AppColors.textColor,
                  size: 24.sp,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              expandedHeight: 240.sp,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return Container(
                    color: AppColors.whiteColor,
                    child: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      titlePadding: EdgeInsets.zero,
                      centerTitle: true,
                      title: AnimatedOpacity(
                        duration: Duration(milliseconds: 100),
                        opacity: top <= 110 ? 1 : 0,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 20.sp),
                          child: Text(
                            widget.product!.getName,
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 16.sp,
                              fontFamily: "QuicksandBold",
                            ),
                          ),
                        ),
                      ),
                      background: Image.network(
                        widget.product!.getImageUrls != null &&
                                widget.product!.getImageUrls!.isNotEmpty
                            ? widget.product!.getImageUrls!.first
                            : "assets/images/product2.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ];
        },
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.sp, vertical: 12.sp),
                          color: AppColors.whiteColor,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      widget.product!.getName,
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 16.sp,
                                        fontFamily: "QuicksandBold",
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          StoreService().formatCurrency(widget
                                                  .product!
                                                  .getPromotionalPrice ??
                                              widget.product!.getPrice),
                                          style: TextStyle(
                                            color: Colors.red[300],
                                            fontSize: 16.sp,
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
                                          StoreService().formatCurrency(
                                              widget.product!.getPrice),
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14.sp,
                                            fontFamily: "QuicksandBold",
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12.sp,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _expanded = !_expanded;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.product!.getDescription ?? '',
                                    maxLines: maxLines,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12.sp,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.sp,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.sp, vertical: 12.sp),
                          color: AppColors.whiteColor,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Size',
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
                                  SizedBox(
                                    width: 8.sp,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'chọn 1',
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.8.sp,
                                        child: Radio(
                                          value: 1,
                                          groupValue: selectedValue,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedValue = value as int?;
                                            });
                                          },
                                          activeColor: AppColors.primaryColor,
                                        ),
                                      ),
                                      Expanded(
                                          child: Text(
                                        'Size nhỏ',
                                      )),
                                    ],
                                  ),
                                  Container(
                                    height: 0.8.sp,
                                    color: Colors.grey[300],
                                  ),
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.8.sp,
                                        child: Radio(
                                          value: 2,
                                          groupValue: selectedValue,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedValue = value as int?;
                                            });
                                          },
                                          activeColor: AppColors.primaryColor,
                                        ),
                                      ),
                                      Expanded(child: Text('Size vừa')),
                                      Text('+5.000'),
                                    ],
                                  ),
                                  Container(
                                    height: 0.8.sp,
                                    color: Colors.grey[300],
                                  ),
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.8.sp,
                                        child: Radio(
                                          value: 3,
                                          groupValue: selectedValue,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedValue = value as int?;
                                            });
                                          },
                                          activeColor: AppColors.primaryColor,
                                        ),
                                      ),
                                      Expanded(child: Text('Size lớn')),
                                      Text('+10.000'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.sp,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.sp, vertical: 12.sp),
                          color: AppColors.whiteColor,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Topping',
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
                                  SizedBox(
                                    width: 8.sp,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Không bắt buộc',
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildToppingRow(
                                      0, 'Trân châu xanh', '+5.000'),
                                  buildToppingRow(1, 'Trân châu đỏ', '+5.000'),
                                  buildToppingRow(2, 'Trân châu tím', '+5.000'),
                                  buildToppingRow(
                                      3, 'Trân châu vàng', '+5.000'),
                                  buildToppingRow(
                                      4, 'Trân châu trắng', '+5.000'),
                                  buildToppingRow(
                                      5, 'Trân châu hồng', '+5.000'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.sp,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.sp, vertical: 12.sp),
                          color: AppColors.whiteColor,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Size',
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
                                  SizedBox(
                                    width: 8.sp,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'chọn 1',
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.8.sp,
                                        child: Radio(
                                          value: 1,
                                          groupValue: selectedValue,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedValue = value as int?;
                                            });
                                          },
                                          activeColor: AppColors.primaryColor,
                                        ),
                                      ),
                                      Expanded(
                                          child: Text(
                                        'Size nhỏ',
                                      )),
                                    ],
                                  ),
                                  Container(
                                    height: 0.8.sp,
                                    color: Colors.grey[300],
                                  ),
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.8.sp,
                                        child: Radio(
                                          value: 2,
                                          groupValue: selectedValue,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedValue = value as int?;
                                            });
                                          },
                                          activeColor: AppColors.primaryColor,
                                        ),
                                      ),
                                      Expanded(child: Text('Size vừa')),
                                      Text('+5.000'),
                                    ],
                                  ),
                                  Container(
                                    height: 0.8.sp,
                                    color: Colors.grey[300],
                                  ),
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.8.sp,
                                        child: Radio(
                                          value: 3,
                                          groupValue: selectedValue,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedValue = value as int?;
                                            });
                                          },
                                          activeColor: AppColors.primaryColor,
                                        ),
                                      ),
                                      Expanded(child: Text('Size lớn')),
                                      Text('+10.000'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        quantity: quantity,
        onIncrease: () {
          setState(() {
            quantity++;
          });
        },
        onDecrease: () {
          if (quantity > 1) {
            setState(() {
              quantity--;
            });
          }
        },
      ),
    );
  }

  Widget buildToppingRow(int index, String text, String price) {
    bool isLastItem = index == isCheckedList.length - 1;
    return Column(
      children: [
        Row(
          children: [
            Transform.scale(
              scale: 0.8.sp,
              child: Checkbox(
                value: isCheckedList[index],
                onChanged: (value) {
                  setState(() {
                    isCheckedList[index] = value!;
                  });
                },
                activeColor: AppColors.primaryColor,
                checkColor: Colors.white,
              ),
            ),
            Expanded(
              child: Text(
                text,
              ),
            ),
            Text(price),
          ],
        ),
        if (!isLastItem)
          Container(
            height: 0.8.sp,
            color: Colors.grey[300],
          ),
      ],
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  const MyBottomNavigationBar({
    super.key,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.sp,
      padding: EdgeInsets.symmetric(
        horizontal: 20.sp,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            color: AppColors.whiteColor,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Số lượng món",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textColor,
                    fontFamily: "QuicksandBold",
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: onDecrease,
                      child: Icon(
                        EneftyIcons.minus_square_outline,
                        color: quantity == 1
                            ? Colors.grey
                            : AppColors.primaryColor,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(
                      width: 12.sp,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 24.sp,
                      child: Text(
                        "$quantity",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textColor,
                          fontFamily: "QuicksandBold",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.sp,
                    ),
                    InkWell(
                      onTap: onIncrease,
                      child: Icon(
                        EneftyIcons.add_square_outline,
                        color: AppColors.primaryColor,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 32.sp,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                toastification.show(
                  context: context,
                  title: Text('Thêm sản phẩm thành công'),
                  autoCloseDuration: const Duration(seconds: 2),
                  style: ToastificationStyle.flat,
                  type: ToastificationType.success,
                  closeButtonShowType: CloseButtonShowType.always,
                  closeOnClick: false,
                  pauseOnHover: true,
                  dragToClose: true,
                  // applyBlurEffect: true,
                  showProgressBar: false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.sp),
                ),
              ),
              child: Text(
                "Thêm vào giỏ hàng - 16.000đ",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.whiteColor,
                  fontFamily: "QuicksandBold",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
