import 'package:prachar/domain/home/home_analytics.dart';

class Store {
  String name, address, category, image, id, number, dynamicLinkUrl;
  int rating, deliveryCharges, minimumOrderAmount;
  HomeAnalytics homeAnalytics;
  List productCategories;

  Store({
    this.address,
    this.category,
    this.image,
    this.name,
    this.homeAnalytics,
    this.rating,
    this.id,
    this.productCategories,
    this.number,
    this.dynamicLinkUrl,
    this.deliveryCharges,
    this.minimumOrderAmount,
  });

  Store.fromJson(Map<String, dynamic> map) {
    address = map['address'] as String ?? '';
    name = map['name'] as String ?? '';
    image = map['image'] as String ?? '';
    category = map['category'] as String ?? '';
    rating = map['rating'] as int ?? 0;
    id = map['id'] as String ?? '';
    productCategories = map['productCategories'] as List ?? [];
    number = map['number'] as String ?? '';
    homeAnalytics =
        HomeAnalytics.fromJson(map['analytics'] as Map<String, dynamic>) ??
            HomeAnalytics.empty();
    dynamicLinkUrl = map['dynamicLinkUrl'] as String ?? '';
    minimumOrderAmount = map['minimumOrderAmount'] as int ?? 0;
    deliveryCharges = map['deliveryCharges'] as int ?? 0;
    // ignore: prefer_initializing_formals
  }

  Store.empty() {
    address = '';
    name = 'Store name';
    image = '';
    category = '';
    rating = 0;
    id = '';
    homeAnalytics = HomeAnalytics.empty();
    productCategories = [];
    number = '';
    deliveryCharges = 0;
    minimumOrderAmount = 0;
    dynamicLinkUrl = '';
  }

  String toString() {
    return address +
        "  " +
        category +
        "  " +
        image +
        "  " +
        name +
        "    " +
        '$rating' +
        "   " +
        id +
        dynamicLinkUrl;
  }
}
