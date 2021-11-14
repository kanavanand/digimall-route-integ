import 'package:flutter_geocoder/geocoder.dart';
import 'package:prachar/domain/auth/store.dart';

class StoreUser {
  OrderDetails orderDetails;
  List<String> addresses;
  Map<String, CartItem> cartItemsList;
  bool isStore;
  Store store;
  String name, image;
  String openAs;
  List<Address> locationAddresses;
  StoreUser(
    this.addresses,
    this.cartItemsList,
    this.orderDetails,
    this.store,
    this.image,
    this.openAs,
    this.locationAddresses,
  ) : isStore = false;

  StoreUser.fromJson(
      Map<String, dynamic> map, Map<String, dynamic> storeMap, String id) {
    final list = map['locationAddresses'] as List;
    if (list != null) {
      final List<Address> locationAddressList =
          list.map((i) => Address.fromMap(i as Map<dynamic, dynamic>)).toList();
      locationAddresses = locationAddressList ?? [];
    } else {
      locationAddresses = [];
    }

    orderDetails = map['orderDetails'] != null
        ? OrderDetails.fromJson(map['orderDetails'] as Map<String, dynamic>)
        : OrderDetails.empty();
    addresses =
        (map['addresses'] as List ?? []).map((e) => e as String).toList() ?? [];
    cartItemsList = {};
    (map['cart'] as Map<String, dynamic> ?? {}).forEach((key, value) {
      CartItem item = CartItem.fromJson(value as Map<String, dynamic>, key);
      cartItemsList.putIfAbsent(key, () => item);
    });
    isStore = map['isStore'] as bool ?? false;
    store = storeMap != null ? Store.fromJson(storeMap) : Store.empty();
    if (map['name'] as String != null) {
      name = map['name'] as String;
    }
    if (map['image'] as String != null) {
      image = map['image'] as String;
    }
    openAs = map['openAs'] as String ?? 'buyer';
  }

  StoreUser.empty() {
    name = "Buyer's name";
    image = '';
    openAs = 'buyer';
    store = Store.empty();
    isStore = false;
    cartItemsList = {};
    addresses = [];
    orderDetails = OrderDetails.empty();
    locationAddresses = [];
  }
}

class CartItem {
  String name;
  String id;
  int price;
  int quantity;
  int totalPrice;
  String variant;

  CartItem(
    this.name,
    this.price,
    this.quantity,
    this.variant,
    this.totalPrice,
  );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'variant': variant,
      'totalPrice': totalPrice,
    };
  }

  CartItem.fromJson(Map<String, dynamic> map, String key) {
    name = map['name'] as String ?? '';
    price = map['price'] as int ?? 0;
    quantity = map['quantity'] as int ?? 0;
    totalPrice = map['totalPrice'] as int ?? 0;
    variant = map['variant'] as String ?? "N/A";
    id = key;
  }
}

class OrderDetails {
  int totalPrice, grandTotal, deliveryCharges, discount;
  String storeId, storeName, storePhoneNumber;
  OrderDetails(
    this.deliveryCharges,
    this.discount,
    this.grandTotal,
    this.totalPrice,
    this.storeId,
    this.storePhoneNumber,
    this.storeName,
  );

  OrderDetails.empty() {
    totalPrice = 0;
    grandTotal = 0;
    deliveryCharges = 0;
    discount = 0;
    storeId = '';
    storePhoneNumber = '';
    storeName = '';
  }

  Map<String, dynamic> toJson() {
    return {
      'totalPrice': totalPrice,
      'grandTotal': grandTotal,
      'deliveryCharges': deliveryCharges,
      'discount': discount,
      'storeId': storeId,
      'storeName': storeName,
      'storePhoneNumber': storePhoneNumber,
    };
  }

  OrderDetails.fromJson(Map<String, dynamic> map) {
    totalPrice = map['totalPrice'] as int ?? 0;
    grandTotal = map['grandTotal'] as int ?? 0;
    deliveryCharges = map['deliveryCharges'] as int ?? 0;
    discount = map['discount'] as int ?? 0;
    storeId = map['storeId'] as String ?? '';
    storeName = map['storeName'] as String ?? '';
    storePhoneNumber = map['storePhoneNumber'] as String ?? '';
  }
}
