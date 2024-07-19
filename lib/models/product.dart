import 'package:storemaster/models/accompanying_Item.dart';

class Product {
  final String id;
  final String name;
  final int price;
  final int? costPrice;
  final int? promotionalPrice;
  final String? unitOfMeasure;
  final String? category;
  final String? description;
  final List<String>? imageUrls;
  final List<AccompanyingItem>? accompanyingItems;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.costPrice,
    this.promotionalPrice,
    this.unitOfMeasure,
    this.category,
    this.description,
    this.imageUrls,
    this.accompanyingItems,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'costPrice': costPrice,
      'promotionalPrice': promotionalPrice,
      'unitOfMeasure': unitOfMeasure,
      'category': category,
      'description': description,
      'imageUrls': imageUrls,
      'accompanyingItems':
          accompanyingItems?.map((item) => item.toJson()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      costPrice: json['costPrice'],
      promotionalPrice: json['promotionalPrice'],
      unitOfMeasure: json['unitOfMeasure'],
      category: json['category'],
      description: json['description'],
      imageUrls: json['imageUrls'] != null
          ? List<String>.from(json['imageUrls'])
          : null,
      accompanyingItems: json['accompanyingItems'] != null
          ? (json['accompanyingItems'] as List)
              .map((item) => AccompanyingItem.fromJson(item))
              .toList()
          : null,
    );
  }

  // Getters
  String get getId => id;
  String get getName => name;
  int get getPrice => price;
  int? get getCostPrice => costPrice;
  int? get getPromotionalPrice => promotionalPrice;
  String? get getUnitOfMeasure => unitOfMeasure;
  String? get getCategory => category;
  String? get getDescription => description;
  List<String>? get getImageUrls => imageUrls;
  List<AccompanyingItem>? get getAccompanyingItems => accompanyingItems;

  // Setters
  void setId(String id) => id = id;
  void setName(String name) => name = name;
  void setPrice(int price) => price = price;
  void setCostPrice(int? costPrice) => costPrice = costPrice;
  void setPromotionalPrice(int? promotionalPrice) =>
      promotionalPrice = promotionalPrice;
  void setUnitOfMeasure(String? unitOfMeasure) => unitOfMeasure = unitOfMeasure;
  void setCategory(String? category) => category = category;
  void setDescription(String? description) => description = description;
  void setImageUrls(List<String>? imageUrls) => imageUrls = imageUrls;
  void setAccompanyingItems(List<AccompanyingItem>? accompanyingItems) =>
      accompanyingItems = accompanyingItems;
}
