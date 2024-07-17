class AccompanyingItem {
  final String id;
  final String name;
  final double price;
  final double? costPrice;
  final String? description;

  AccompanyingItem({
    required this.id,
    required this.name,
    required this.price,
    this.costPrice,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'costPrice': costPrice,
      'description': description,
    };
  }

  factory AccompanyingItem.fromJson(Map<String, dynamic> json) {
    return AccompanyingItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      costPrice: json['costPrice'],
      description: json['description'],
    );
  }

  // Getters
  String get getId => id;
  String get getName => name;
  double get getPrice => price;
  double? get getCostPrice => costPrice;
  String? get getDescription => description;

  // Setters
  void setId(String id) => id = id;
  void setName(String name) => name = name;
  void setPrice(double price) => price = price;
  void setCostPrice(double? costPrice) => costPrice = costPrice;
  void setDescription(String? description) => description = description;
}
