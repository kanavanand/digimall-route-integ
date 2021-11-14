import 'package:firebase_auth/firebase_auth.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/domain/auth/store.dart';
import 'package:prachar/domain/home/product/product.dart';
import 'package:prachar/domain/user/store_user.dart';
import 'package:prachar/presentation/core/pages/app_widget.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/core/widgets/loading.dart';
import 'package:prachar/presentation/routes/router.gr.dart';
import 'package:prachar/presentation/ui/store/pages/cart/cart_item_tile.dart';
import 'package:prachar/presentation/ui/store/pages/delivery_address.dart';
import 'package:prachar/presentation/ui/store/widgets/addresses_dialog.dart';
import 'package:prachar/presentation/ui/store/pages/cart/cart_bill.dart';
import 'package:prachar/presentation/ui/store/widgets/item_add.dart';
import 'package:truncate/truncate.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  final Store store;
  const CartPage({
    Key key,
    @required this.store,
  }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoading = false;
  String addressForOrder;

  Widget cartItemsList(Map<String, CartItem> mapList) {
    List<Widget> list = [];
    mapList.forEach((key, value) {
      list.add(
        CartItemTile(
            cartItem: mapList[key],
            id: key,
            fn: () {
              setState(() {});
            }),
      );
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        setState(() {
          addressForOrder = state.storeUser.addresses.isNotEmpty
              ? state.storeUser.addresses.last
              : null;
        });
      },
      builder: (context, state) {
        if (state.storeUser.cartItemsList.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              iconTheme: const IconThemeData(
                color: Colors.grey, //change your color here
              ),
              backgroundColor: Colors.white,
              title: Text("Cart",
                  style: TextStyle(color: Colors.black45, fontSize: 20)),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Your cart is empty"),
                  Text("Add something from stores."),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Kolors.primaryColor,
                      ),
                      onPressed: () {
                        ExtendedNavigator.of(context).pop();
                      },
                      child: Text("BROWSE STORES"))
                ],
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            iconTheme: const IconThemeData(
              color: Colors.grey, //change your color here
            ),
            backgroundColor: Colors.white,
            title: Text("Confirm Order",
                style: TextStyle(color: Colors.black45, fontSize: 20)),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 15,
            ),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Item Name",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      "Quantity",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                cartItemsList(state.storeUser.cartItemsList),
                CartBill(
                  orderDetails: state.storeUser.orderDetails,
                ),
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  "Pay Using",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // This goes to the build method
                RadioListTile(
                  value: 2,
                  groupValue: 2,
                  title: const Text("Cash On Delivery"),
                  onChanged: (val) {
                    // setSelectedRadioTile(val);
                  },
                  activeColor: Kolors.primaryColor,
                  selected: false,
                ),
                RadioListTile(
                  value: 2,
                  groupValue: false,
                  title: const Text("PayTM"),
                  onChanged: (val) {
                    FlushbarHelper.createError(
                            message: "PayTM is not available currently.")
                        .show(context);
                    // setSelectedRadioTile(val);
                  },
                  activeColor: Colors.red,
                  selected: false,
                ),
                RadioListTile(
                  value: 2,
                  groupValue: false,
                  title: const Text("Google Pay"),
                  onChanged: (val) {
                    FlushbarHelper.createError(
                            message: "Google Pay is not available currently.")
                        .show(context);
                    // setSelectedRadioTile(val);
                  },
                  activeColor: Colors.red,
                  selected: false,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.only(top: 11, bottom: 5, left: 30),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Kolors.primaryColor,
                  ),
                  addressForOrder != null
                      ? Text(addressForOrder)
                      : state.storeUser.addresses.isNotEmpty
                          ? Text(state.storeUser.addresses.last)
                          : Text("No Addresses Saved"),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonTheme(
                  minWidth: 150.0,
                  child: RaisedButton(
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Kolors.primaryColor,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                    onPressed: () async {
                      if (state.storeUser.addresses == null ||
                          (state.storeUser.addresses?.isEmpty ?? false)) {
                        final String selectedAddress =
                            await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DeliveryAddressPage(),
                          ),
                        );
                        setState(() {
                          addressForOrder = selectedAddress;
                        });
                      } else {
                        final String selectedAddress =
                            await showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return AddressesDialog(
                                    addressesList: state.storeUser.addresses,
                                    store: widget.store,
                                  );
                                });
                        if (selectedAddress != null) {
                          setState(() {
                            addressForOrder = selectedAddress;
                          });
                        }
                      }
                      print("Selected address is $addressForOrder");
                      print(
                          "address form state is ${state.storeUser.addresses}");
                    },
                    child: Text(
                      (state.storeUser.addresses == null ||
                              (state.storeUser.addresses?.isEmpty ?? false))
                          ? "Set Address"
                          : "Change Address",
                      style: TextStyle(
                        color: Kolors.primaryColor,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 40),
                    primary: Kolors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                  ),
                  onPressed: () async {
                    if (!isLoading) {
                      if (state.storeUser.addresses == null ||
                          (state.storeUser.addresses?.isEmpty ?? false)) {
                        final String selectedAddress =
                            await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DeliveryAddressPage(),
                          ),
                        );
                        setState(() {
                          addressForOrder = selectedAddress;
                        });
                      } else {
                        await confirmOrder(
                          context,
                          addressForOrder ?? state.storeUser.addresses.last,
                        );
                      }
                    }
                  },
                  child: isLoading
                      ? SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator())
                      : Text(
                          "Place Order",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> confirmOrder(BuildContext context, String address) async {
    final StoreUser user = context.read<AuthenticationBloc>().state.storeUser;
    if (widget.store.minimumOrderAmount > user.orderDetails.grandTotal) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(
                  "Add product worth ₹${widget.store.minimumOrderAmount - user.orderDetails.grandTotal} more to place an order",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Okay!"),
                  ),
                ],
              ));

      return;
    }
    setState(() {
      isLoading = true;
    });
    final uid = FirebaseAuth.instance.currentUser.uid;
    if (user.cartItemsList.isEmpty) {
      FlushbarHelper.createError(
              message: "Please add something to cart to place your order")
          .show(context);
      return;
    }
    Map<String, Map<String, dynamic>> cartMap = {};
    user.cartItemsList.forEach((key, value) {
      Map<String, dynamic> map = value.toJson();
      cartMap.putIfAbsent(key, () => map);
    });

    final Map<String, dynamic> map = {
      'address': address,
      'orderDetails': user.orderDetails.toJson(),
      'cart': cartMap,
      'items': user.cartItemsList.length,
      'orderNo': 0,
      'orderStatus': 'pending',
      'payment': 'Cash',
      'timestamp': Timestamp.now(),
      'userName': user.name ?? 'UserName',
      'orderedBy': uid,
      'storeId': user.orderDetails.storeId,
      'storeName': user.orderDetails.storeName ?? 'Store name',
      'userContactNo': FirebaseAuth.instance.currentUser.phoneNumber,
      'sellerContactNo': user.orderDetails.storePhoneNumber ?? "",
    };

    await FirebaseFirestore.instance.allOrdersCollection
        .doc()
        .set(map)
        .then((value) {});

    //Save to Favourite after placing order
    await FirebaseFirestore.instance.storesCollection
        .doc(user.orderDetails.storeId)
        .update({
      'savedBy': FieldValue.arrayUnion([uid])
    });

    final Map<String, dynamic> body = {
      "seller": map["storeName"],
      "buyer": map["userContactNo"],
      "address": map['address'],
      "total_item": map['items'].toString(),
      "cartValue": map["orderDetails"].toString()
    };

    try {
      http.Response res = await http.post(
          Uri.parse("https://prachaaradmin2.azurewebsites.net/v1/notifyorder"),
          body: body); // post api call
    } catch (e) {
      print("Cannot implement post call for order");
      print(e);
    }
    var userCollection;
    await FirebaseFirestore.instance.userCollection.doc(uid).update({
      'cart': FieldValue.delete(),
      'orderDetails': {
        'discount': 0,
        'deliveryCharges': 0,
        'totalPrice': 0,
        'grandTotal': 0,
      },
    });
    Fluttertoast.showToast(msg: "Order placed successfully");

    user.cartItemsList = {};
    user.orderDetails = OrderDetails.empty();
    user.store.homeAnalytics.orders += 1;

    context
        .read<AuthenticationBloc>()
        .add(AuthenticationEvent.userModified(user: user));
    if (user.isStore) {
      String orderStr = 'orders';

      await FirebaseFirestore.instance.storesCollection.doc(uid).update({
        'analytics.$orderStr': FieldValue.increment(1),
      });
    }

    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pushReplacementNamed(Routes.userOrdersPage);
  }
}

class RowTileWthPrice extends StatelessWidget {
  final String text, value;
  final bool isHightlight;
  const RowTileWthPrice({
    Key key,
    @required this.text,
    @required this.value,
    this.isHightlight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 3,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 12,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isHightlight ? Colors.red : Colors.black,
              fontSize: 13,
            ),
          )
        ],
      ),
    );
  }
}
