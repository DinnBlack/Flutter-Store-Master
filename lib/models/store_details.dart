class StoreDetails {
  final String storeName;
  final String creationDate;

  StoreDetails({
    required this.storeName,
    required this.creationDate,
  });

  factory StoreDetails.fromMap(Map<String, dynamic> map) {
    return StoreDetails(
      storeName: map['storeName'] ?? '',
      creationDate: map['creationDate'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeName': storeName,
      'creationDate': creationDate,
    };
  }
}
