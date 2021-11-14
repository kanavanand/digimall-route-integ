import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prachar/domain/home/orders/order.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:prachar/presentation/ui/order/widgets/order_detail_tile.dart';
import 'package:prachar/presentation/core/styles/colors.dart';

enum OrderType {
  user,
  store,
}

class UserOrdersList extends StatelessWidget {
  const UserOrdersList({Key key}) : super(key: key);

  Widget ordersList() {
    final auth = FirebaseAuth.instance;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.allOrdersCollection
          .where('orderedBy', isEqualTo: auth.currentUser.uid)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
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
                    orderType: OrderType.user,
                  );
                })
            : Container();
        // : SizedBox(
        //     height: MediaQuery.of(context).size.height + 200,
        //     width: MediaQuery.of(context).size.width,
        //     child: Column(
        //       children: <Widget>[
        //         SvgPicture.asset(
        //           'assets/images/orders.svg',
        //           height: 200,
        //         ),
        //       ],
        //     ),
        //   );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Orders",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Kolors.primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          )),
                      // Image.asset("assets/images/delivery_boy.png")
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            color: Kolors.primaryBackgroundColor,
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: Kolors.primaryBackgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: ordersList(),
                )),
          ),
        ],
      ),
    );
  }
}
