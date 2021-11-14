import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prachar/domain/user/store_user.dart';

enum OrderStatus { pending, confirmed, rejected, cancelled }

class Order {
  OrderDetails orderDetails;
  Map<String, CartItem> cartItemsList;
  String userName;
  int items, orderNo;
  String payment, address;
  Timestamp timestamp;
  OrderStatus orderStatus;
  String id, orderedBy, storeId;
  String reason, storeName, userContactNo, sellerContactNo, deliveryEstimate;

  Order(
    this.address,
    this.items,
    this.orderNo,
    this.orderStatus,
    this.payment,
    this.timestamp,
    this.userName,
    this.id,
    this.cartItemsList,
    this.orderDetails,
    this.orderedBy,
    this.storeId,
    this.reason,
    this.storeName,
    this.userContactNo,
    this.sellerContactNo,
    this.deliveryEstimate,
  );

  Order.fromJson(
    Map<String, dynamic> map,
    String key,
  ) {
    userName = map['userName'] as String ?? 'UserName';
    items = map['items'] as int ?? 0;
    orderNo = map['orderNo'] as int ?? 0;
    payment = map['payment'] as String ?? "Not available";
    address = map['address'] as String ?? 'Not available';
    timestamp = map['timestamp'] as Timestamp;
    reason = map['reason'] as String ?? '';
    storeName = map['storeName'] as String ?? 'Store name';
    userContactNo = map['userContactNo'] as String ?? 'Contact No';
    deliveryEstimate = map['deliveryEstimate'] as String ?? 'N/A';
    // ignore: prefer_initializing_formals
    id = key;
    orderDetails =
        OrderDetails.fromJson(map['orderDetails'] as Map<String, dynamic>);
    cartItemsList = {};
    (map['cart'] as Map<String, dynamic>).forEach((key, value) {
      CartItem item = CartItem.fromJson(value as Map<String, dynamic>, key);
      cartItemsList.putIfAbsent(key, () => item);
    });
    // cartItemsList = (map['cart'] as List)
    //         .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
    //         .toList() ??
    //     [];
    orderStatus = (map['orderStatus'] as String) == 'pending'
        ? OrderStatus.pending
        : map['orderStatus'] as String == 'confirmed'
            ? OrderStatus.confirmed
            : map['orderStatus'] as String == 'rejected'
                ? OrderStatus.rejected
                : map['orderStatus'] as String == 'pending'
                    ? OrderStatus.pending
                    : OrderStatus.cancelled;
    orderedBy = map['orderedBy'] as String ?? '';
    storeId = map['storeId'] as String ?? '';
    sellerContactNo = map['sellerContactNo'] as String ?? '';
  }
}
