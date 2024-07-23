class Categories {
  String name;
  int itemCount;

  Categories({
    required this.name,
    required this.itemCount,
  });

  // Method to convert a Categories object to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'itemCount': itemCount,
    };
  }

  // Method to create a Categories object from a map
  factory Categories.fromMap(Map<String, dynamic> map) {
    return Categories(
      name: map['name'],
      itemCount: map['itemCount'],
    );
  }

  String get getName => name;
  int get getItemCount => itemCount;

  // Setters
  void setName(String name) => name = name;
  void setItemCount(int itemCount) => itemCount = itemCount;
}
