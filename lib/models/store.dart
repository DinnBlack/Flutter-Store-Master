import 'package:storemaster/models/daily_stats.dart';
import 'package:storemaster/models/product.dart';

class Store {
  final String ownerName;
  final String storeName;
  final String address;
  final String phoneNumber;
  final List<Product> products;
  final DailyStats dailyStats;

  Store({
    required this.ownerName,
    required this.storeName,
    required this.address,
    required this.phoneNumber,
    required this.products,
    required this.dailyStats,
  });

  Map<String, dynamic> toJson() {
    return {
      'ownerName': ownerName,
      'storeName': storeName,
      'address': address,
      'phoneNumber': phoneNumber,
      'products': products.map((product) => product.toJson()).toList(),
      'dailyStats': dailyStats.toMap(),
    };
  }

  factory Store.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List;
    List<Product> products =
        productList.map((productJson) => Product.fromMap(productJson)).toList();
    return Store(
      ownerName: json['ownerName'],
      storeName: json['storeName'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      products: products,
      dailyStats:
          DailyStats.fromMap(Map<String, dynamic>.from(json['dailyStats'])),
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
