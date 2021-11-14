import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/domain/auth/store.dart';
import 'package:prachar/domain/home/product/product.dart';
import 'package:prachar/domain/user/store_user.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:prachar/presentation/core/pages/app_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prachar/presentation/core/strings.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/core/widgets/loading.dart';
import 'package:prachar/utils/utils.dart';

/// if it is from cart then don't delete from cart list instead set it to 0 else delete from cart
class ItemAddToCart extends StatefulWidget {
  final Store store;
  final String item;
  final String productId;
  final Product product;
  final bool isItFromCart;
  final Function fn;
  final String storeId;
  final String storeName;
  final String storePhoneNumber;
  const ItemAddToCart({
    Key key,
    @required this.item,
    @required this.productId,
    this.storeId,
    this.storeName,
    this.storePhoneNumber,
    this.product,
    this.fn,
    this.store,
    @required this.isItFromCart,
  }) : super(key: key);

  @override
  _ItemAddToCartState createState() => _ItemAddToCartState();
}

class _ItemAddToCartState extends State<ItemAddToCart> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Kolors.primaryColor,
              ),
            ),
          )
        : Container(
            width: 80,
            height: 30,
            decoration: isZero(context)
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(
                      color: Kolors.primaryColor,
                    ),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Kolors.primaryColor,
                    ),
                  ),
            alignment: Alignment.center,
            child: !isZero(context)
                ? InkWell(
                    onTap: () async {
                      if (await isOnline()) {
                        await onItemAddToCart();
                      }
                    },
                    child: const Text(
                      "Add to Cart",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Kolors.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (await isOnline()) {
                            await onRemoveFn();
                          }
                        },
                        child: Container(
                          color: Kolors.primaryColor,
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.remove,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        getQuanity(context),
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () async {
                          if (await isOnline()) {
                            await onAddFn();
                          }
                        },
                        child: Container(
                          color: Kolors.primaryColor,
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
  }

  bool isZero(BuildContext context) {
    if (context
        .read<AuthenticationBloc>()
        .state
        .storeUser
        .cartItemsList
        .containsKey(widget.productId)) {
      // ignore: null_aware_before_operator
      final bool flag = context
              .read<AuthenticationBloc>()
              .state
              .storeUser
              ?.cartItemsList[widget.productId]
              ?.quantity >
          0;
      return flag;
    } else {
      return false;
    }
  }

  String getQuanity(BuildContext context) {
    if (context
        .read<AuthenticationBloc>()
        .state
        .storeUser
        .cartItemsList
        .containsKey(widget.productId)) {
      return '${context.read<AuthenticationBloc>().state.storeUser.cartItemsList[widget.productId].quantity}';
    } else {
      return '0';
    }
  }

  Future<void> onRemoveFn() async {
    setState(() {
      _isLoading = true;
    });
    int quantity = context
        .read<AuthenticationBloc>()
        .state
        .storeUser
        .cartItemsList[widget.productId]
        .quantity;
    if (quantity > 0) {
      final uid = FirebaseAuth.instance.currentUser.uid;
      StoreUser user = navigatorKey.currentState.context
          .read<AuthenticationBloc>()
          .state
          .storeUser;

      if (widget.isItFromCart) {
        Map<String, dynamic> updateData = {
          // 'orderDetails.${Strings.deliveryCharges}':
          //     widget.store.deliveryCharges,
          'orderDetails.${Strings.discount}': FieldValue.increment(0),
          'orderDetails.${Strings.grandTotal}':
              FieldValue.increment(widget.product.sellingPrice * (-1)),
          'orderDetails.${Strings.totalPrice}':
              FieldValue.increment(widget.product.sellingPrice * (-1)),
        };
        user.orderDetails.grandTotal -= widget.product.sellingPrice;
        user.orderDetails.totalPrice -= widget.product.sellingPrice;
        if (quantity == 1) {
          updateData.addAll({'cart.${widget.productId}': FieldValue.delete()});
          print('DELETE PRODUCT');
          user.cartItemsList.remove(widget.productId);
          FirebaseFirestore.instance.userCollection
              .doc(uid)
              .update({'cart.${widget.productId}': FieldValue.delete()});
        } else {
          user.cartItemsList[widget.productId].quantity -= 1;
          user.cartItemsList[widget.productId].totalPrice -=
              widget.product.sellingPrice;
          updateData.addAll({
            'cart.${widget.productId}.quantity': FieldValue.increment(-1),
            'cart.${widget.productId}.totalPrice':
                FieldValue.increment(widget.product.sellingPrice * (-1)),
          });
        }

        await FirebaseFirestore.instance.userCollection
            .doc(uid)
            .update(updateData);
      } else {
        Map<String, dynamic> updateData = {
          // 'orderDetails.${Strings.deliveryCharges}':
          //     widget.store.deliveryCharges,
          'orderDetails.${Strings.discount}': FieldValue.increment(0),
          'orderDetails.${Strings.grandTotal}':
              FieldValue.increment(widget.product.sellingPrice * (-1)),
          'orderDetails.${Strings.totalPrice}':
              FieldValue.increment(widget.product.sellingPrice * (-1)),
        };
        user.orderDetails.grandTotal -= widget.product.sellingPrice;
        user.orderDetails.totalPrice -= widget.product.sellingPrice;
        if (quantity == 1) {
          updateData.addAll({'cart.${widget.productId}': FieldValue.delete()});
          print('DELETE PRODUCT');
          user.cartItemsList.remove(widget.productId);
          FirebaseFirestore.instance.userCollection
              .doc(uid)
              .update({'cart.${widget.productId}': FieldValue.delete()});
        } else {
          user.cartItemsList[widget.productId].quantity -= 1;
          user.cartItemsList[widget.productId].totalPrice -=
              widget.product.sellingPrice;
          updateData.addAll({
            'cart.${widget.productId}.quantity': FieldValue.increment(-1),
            'cart.${widget.productId}.totalPrice':
                FieldValue.increment(widget.product.sellingPrice * (-1)),
          });
        }

        await FirebaseFirestore.instance.userCollection
            .doc(uid)
            .update(updateData);
        // if (quantity == 1) {
        //   user.cartItemsList.remove(widget.productId);
        // } else {
        //   user.cartItemsList[widget.productId].quantity -= 1;

        //   user.orderDetails.grandTotal -= widget.product.sellingPrice;
        //   user.orderDetails.totalPrice -= widget.product.sellingPrice;
        // }
        // await FirebaseFirestore.instance.userCollection.doc(uid).update({
        //   'cart.${widget.productId}':
        //       quantity == 1 ? FieldValue.delete() : FieldValue.increment(-1),
        //   'orderDetails.${Strings.deliveryCharges}':
        //       widget.store.deliveryCharges,
        //   'orderDetails.${Strings.discount}': FieldValue.increment(0),
        //   'orderDetails.${Strings.grandTotal}':
        //       FieldValue.increment(widget.product.sellingPrice * (-1)),
        //   'orderDetails.${Strings.totalPrice}':
        //       FieldValue.increment(widget.product.sellingPrice * (-1)),
        // });
      }

      navigatorKey.currentState.context
          .read<AuthenticationBloc>()
          .add(AuthenticationEvent.userModified(user: user));

      setState(() {});
      if (widget.fn() != null) {
        widget.fn();
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future onAddFn() async {
    setState(() {
      _isLoading = true;
    });
    final uid = FirebaseAuth.instance.currentUser.uid;
    await FirebaseFirestore.instance.userCollection.doc(uid).update({
      'cart.${widget.productId}.quantity': FieldValue.increment(1),
      'cart.${widget.productId}.totalPrice':
          FieldValue.increment(widget.product.sellingPrice),
      'orderDetails.${Strings.discount}': FieldValue.increment(0),
      'orderDetails.${Strings.grandTotal}':
          FieldValue.increment(widget.product.sellingPrice),
      'orderDetails.${Strings.totalPrice}':
          FieldValue.increment(widget.product.sellingPrice),
    });

    StoreUser user = navigatorKey.currentState.context
        .read<AuthenticationBloc>()
        .state
        .storeUser;
    user.orderDetails.grandTotal += widget.product.sellingPrice;
    user.orderDetails.totalPrice += widget.product.sellingPrice;

    user.cartItemsList[widget.productId].quantity += 1;
    user.cartItemsList[widget.productId].totalPrice +=
        widget.product.sellingPrice;

    navigatorKey.currentState.context
        .read<AuthenticationBloc>()
        .add(AuthenticationEvent.userModified(user: user));
    setState(() {});
    if (widget.fn() != null) {
      widget.fn();
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> onItemAddToCart() async {
    setState(() {
      _isLoading = true;
    });
    final uid = FirebaseAuth.instance.currentUser.uid;
    StoreUser user = navigatorKey.currentState.context
        .read<AuthenticationBloc>()
        .state
        .storeUser;
    if (user.cartItemsList.isEmpty) {
      user.orderDetails.deliveryCharges = widget.store.deliveryCharges;
      user.orderDetails.grandTotal = widget.store.deliveryCharges;
      await FirebaseFirestore.instance.userCollection.doc(uid).update({
        'orderDetails.${Strings.deliveryCharges}': widget.store.deliveryCharges,
        'orderDetails.${Strings.grandTotal}': widget.store.deliveryCharges,
      });
    }
    if (user.cartItemsList.isNotEmpty &&
        user.orderDetails.storeId != widget.storeId) {
      showAlertDialog();
    } else {
      Map<String, dynamic> map = {
        'name': widget.product.name,
        'price': widget.product.sellingPrice,
        'totalPrice': widget.product.sellingPrice,
        'quantity': 1,
        'variant': widget.product.quantity
      };

      String storeId = 'storeId';
      String storeName = 'storeName';
      await FirebaseFirestore.instance.userCollection.doc(uid).update({
        'cart.${widget.productId}': map,
        'orderDetails.${Strings.deliveryCharges}': widget.store.deliveryCharges,
        'orderDetails.${Strings.discount}': FieldValue.increment(0),
        'orderDetails.${Strings.grandTotal}':
            FieldValue.increment(widget.product.sellingPrice),
        'orderDetails.${Strings.totalPrice}':
            FieldValue.increment(widget.product.sellingPrice),
        'orderDetails.$storeId': widget.storeId,
        'orderDetails.$storeName': widget.storeName,
      });

      final CartItem cartItem = CartItem.fromJson(map, widget.productId);
      if (user.cartItemsList.containsKey(widget.productId)) {
        user.cartItemsList.update(widget.productId, (value) => cartItem);
      } else {
        user.cartItemsList.putIfAbsent(widget.productId, () => cartItem);
      }

      user.orderDetails.grandTotal += widget.product.sellingPrice;
      user.orderDetails.totalPrice += widget.product.sellingPrice;
      user.orderDetails.storeId = widget.storeId;
      user.orderDetails.storeName = widget.storeName;
      user.orderDetails.storePhoneNumber = widget.storePhoneNumber;
      navigatorKey.currentState.context
          .read<AuthenticationBloc>()
          .add(AuthenticationEvent.userModified(user: user));
      setState(() {});
      if (widget.fn() != null) {
        widget.fn();
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  void showAlertDialog() {
    // set up the button
    final Widget cancelBt = TextButton(
      onPressed: () {
        ExtendedNavigator.of(context).pop();
      },
      child: const Text("Cancel"),
    );
    final Widget yesBt = TextButton(
      onPressed: () {
        addItemFromOtherStore();
        ExtendedNavigator.of(context).pop();
      },
      child: const Text("Yes"),
    );
    StoreUser user = navigatorKey.currentState.context
        .read<AuthenticationBloc>()
        .state
        .storeUser;
    final storeName = user.orderDetails.storeName;

    // set up the AlertDialog
    final AlertDialog alert = AlertDialog(
      title: const Text("Replace cart"),
      content: Text(
          "You have added items from $storeName . Do you really want to empty your cart and add items from this store?"),
      actions: [yesBt, cancelBt],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> addItemFromOtherStore() async {
    setState(() {
      _isLoading = true;
    });
    final uid = FirebaseAuth.instance.currentUser.uid;
    final Map<String, dynamic> map = {
      'name': widget.product.name,
      'price': widget.product.sellingPrice,
      'totalPrice': widget.product.sellingPrice,
      'quantity': 1,
      'variant': widget.product.quantity
    };

    String storeId = 'storeId';
    String storeName = 'storeName';
    StoreUser user = navigatorKey.currentState.context
        .read<AuthenticationBloc>()
        .state
        .storeUser;
    await FirebaseFirestore.instance.userCollection.doc(uid).update({
      'cart': {widget.productId: map},
      'orderDetails.${Strings.deliveryCharges}': widget.store.deliveryCharges,
      'orderDetails.${Strings.discount}': FieldValue.increment(0),
      'orderDetails.${Strings.grandTotal}': widget.product.sellingPrice,
      'orderDetails.${Strings.totalPrice}': widget.product.sellingPrice,
      'orderDetails.$storeId': widget.storeId,
      'orderDetails.$storeName': widget.storeName,
    });

    final CartItem cartItem = CartItem.fromJson(map, widget.productId);
    user.cartItemsList = {};
    user.cartItemsList.putIfAbsent(widget.productId, () => cartItem);
    user.orderDetails.deliveryCharges = widget.store.deliveryCharges;

    user.orderDetails.grandTotal =
        widget.store.deliveryCharges + widget.product.sellingPrice;
    user.orderDetails.totalPrice = widget.product.sellingPrice;
    user.orderDetails.storeId = widget.storeId;
    user.orderDetails.storeName = widget.storeName;

    navigatorKey.currentState.context
        .read<AuthenticationBloc>()
        .add(AuthenticationEvent.userModified(user: user));
    setState(() {});
    Fluttertoast.showToast(msg: "Item added");
    if (widget.fn() != null) {
      widget.fn();
    }
    setState(() {
      _isLoading = false;
    });
  }
}
