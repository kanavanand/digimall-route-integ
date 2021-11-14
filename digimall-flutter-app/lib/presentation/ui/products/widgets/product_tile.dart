import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prachar/application/home/products/products_bloc.dart';
import 'package:prachar/domain/home/product/product.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/routes/router.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:prachar/constants/constants.dart';

class ProductTile extends StatefulWidget {
  final Product product;
  const ProductTile({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool value;
  void _select(
    String choice,
    BuildContext context,
  ) {
    if (choice == "Edit") {
      ExtendedNavigator.of(context).push(
        Routes.addProductPage,
        arguments: AddProductPageArguments(product: widget.product),
      );
    } else if (choice == "Delete") {
      showAlertDialog(context);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.product.availability;
    });
  }

  @override
  Widget build(BuildContext context) {
    double discount;
    if (widget.product.mrp.toInt() != 0) {
      discount = 100 *
          (widget.product.mrp.toInt() - widget.product.sellingPrice) /
          widget.product.mrp.toInt();
    } else {
      discount = 0;
    }

    const List<String> choices = <String>["Edit", "Delete"];
    return SizedBox(
      height: 155,
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          const Divider(
            height: 4,
            thickness: 3,
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Image.network(
                    widget.product.image,
                    height: 80,
                    width: 80,
                  ),
                  discount.round() > 5
                      ? Container(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 7),
                            child: Text(
                              "${discount.round()}% OFF",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            ),
                          ))
                      : Container(),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget?.product?.name ?? 'Product',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget?.product?.quantity ?? '0',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14.5,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    RichText(
                      text: TextSpan(
                        text: '₹ ${widget?.product?.sellingPrice ?? 0}  ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        children: [
                          if (widget.product.mrp != widget.product.sellingPrice)
                            TextSpan(
                              text: '₹ ${widget.product.mrp}',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 13.5,
                                decoration: TextDecoration.lineThrough,
                              ),
                            )
                        ],
                      ),
                    ),
                    if (widget?.product?.availability ?? false)
                      const Text(
                        IN_STOCK,
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 14,
                        ),
                      )
                    else
                      const Text(
                        OUT_OF_STOCK,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              ),
              Column(
                children: [
                  PopupMenuButton(
                    onSelected: (val) {
                      _select(val as String, context);
                    },
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                    // initialValue: choices[_selection],
                    itemBuilder: (BuildContext context) {
                      return choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Switch(
                    value: value,
                    onChanged: (val) async {
                      await changeProductAvailability(val);
                      setState(() {
                        value = !value;
                      });
                    },
                    inactiveTrackColor: Kolors.primaryColor,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Future<void> changeProductAvailability(bool availability) async {
    assert(availability != null);
    FirebaseAuth auth = FirebaseAuth.instance;
    await FirebaseFirestore.instance.storesCollection
        .doc(auth.currentUser.uid)
        .productsCollection
        .doc(widget.product.productId)
        .update({
      'availability': availability,
    });
  }

  void showAlertDialog(BuildContext context) {
    // set up the button
    final Widget cancelBt = TextButton(
      onPressed: () {
        ExtendedNavigator.of(context).pop();
      },
      child: const Text(CANCEL),
    );
    final Widget yesBt = TextButton(
      onPressed: () {
        ExtendedNavigator.of(context).pop();
        context.read<ProductsBloc>().add(
              ProductsEvent.deleteProduct(
                productId: widget.product.productId,
              ),
            );
      },
      child: const Text(YES),
    );

    // set up the AlertDialog
    final AlertDialog alert = AlertDialog(
      title: const Text(DELETE_PRODUCT),
      content: const Text(DELETE_PRODUCT_WARNING),
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
}

// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     const Icon(
//       Icons.share,
//     ),
//     const SizedBox(
//       width: 10,
//     ),
//     const Text(
//       "Share Product",
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 16,
//       ),
//     ),
//     const SizedBox(
//       height: 20,
//     ),
//   ],
// )
