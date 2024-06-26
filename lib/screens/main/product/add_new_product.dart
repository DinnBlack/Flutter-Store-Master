import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storemaster/utils/const.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.sp),
        child: AppBar(
          backgroundColor: AppColors.whiteColor,
          centerTitle: true,
          title: const Text(
            "Thêm sản phẩm mới",
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
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 400.sp,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.backGroundButtonColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                              32.sp,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.sp),
                              height: 4.sp,
                              width: 80.sp,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(12.sp),
                              ),
                            ),
                            Text(
                              "Thông tin thêm",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textColor,
                                fontFamily: "QuicksandBold",
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 24.sp,
                  color: AppColors.textColor,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.backGroundButtonColor,
          child: Column(
            children: [
              SizedBox(
                height: 12.sp,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.sp,
                ),
                child: Text(
                  "Ảnh sản phẩm",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textColor,
                    fontFamily: "QuicksandBold",
                  ),
                ),
              ),
              SizedBox(height: 8.sp),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const _buttonAddImage(),
                    const _imageProduct(
                      image: "product1",
                    ),
                    const _imageProduct(
                      image: "product2",
                    ),
                    const _imageProduct(
                      image: "product7",
                    ),
                    const _imageProduct(
                      image: "product4",
                    ),
                    SizedBox(
                      width: 20.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: const _textFieldAddNewProduct(
                  title: "Tên sản phẩm",
                  hintText: "Ví dụ: bánh mì,...",
                  isNumeric: false,
                  isRequired: true,
                ),
              ),
              SizedBox(
                height: 12.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Row(
                  children: [
                    const Expanded(
                      child: _textFieldAddNewProduct(
                        title: "Giá bán",
                        hintText: "0.00",
                        isNumeric: true,
                        isRequired: true,
                      ),
                    ),
                    SizedBox(width: 12.sp),
                    const Expanded(
                      child: _textFieldAddNewProduct(
                        title: "Giá vốn",
                        hintText: "0.00",
                        isNumeric: true,
                      ),
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
                  children: [
                    const Expanded(
                      child: _textFieldAddNewProduct(
                        title: "Giá khuyến mãi",
                        hintText: "0.00",
                        isNumeric: true,
                      ),
                    ),
                    SizedBox(width: 12.sp),
                    const Expanded(
                      child: _textFieldAddNewProduct(
                        title: "Đơn vị",
                        hintText: "Ví dụ: 1 cái,...",
                        isNumeric: false,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12.sp,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.sp,
                ),
                child: Text(
                  "Danh mục",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textColor,
                    fontFamily: "QuicksandBold",
                  ),
                ),
              ),
              SizedBox(height: 8.sp),
              Container(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10.sp,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu,
                          size: 28.sp,
                        ),
                      ),
                      const _itemCategory(
                        title: "Bánh mì",
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
              SizedBox(
                height: 12.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: const _textFieldAddNewProduct(
                  title: "Mô tả",
                  hintText: "Ví dụ: bánh mì đặc biệt thơm ngon ...",
                  isNumeric: false,
                  isRequired: false,
                ),
              ),
              SizedBox(
                height: 12.sp,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.sp,
                ),
                child: Text(
                  "Món bán kèm",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textColor,
                    fontFamily: "QuicksandBold",
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.sp,
                ),
                child: Text(
                  "Chưa suy nghĩ ra!",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              SizedBox(height: 8.sp),
              SizedBox(
                height: 24.sp,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
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
      margin: const EdgeInsets.only(left: 12),
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
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(8.sp),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color:
                        isSelected ? AppColors.whiteColor : AppColors.textColor,
                  ),
                ),
                if (isSelected)
                  Padding(
                    padding: EdgeInsets.only(left: 12.sp),
                    child: GestureDetector(
                      onTap: onDelete,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.whiteColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 14.sp,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.sp,
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 6,
            blurRadius: 16,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.whiteColor,
                side: BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.sp,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.sp),
                ),
              ),
              child: Text(
                "Tạo thêm",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 12.sp,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.sp),
                ),
              ),
              child: Text(
                "Hoàn tất",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _buttonAddImage extends StatelessWidget {
  const _buttonAddImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.sp,
      height: 80.sp,
      margin: EdgeInsets.only(left: 20.sp),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.sp,
          color: Colors.grey,
        ),
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.add_rounded,
        color: Colors.grey,
        size: 50.sp,
      ),
    );
  }
}

class _imageProduct extends StatelessWidget {
  final String image;
  final VoidCallback? onDelete;
  const _imageProduct({
    required this.image,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.sp,
      height: 80.sp,
      margin: EdgeInsets.only(left: 20.sp),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/$image.png',
              fit: BoxFit.cover,
              width: 80.sp,
              height: 80.sp,
            ),
          ),
          Positioned(
            top: 6.sp,
            right: 6.sp,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.4.sp,
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close_outlined,
                  color: Colors.white,
                  size: 14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _textFieldAddNewProduct extends StatelessWidget {
  final String title;
  final String hintText;
  final bool isNumeric;
  final bool isRequired;
  const _textFieldAddNewProduct({
    required this.title,
    required this.hintText,
    this.isNumeric = false,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textColor,
                fontFamily: "QuicksandBold",
              ),
            ),
            SizedBox(width: 4.sp),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.red,
                ),
              ),
          ],
        ),
        SizedBox(height: 8.sp),
        Container(
          height: 48.sp,
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey,
              width: 1.sp,
            ),
          ),
          child: TextField(
            keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
            inputFormatters:
                isNumeric ? [FilteringTextInputFormatter.digitsOnly] : [],
            style: AppTextStyle.quicksandRegular(14.sp),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
