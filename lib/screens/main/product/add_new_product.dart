import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:storemaster/models/categories.dart';
import 'package:storemaster/models/product.dart';
import 'package:storemaster/services/store_service.dart';
import 'package:storemaster/utils/const.dart';
import 'package:toastification/toastification.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _sellingPriceController = TextEditingController();
  final TextEditingController _costPriceController = TextEditingController();
  final TextEditingController _promotionalPriceController =
      TextEditingController();
  final TextEditingController _unitOfMeasureController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  final List<String> items = List.generate(20, (index) => "Item $index");
  final TextEditingController _newCategoryController = TextEditingController();
  String _selectedCategory = '';
  late Future<List<Categories?>> _futureCategories;

  @override
  void initState() {
    super.initState();
    _futureCategories = StoreService().fetchCategories();
  }

  void _onCategorySelected(String categoryTitle) {
    setState(() {
      _selectedCategory = categoryTitle;
    });
  }

  void _onClearSelection() {
    setState(() {
      _selectedCategory = '';
    });
  }

  void onAddNewCategory() async {
    if (_newCategoryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hãy điền tên danh mục!')),
      );
      return;
    }

    final category = Categories(
      name: _newCategoryController.text.trim(),
      itemCount: 0,
    );

    await StoreService().addCategoryToStore(category);

    toastification.show(
      context: context,
      title: Text('Thêm danh mục mới thành công'),
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
    Navigator.pop(context);
  }

  void onComplete() async {
    if (_productNameController.text.isEmpty ||
        _sellingPriceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hãy điền đầy đủ thông tin!')),
      );
      return;
    }

    final idProduct = DateTime.now().millisecondsSinceEpoch.toString();

    final imageUrls = await StoreService().uploadImages(
      _selectedImages,
      idProduct,
    );

    final product = Product(
      id: idProduct,
      name: _productNameController.text,
      price: StoreService().parseCurrency(_sellingPriceController.text),
      costPrice: StoreService().parseCurrency(_costPriceController.text),
      promotionalPrice:
          StoreService().parseCurrency(_promotionalPriceController.text),
      unitOfMeasure: _unitOfMeasureController.text,
      category: _selectedCategory,
      description: _descriptionController.text,
      imageUrls: imageUrls,
      accompanyingItems: [],
    );

    await StoreService().addProductToStore(product);

    toastification.show(
      context: context,
      title: Text('Thêm sản phẩm thành công'),
      autoCloseDuration: const Duration(seconds: 3),
      style: ToastificationStyle.flat,
      type: ToastificationType.success,
      closeButtonShowType: CloseButtonShowType.always,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      // applyBlurEffect: true,
      showProgressBar: false,
    );
    Navigator.pop(context);
  }

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        _selectedImages.addAll(
          pickedFiles.map((xFile) => File(xFile.path)).toList(),
        );
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.sp),
        child: AppBar(
          backgroundColor: AppColors.whiteColor,
          centerTitle: true,
          title: Text(
            "Thêm sản phẩm mới",
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 16.sp,
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
          color: AppColors.whiteColor,
          child: Column(
            children: [
              SizedBox(
                height: 10.sp,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.sp,
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
              SizedBox(height: 10.sp),
              Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buttonAddImage(onTap: _pickImages),
                      ..._selectedImages.map((file) => _imageProduct(
                            image: file.path,
                            onDelete: () {
                              setState(() {
                                _selectedImages.remove(file);
                              });
                            },
                          )),
                      SizedBox(
                        width: 10.sp,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: _textFieldAddNewProduct(
                  controller: _productNameController,
                  title: "Tên sản phẩm",
                  hintText: "Ví dụ: bánh mì,...",
                  isNumeric: false,
                  isRequired: true,
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: Row(
                  children: [
                    Expanded(
                      child: _textFieldAddNewProduct(
                        controller: _sellingPriceController,
                        title: "Giá bán",
                        hintText: "0.00",
                        isNumeric: true,
                        isRequired: true,
                      ),
                    ),
                    SizedBox(width: 10.sp),
                    Expanded(
                      child: _textFieldAddNewProduct(
                        controller: _costPriceController,
                        title: "Giá vốn",
                        hintText: "0.00",
                        isNumeric: true,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: Row(
                  children: [
                    Expanded(
                      child: _textFieldAddNewProduct(
                        controller: _promotionalPriceController,
                        title: "Giá khuyến mãi",
                        hintText: "0.00",
                        isNumeric: true,
                      ),
                    ),
                    SizedBox(width: 10.sp),
                    Expanded(
                      child: _textFieldAddNewProduct(
                        controller: _unitOfMeasureController,
                        title: "Đơn vị",
                        hintText: "Ví dụ: 1 cái,...",
                        isNumeric: false,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.sp,
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
              SizedBox(height: 10.sp),
              Container(
                alignment: Alignment.centerLeft,
                child: FutureBuilder<List<Categories?>>(
                  future: _futureCategories,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Lỗi: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10.sp),
                            IconButton(
                              onPressed: () {
                                _showBottomSheetCategories(
                                    context, _selectedCategory);
                              },
                              icon: Icon(
                                Icons.menu,
                                size: 28.sp,
                              ),
                            ),
                            Text('Không có danh mục nào'),
                            SizedBox(width: 20.sp),
                          ],
                        ),
                      );
                    }

                    final categories = snapshot.data!;

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10.sp),
                          IconButton(
                            onPressed: () {
                              _showBottomSheetCategories(
                                  context, _selectedCategory);
                            },
                            icon: Icon(
                              Icons.menu,
                              size: 28.sp,
                            ),
                          ),
                          ...categories.map((category) {
                            return _itemCategory(
                              title: category!.name,
                              isSelected: _selectedCategory == category.name,
                              onSelect: () =>
                                  _onCategorySelected(category.name),
                            );
                          }).toList(),
                          SizedBox(width: 20.sp),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: _textFieldAddNewProduct(
                  controller: _descriptionController,
                  title: "Mô tả",
                  hintText: "Ví dụ: bánh mì đặc biệt thơm ngon ...",
                  isNumeric: false,
                  isRequired: false,
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.sp,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Thêm tùy chọn",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textColor,
                        fontFamily: "QuicksandBold",
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _showBottomSheetOptions(context);
                      },
                      icon: Icon(
                        Icons.add_rounded,
                        size: 24.sp,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.sp,
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
      bottomNavigationBar: MyBottomNavigationBar(onComplete: onComplete),
    );
  }

  Future<dynamic> _showBottomSheetOptions(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400.sp,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                10.sp,
              ),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.sp),
                height: 2.sp,
                width: 80.sp,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.sp),
                ),
              ),
              Text(
                "Thêm tùy chọn",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textColor,
                  fontFamily: "QuicksandBold",
                ),
              ),
              SizedBox(height: 10.sp),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40.sp,
                      padding: EdgeInsets.symmetric(horizontal: 10.sp),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.backGroundButtonColor,
                        borderRadius: BorderRadius.circular(10.sp),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.sp,
                        ),
                      ),
                      child: TextField(
                        onChanged: (value) {},
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: "Tìm kiếm tùy chọn",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController categoryController =
                              TextEditingController();

                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(16.sp),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Thêm danh mục mới",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 20.sp),
                                  Container(
                                    height: 40.sp,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.sp),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.backGroundButtonColor,
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      border: Border.all(
                                        color: Colors.grey[300]!,
                                        width: 1.sp,
                                      ),
                                    ),
                                    child: TextField(
                                      onChanged: (value) {
                                        categoryController.text = value;
                                      },
                                      controller: _newCategoryController,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Nhập tên danh mục",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.sp,
                                        ),
                                        border: InputBorder.none,
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.sp),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            height: 39.sp,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              border: Border.all(
                                                color: Colors.grey,
                                                width: 1.sp,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                            ),
                                            child: Text(
                                              "Hủy",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppColors.textColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.sp),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            onAddNewCategory();
                                            _newCategoryController.clear();
                                          },
                                          child: Container(
                                            height: 40.sp,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                            ),
                                            child: Text(
                                              "Tạo danh mục",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppColors.whiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 40.sp,
                      height: 40.sp,
                      margin: EdgeInsets.only(left: 10.sp),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.sp,
                          color: AppColors.primaryColor,
                        ),
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Icon(
                        Icons.add_rounded,
                        color: AppColors.whiteColor,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.sp),
              Expanded(
                child: Skeletonizer(
                  enabled: false,
                  ignoreContainers: true,
                  justifyMultiLineText: true,
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

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3.2,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory =
                                    category!.name; // Update selected category
                              });
                            },
                            child: Container(
                              height: 40.sp,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 10.sp),
                              decoration: BoxDecoration(
                                color: _selectedCategory == category?.name
                                    ? AppColors.primaryColor
                                    : AppColors.backGroundButtonColor,
                                borderRadius: BorderRadius.circular(10.sp),
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1.sp,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category!.name,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: "QuicksandBold",
                                      color: _selectedCategory == category.name
                                          ? AppColors.whiteColor
                                          : AppColors.textColor,
                                    ),
                                  ),
                                  Text(
                                    "Số sản phẩm: ${category.getItemCount}",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: _selectedCategory == category.name
                                          ? AppColors.whiteColor
                                          : AppColors.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> _showBottomSheetCategories(
      BuildContext context, String? selectedCategory) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: 400.sp,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10.sp),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.sp),
                      height: 2.sp,
                      width: 80.sp,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                    ),
                    Text(
                      "Danh mục",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textColor,
                        fontFamily: "QuicksandBold",
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40.sp,
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.backGroundButtonColor,
                              borderRadius: BorderRadius.circular(10.sp),
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1.sp,
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) {},
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                              decoration: InputDecoration(
                                hintText: "Tìm kiếm danh mục",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                TextEditingController categoryController =
                                    TextEditingController();

                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                  backgroundColor: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(16.sp),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Thêm danh mục mới",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 20.sp),
                                        Container(
                                          height: 40.sp,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.sp),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color:
                                                AppColors.backGroundButtonColor,
                                            borderRadius:
                                                BorderRadius.circular(10.sp),
                                            border: Border.all(
                                              color: Colors.grey[300]!,
                                              width: 1.sp,
                                            ),
                                          ),
                                          child: TextField(
                                            onChanged: (value) {
                                              categoryController.text = value;
                                            },
                                            controller: _newCategoryController,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "Nhập tên danh mục",
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.sp,
                                              ),
                                              border: InputBorder.none,
                                              isDense: true,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20.sp),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height: 39.sp,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.whiteColor,
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1.sp,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.sp),
                                                  ),
                                                  child: Text(
                                                    "Hủy",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color:
                                                          AppColors.textColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10.sp),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  onAddNewCategory();
                                                  _newCategoryController
                                                      .clear();
                                                },
                                                child: Container(
                                                  height: 40.sp,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.sp),
                                                  ),
                                                  child: Text(
                                                    "Tạo danh mục",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 40.sp,
                            height: 40.sp,
                            margin: EdgeInsets.only(left: 10.sp),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.sp,
                                color: AppColors.primaryColor,
                              ),
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: Icon(
                              Icons.add_rounded,
                              color: AppColors.whiteColor,
                              size: 24.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.sp),
                    Expanded(
                      child: Skeletonizer(
                        enabled: false,
                        ignoreContainers: true,
                        justifyMultiLineText: true,
                        child: FutureBuilder<List<Categories?>>(
                          future: StoreService().fetchCategories(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Lỗi: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                  child: Text('Không có danh mục nào'));
                            }

                            final categories = snapshot.data!;

                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 3.2,
                              ),
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                final category = categories[index];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedCategory = category!
                                          .name; // Update selected category
                                    });
                                  },
                                  child: Container(
                                    height: 40.sp,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.sp),
                                    decoration: BoxDecoration(
                                      color: _selectedCategory == category?.name
                                          ? AppColors.primaryColor
                                          : AppColors.backGroundButtonColor,
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      border: Border.all(
                                        color: Colors.grey[300]!,
                                        width: 1.sp,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          category!.name,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: "QuicksandBold",
                                            color: _selectedCategory ==
                                                    category.name
                                                ? AppColors.whiteColor
                                                : AppColors.textColor,
                                          ),
                                        ),
                                        Text(
                                          "Số sản phẩm: ${category.getItemCount}",
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: _selectedCategory ==
                                                    category.name
                                                ? AppColors.whiteColor
                                                : AppColors.textColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      setState(() {
        _futureCategories = StoreService().fetchCategories();
      });
    });
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
          height: 40.sp,
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

class MyBottomNavigationBar extends StatelessWidget {
  final VoidCallback onComplete;
  const MyBottomNavigationBar({
    super.key,
    required this.onComplete,
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
            spreadRadius: 4,
            blurRadius: 2,
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
              onPressed: onComplete,
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
  final VoidCallback onTap;
  const _buttonAddImage({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.sp,
        height: 80.sp,
        margin: EdgeInsets.only(left: 10.sp),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.sp,
            color: Colors.grey[300]!,
          ),
          color: AppColors.backGroundButtonColor,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Icon(
          Icons.add_rounded,
          color: Colors.grey,
          size: 50.sp,
        ),
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
      margin: EdgeInsets.only(left: 10.sp),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.sp),
            child: Image.file(
              File(image),
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
  final TextEditingController controller;
  const _textFieldAddNewProduct({
    required this.title,
    required this.hintText,
    this.isNumeric = false,
    this.isRequired = false,
    required this.controller,
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
            SizedBox(width: 10.sp),
            if (isRequired)
              Text(
                '(bắt buộc)',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.red,
                ),
              ),
          ],
        ),
        SizedBox(height: 10.sp),
        Container(
          height: 40.sp,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          decoration: BoxDecoration(
            color: AppColors.backGroundButtonColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1.sp,
            ),
          ),
          child: TextField(
            onChanged: (value) {
              controller.text = value;
              if (isNumeric) {
                final formattedText =
                    StoreService().formatCurrencyByString(value);
                if (controller.text != formattedText) {
                  controller.value = TextEditingValue(
                    text: formattedText,
                    selection: TextSelection.collapsed(
                        offset: formattedText.length - 1),
                  );
                }
              }
            },
            controller: controller,
            keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
            inputFormatters:
                isNumeric ? [FilteringTextInputFormatter.digitsOnly] : [],
            style: AppTextStyle.quicksandRegular(14.sp),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
              isDense: true,
              border: InputBorder.none,
            ),
            // maxLines: null,
          ),
        ),
      ],
    );
  }
}
