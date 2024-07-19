import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storemaster/services/store_service.dart';
import 'package:storemaster/utils/const.dart';

class ItemListProducts extends StatelessWidget {
  final String imageUrls;
  final String name;
  final String unitOfMeasure;
  final int price;
  final int promotionalPrice;
  const ItemListProducts({
    super.key,
    required this.imageUrls,
    required this.name,
    required this.unitOfMeasure,
    required this.price,
    required this.promotionalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                imageUrls,
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
                    name,
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
                    unitOfMeasure,
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
                        StoreService().formatCurrency(price),
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
                        StoreService().formatCurrency(promotionalPrice),
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
          SizedBox(
            width: 40.sp,
          ),
        ],
      ),
    );
  }
}
