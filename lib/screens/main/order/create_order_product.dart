import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storemaster/utils/const.dart';

class CreateOrderProduct extends StatefulWidget {
  const CreateOrderProduct({super.key});

  @override
  State<CreateOrderProduct> createState() => _CreateOrderProductState();
}

class _CreateOrderProductState extends State<CreateOrderProduct> {
  bool _expanded = false;
  int? selectedValue;
  List<bool> isCheckedList = List.filled(6, false);
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxLines = _expanded ? 2 : 10;
    var top = 0.0;
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
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
                        padding: EdgeInsets.only(top: 48.sp),
                        child: Text(
                          'Trà sữa vải thiều',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 16.sp,
                            fontFamily: "QuicksandBold",
                          ),
                        ),
                      ),
                    ),
                    background: Image.asset(
                      'assets/images/product2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Trà sữa vải thiều',
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
                                        '16.000đ',
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
                                        '18.000đ',
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
                                  "Trên con đường đời, chúng ta luôn phải đối mặt với những thử thách và khó khăn. Tuy nhiên, điều quan trọng là chúng ta không bao giờ đơn độc trên con đường đó. Bạn luôn có thể tìm thấy sự giúp đỡ và hỗ trợ từ những người xung quanh.",
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
                                buildToppingRow(0, 'Trân châu xanh', '+5.000'),
                                buildToppingRow(1, 'Trân châu đỏ', '+5.000'),
                                buildToppingRow(2, 'Trân châu tím', '+5.000'),
                                buildToppingRow(3, 'Trân châu vàng', '+5.000'),
                                buildToppingRow(4, 'Trân châu trắng', '+5.000'),
                                buildToppingRow(5, 'Trân châu hồng', '+5.000'),
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
