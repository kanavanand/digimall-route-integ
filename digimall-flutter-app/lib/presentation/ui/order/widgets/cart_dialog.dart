import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prachar/domain/home/orders/order.dart';
import 'package:prachar/domain/user/store_user.dart';
import 'package:prachar/presentation/ui/store/pages/cart/cart_bill.dart';
import 'package:prachar/presentation/ui/store/pages/cart/cart_receipt_tile.dart';
import 'package:prachar/presentation/ui/store/pages/user_orders_list.dart';
import 'package:url_launcher/url_launcher.dart';

class CartDialog extends StatelessWidget {
  final Order order;
  final OrderType orderType;
  const CartDialog({
    Key key,
    @required this.order,
    @required this.orderType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var reqNumber = orderType == OrderType.store
        ? order.userContactNo
        : order.sellerContactNo;
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            const SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                ExtendedNavigator.of(context).pop();
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            if (order.sellerContactNo.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 15,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              orderType != OrderType.store
                                  ? "Seller's Details"
                                  : "Buyer's Details",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 17),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Image.network(
                                  "https://cdn3.iconfinder.com/data/icons/2018-social-media-logotypes/1000/2018_social_media_popular_app_logo-whatsapp-512.png"),
                              iconSize: 40,
                              onPressed: () => _launchURL(reqNumber),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            IconButton(
                              icon: Icon(Icons.call),
                              iconSize: 40,
                              onPressed: () => _makePhoneCall(reqNumber),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Contact No",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          orderType == OrderType.store
                              ? order.userContactNo
                              : order.sellerContactNo,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Delivery Estimate",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          order.deliveryEstimate,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            else
              Container(),
            cartItemsList(order.cartItemsList),
            CartBill(
              orderDetails: order.orderDetails,
            ),
            if (order.orderStatus == OrderStatus.pending &&
                orderType != OrderType.store)
              Align(
                alignment: Alignment.bottomLeft,
                child: TextButton(
                  style: TextButton.styleFrom(primary: Colors.grey),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        TextEditingController cancellationReasonTec =
                            TextEditingController();
                        return AlertDialog(
                          title: Text("Are you sure?"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: cancellationReasonTec,
                                decoration: InputDecoration(
                                    labelText: "Reason for cancellation"),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  await cancelOrderByUser(
                                    order.id,
                                    cancellationReasonTec.text,
                                  );
                                  Navigator.pop(context);
                                },
                                child: Text("Yes")),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("No"))
                          ],
                        );
                      },
                    );
                  },
                  child: const Text("Cancel Order"),
                ),
              )
            else
              Container(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  // Widget cartItemsList(List<CartItem> list) {
  Widget cartItemsList(Map<String, CartItem> mapList) {
    List<Widget> list = [];
    mapList.forEach((key, value) {
      list.add(CartReceiptTile(
        cartItem: mapList[key],
      ));
    });

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return list[index];
      },
      itemCount: list.length,
    );
  }
}

_launchURL(String number) async {
  var URL =
      'https://api.whatsapp.com/send/?phone=$number&text=Hello%20,%20I%20found%20you%20on%20DiGi%20Mall%20&app_absent=0';
  if (await canLaunch(URL))
    await launch(URL);
  else
    throw "Could not launch $URL";
}

Future<void> _makePhoneCall(String number) async {
  var url = 'tel:$number';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> cancelOrderByUser(
    String orderId, String cancellationReason) async {
  await FirebaseFirestore.instance.collection("Orders").doc(orderId).update(
    {
      "orderStatus": "cancelled",
      "cancellationReason": cancellationReason,
    },
  );
}
