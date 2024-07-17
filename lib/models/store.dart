import 'package:storemaster/models/product.dart';

class Store {
  final String ownerName;
  final String storeName;
  final String address;
  final String phoneNumber;
  final List<Product> products;

  Store({
    required this.ownerName,
    required this.storeName,
    required this.address,
    required this.phoneNumber,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      'ownerName': ownerName,
      'storeName': storeName,
      'address': address,
      'phoneNumber': phoneNumber,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }

  factory Store.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List;
    List<Product> products = productList
        .map((productJson) => Product.fromJson(productJson))
        .toList();
    return Store(
      ownerName: json['ownerName'],
      storeName: json['storeName'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      products: products,
    );
  }

  // Getters
  String get getOwnerName => ownerName;
  String get getStoreName => storeName;
  String get getAddress => address;
  String get getPhoneNumber => phoneNumber;
  List<Product> get getProducts => products;

  // Setters
  void setOwnerName(String ownerName) => ownerName = ownerName;
  void setStoreName(String storeName) => storeName = storeName;
  void setAddress(String address) => address = address;
  void setPhoneNumber(String phoneNumber) => phoneNumber = phoneNumber;
}
