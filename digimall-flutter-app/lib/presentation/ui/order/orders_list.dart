import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prachar/domain/home/orders/order.dart';
import 'package:prachar/presentation/ui/order/widgets/order_detail_tile.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:prachar/presentation/ui/store/pages/user_orders_list.dart';

enum OrderCategory {
  all,
  pending,
  completed,
}

class OrdersListPage extends StatelessWidget {
  final OrderCategory orderCategory;
  const OrdersListPage({
    Key key,
    @required this.orderCategory,
  }) : super(key: key);

  Widget ordersList() {
    final auth = FirebaseAuth.instance;

    final allOrdersQuery = FirebaseFirestore.instance.allOrdersCollection
        .where('storeId', isEqualTo: auth.currentUser.uid)
        .orderBy('timestamp', descending: true)
        .snapshots();
    final pendingOrdersQuery = FirebaseFirestore.instance.allOrdersCollection
        .where('storeId', isEqualTo: auth.currentUser.uid)
        .where('orderStatus', isEqualTo: 'pending')
        .orderBy('timestamp', descending: true)
        .snapshots();
    final confirmedOrdersQuery = FirebaseFirestore.instance.allOrdersCollection
        .where('storeId', isEqualTo: auth.currentUser.uid)
        .where('orderStatus', isEqualTo: 'confirmed')
        .orderBy('timestamp', descending: true)
        .snapshots();
    return StreamBuilder(
      stream: orderCategory == OrderCategory.all
          ? allOrdersQuery
          : orderCategory == OrderCategory.completed
              ? confirmedOrdersQuery
              : pendingOrdersQuery,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length as int,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  final DocumentSnapshot doc =
                      snapshot.data.docs[index] as DocumentSnapshot;
                  final Order order = Order.fromJson(doc.data(), doc.id);
                  return OrderDetailTile(
                    order: order,
                    orderType: OrderType.store,
                  );
                })
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ordersList(),
    );
  }
}
