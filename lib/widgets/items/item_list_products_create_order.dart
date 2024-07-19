import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storemaster/models/product.dart';
import 'package:storemaster/screens/main/order/create_order_product.dart';
import 'package:storemaster/services/store_service.dart';
import 'package:storemaster/utils/const.dart';

class ItemListProductsCreateOrder extends StatelessWidget {
  final Product product;
  const ItemListProductsCreateOrder({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: CreateOrderProduct(
              product: product,
            ),
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
                child: Image.network(
                  product.getImageUrls != null &&
                          product.getImageUrls!.isNotEmpty
                      ? product.getImageUrls!.first
                      : "assets/images/product2.png",
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
                      product.getName,
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
                      product.getUnitOfMeasure ?? '',
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
                          StoreService().formatCurrency(
                              product.getPromotionalPrice ?? product.getPrice),
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
                          StoreService().formatCurrency(product.getPrice),
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
