import 'package:storemaster/models/accompanying_Item.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final double? costPrice;
  final double? promotionalPrice;
  final String? unitOfMeasure;
  final String? category;
  final String? description;
  final String? imageUrl;
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
    this.imageUrl,
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
      'imageUrl': imageUrl,
      'accompanyingItems':
          accompanyingItems?.map((item) => item.toJson()).toList(),
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      costPrice: json['costPrice'],
      promotionalPrice: json['promotionalPrice'],
      unitOfMeasure: json['unitOfMeasure'],
      category: json['category'],
      description: json['description'],
      imageUrl: json['imageUrl'],
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
  double get getPrice => price;
  double? get getCostPrice => costPrice;
  double? get getPromotionalPrice => promotionalPrice;
  String? get getUnitOfMeasure => unitOfMeasure;
  String? get getCategory => category;
  String? get getDescription => description;
  String? get getImageUrl => imageUrl;
  List<AccompanyingItem>? get getAccompanyingItems => accompanyingItems;

  // Setters
  void setId(String id) => id = id;
  void setName(String name) => name = name;
  void setPrice(double price) => price = price;
  void setCostPrice(double? costPrice) => costPrice = costPrice;
  void setPromotionalPrice(double? promotionalPrice) => promotionalPrice = promotionalPrice;
  void setUnitOfMeasure(String? unitOfMeasure) => unitOfMeasure = unitOfMeasure;
  void setCategory(String? category) => category = category;
  void setDescription(String? description) => description = description;
  void setImageUrl(String? imageUrl) => imageUrl = imageUrl;
  void setAccompanyingItems(List<AccompanyingItem>? accompanyingItems) => accompanyingItems = accompanyingItems;
}
