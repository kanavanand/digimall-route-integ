import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prachar/domain/home/orders/order.dart';
import 'package:prachar/presentation/ui/store/pages/user_orders_list.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderReceipt extends StatelessWidget {
  final Order order;
  final OrderType orderType;
  const OrderReceipt({Key key, this.order, this.orderType}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    final String reqNumber = orderType == OrderType.store
        ? order.userContactNo
        : order.sellerContactNo;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Order Receipt"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  order.storeName,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  order.sellerContactNo,
                  style: TextStyle(
                      // fontSize: 25,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Image.network(
                            "https://cdn3.iconfinder.com/data/icons/2018-social-media-logotypes/1000/2018_social_media_popular_app_logo-whatsapp-512.png"),
                        iconSize: 40,
                        onPressed: () {
                          _launchURL(reqNumber);
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.phone,
                        ),
                        onPressed: () {
                          _makePhoneCall(reqNumber);
                        }),
                  ],
                ),
                Divider(
                  thickness: 3,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Item"), Text("Price")],
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                        itemCount: order.cartItemsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final cartItemKey =
                              order.cartItemsList.keys.elementAt(index);
                          final cartItem = order.cartItemsList[cartItemKey];
                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  cartItem.name,
                                  softWrap: true,
                                  maxLines: 3,
                                ),
                              ),
                              Text("₹ ${cartItem.price.toString()}"),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
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
