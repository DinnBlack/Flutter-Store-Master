import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:storemaster/models/categories.dart';
import 'package:storemaster/models/daily_stats.dart';
import 'package:storemaster/models/product.dart';
import 'package:storemaster/models/store_details.dart';

class StoreService {
  final DatabaseReference usersRef = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        'https://store-master-dinnblack-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).ref('users');
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  // Write Data Store
  Future<void> createStore(String storeName) async {
    await usersRef.child(uid).child('userStores').push().set({
      'storeDetails': {
        'storeName': storeName,
        'creationDate': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      },
      'dailyStats': {
        'dailyRevenue': 0,
        'currentOrders': 0,
        'completedOrdersToday': 0,
      },
    });
  }

  // Fetch Daily Stats
  Future<DailyStats?> fetchDailyStats() async {
    try {
      final DatabaseEvent event =
          await usersRef.child(uid).child('userStores').once();
      final DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        final Map<dynamic, dynamic> userStoresRaw =
            snapshot.value as Map<dynamic, dynamic>;
        final Map<String, dynamic> userStores = userStoresRaw.map(
            (key, value) =>
                MapEntry(key.toString(), value as Map<dynamic, dynamic>));
        if (userStores.isNotEmpty) {
          final firstStoreKey = userStores.keys.first;
          final firstStore = userStores[firstStoreKey] as Map<dynamic, dynamic>;
          if (firstStore['dailyStats'] != null) {
            final dailyStatsMap =
                firstStore['dailyStats'] as Map<dynamic, dynamic>;
            return DailyStats.fromMap(
              Map<String, dynamic>.from(dailyStatsMap),
            );
          } else {
            print('dailyStats is missing or null');
          }
        } else {
          print('User Stores is empty');
        }
      } else {
        print('Snapshot value is null');
      }
    } catch (e) {
      print('Error fetching daily stats: $e');
    }
    return null;
  }

  Future<List<Categories?>> fetchCategories() async {
    try {
      final DatabaseEvent event =
          await usersRef.child(uid).child('userStores').once();
      final DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        final Map<dynamic, dynamic> userStoresRaw =
            snapshot.value as Map<dynamic, dynamic>;
        final Map<String, dynamic> userStores = userStoresRaw.map(
            (key, value) =>
                MapEntry(key.toString(), value as Map<dynamic, dynamic>));
        if (userStores.isNotEmpty) {
          final firstStoreKey = userStores.keys.first;
          final firstStore = userStores[firstStoreKey] as Map<dynamic, dynamic>;
          if (firstStore['categories'] != null) {
            final categoriesMap =
                firstStore['categories'] as Map<dynamic, dynamic>;
            return categoriesMap.entries.map((entry) {
              return Categories.fromMap(
                Map<String, dynamic>.from(entry.value as Map<dynamic, dynamic>),
              );
            }).toList();
          } else {
            print('categories is missing or null');
          }
        } else {
          print('User Stores is empty');
        }
      } else {
        print('Snapshot value is null');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
    return [];
  }

  Future<void> addCategoryToStore(Categories category) async {
    try {
      final DatabaseReference storeRef =
          usersRef.child(uid).child('userStores');

      // Fetch the reference to the store
      final DatabaseEvent event = await storeRef.once();
      final DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        final Map<String, dynamic> userStores =
            Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);

        if (userStores.isNotEmpty) {
          final String firstStoreKey = userStores.keys.first;
          final DatabaseReference categoriesRef =
              storeRef.child(firstStoreKey).child('categories');
          await categoriesRef.push().set(category.toMap());

          print('Category added successfully');
        } else {
          print('No stores found');
        }
      } else {
        print('No data found in the snapshot');
      }
    } catch (e) {
      print('Error adding category: $e');
    }
  }

  // Fetch Store Details
  Future<StoreDetails?> fetchStoreDetails() async {
    final DatabaseEvent event =
        await usersRef.child(uid).child('userStores').once();
    final DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      final Map<dynamic, dynamic> userStoresRaw =
          snapshot.value as Map<dynamic, dynamic>;
      final Map<String, dynamic> userStores = userStoresRaw.map((key, value) =>
          MapEntry(key.toString(), value as Map<dynamic, dynamic>));
      if (userStores.length == 1) {
        final firstStoreKey = userStores.keys.first;
        final firstStore = userStores[firstStoreKey] as Map<dynamic, dynamic>;
        if (firstStore['storeDetails'] != null) {
          final storeDetailsMap =
              firstStore['storeDetails'] as Map<dynamic, dynamic>;
          return StoreDetails.fromMap(
            Map<String, dynamic>.from(storeDetailsMap),
          );
        } else {
          print('storeDetails is missing or null');
        }
      } else {
        print('User Stores has more than one entry');
      }
    } else {
      print('Snapshot value is null');
    }
    return null;
  }

  // Fetch Store Details
  Future<List<Product>> fetchProducts() async {
    try {
      final DatabaseEvent event =
          await usersRef.child(uid).child('userStores').once();
      final DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        final Map<dynamic, dynamic> userStoresRaw =
            snapshot.value as Map<dynamic, dynamic>;
        final Map<String, dynamic> userStores = userStoresRaw.map(
            (key, value) =>
                MapEntry(key.toString(), value as Map<dynamic, dynamic>));

        if (userStores.isNotEmpty) {
          final firstStoreKey = userStores.keys.first;
          final firstStore = userStores[firstStoreKey] as Map<dynamic, dynamic>;

          if (firstStore.containsKey('products') &&
              firstStore['products'] != null) {
            final productsMap = firstStore['products'] as Map<dynamic, dynamic>;
            if (productsMap.isNotEmpty) {
              return productsMap.entries.map((entry) {
                final productMap = Map<String, dynamic>.from(entry.value);
                return Product.fromMap(productMap);
              }).toList();
            } else {
              print('Products list is empty');
            }
          } else {
            print('Products is missing or null');
          }
        } else {
          print('User Stores is empty');
        }
      } else {
        print('Snapshot value is null');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
    return [];
  }

  Future<List<Product>> fetchProductsByCategory(String? category) async {
    try {
      final DatabaseEvent event = await usersRef.child(uid).child('userStores').once();
      final DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        final Map<dynamic, dynamic> userStoresRaw = snapshot.value as Map<dynamic, dynamic>;
        final Map<String, dynamic> userStores = userStoresRaw.map((key, value) => MapEntry(key.toString(), value as Map<dynamic, dynamic>));

        if (userStores.isNotEmpty) {
          final firstStoreKey = userStores.keys.first;
          final firstStore = userStores[firstStoreKey] as Map<dynamic, dynamic>;

          if (firstStore.containsKey('products') && firstStore['products'] != null) {
            final productsMap = firstStore['products'] as Map<dynamic, dynamic>;
            if (productsMap.isNotEmpty) {
              final products = productsMap.entries.map((entry) {
                final productMap = Map<String, dynamic>.from(entry.value);
                return Product.fromMap(productMap);
              }).toList();

              if (category != null && category.isNotEmpty) {
                return products.where((product) => product.category == category).toList();
              }

              return products;
            } else {
              print('Products list is empty');
            }
          } else {
            print('Products is missing or null');
          }
        } else {
          print('User Stores is empty');
        }
      } else {
        print('Snapshot value is null');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
    return [];
  }

  // Function to add a product to the store
  Future<void> addProductToStore(Product product) async {
    try {
      final DatabaseReference storeRef =
          usersRef.child(uid).child('userStores');

      // Fetch the reference to the store
      final DatabaseEvent event = await storeRef.once();
      final DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        final Map<String, dynamic> userStores =
            Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);

        if (userStores.isNotEmpty) {
          final String firstStoreKey = userStores.keys.first;
          final DatabaseReference productsRef =
              storeRef.child(firstStoreKey).child('products');
          await productsRef.push().set(product.toJson());

          print('Product added successfully');
        } else {
          print('No stores found');
        }
      } else {
        print('No data found in the snapshot');
      }
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  String formatCurrency(int amount) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'đ',
      decimalDigits: 0,
    );
    String formattedAmount = formatter.format(amount);
    return formattedAmount.replaceAll(RegExp(r'\s+'), '');
  }

// Parse a currency string back to a number
  int parseCurrency(String value) {
    final cleanedValue = value.replaceAll(RegExp(r'[^\d]'), '');
    return int.tryParse(cleanedValue) ?? 0;
  }

  String formatCurrencyByString(String value) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'đ',
      decimalDigits: 0,
    );
    final int parsedValue =
        int.tryParse(value.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
    String formattedAmount = formatter.format(parsedValue);
    return formattedAmount.replaceAll(RegExp(r'\s+'), '');
  }

  Future<List<String>> uploadImages(List<File> images, String idProduct) async {
    List<String> imageUrls = [];
    final DatabaseEvent event =
        await usersRef.child(uid).child('userStores').once();
    final DataSnapshot snapshot = event.snapshot;
    final Map<String, dynamic> userStores =
        Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
    final String firstStoreKey = userStores.keys.first;

    for (File image in images) {
      try {
        final ref = FirebaseStorage.instance.ref(
            '$uid/$firstStoreKey/$idProduct/${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}');
        print(
            '$uid/$firstStoreKey/$idProduct/${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}');
        final uploadTask = ref.putFile(image);
        final snapshot = await uploadTask;
        final imageUrl = await snapshot.ref.getDownloadURL();
        imageUrls.add(imageUrl);
      } catch (e) {
        print('Error uploading image: $e');
      }
    }

    return imageUrls;
  }
}


// Cách fetch dữ liệu
// FutureBuilder<StoreDetails?>(
//             future: StoreService().fetchStoreDetails(),
//             builder: (context, snapshot) {
//               return Text(
//                 '${snapshot.data?.storeName}',
//                 style: TextStyle(
//                   color: AppColors.whiteColor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16.sp,
//                 ),
//               );
//             },
//           ),