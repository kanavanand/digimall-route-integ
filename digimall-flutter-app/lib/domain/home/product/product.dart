import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String name;
  String code;
  String quantity;
  String category;
  int mrp;
  int sellingPrice;
  String desc;
  String image;
  Timestamp timestamp;
  String productId;
  bool availability;

  Product({
    this.category,
    this.code,
    this.desc,
    this.image,
    this.mrp,
    this.name,
    this.quantity,
    this.sellingPrice,
    this.timestamp,
    this.productId,
    this.availability,
  });

  Product.fromJson(
    Map<String, dynamic> map,
  ) {
    category = map['category'] as String;
    code = map['code'] as String;
    desc = map['desc'] as String;
    image = map['image'] as String;
    mrp = map['mrp'] as int;
    name = map['name'] as String;
    quantity = map['quantity'] as String;
    sellingPrice = map['sellingPrice'] as int;
    timestamp = map['timestamp'] as Timestamp;
    productId = map['productId'] as String;
    availability = map['availability'] as bool;
  }
}
