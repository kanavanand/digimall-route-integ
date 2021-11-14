import 'package:flutter/material.dart';
import 'package:prachar/domain/auth/store.dart';
import 'package:prachar/domain/home/product/product.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/ui/store/widgets/item_add.dart';

class StoreProductTile extends StatelessWidget {
  final Product product;
  final Function onAddChangeState;
  final String storeId;
  final Store store;
  final String storePhoneNumber;
  final String storeName;
  const StoreProductTile({
    Key key,
    @required this.product,
    @required this.storeId,
    @required this.storePhoneNumber,
    @required this.storeName,
    @required this.store,
    this.onAddChangeState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double discount;
    if (product.mrp.toInt() != 0) {
      discount = 100 *
          (product.mrp.toInt() - product.sellingPrice) /
          product.mrp.toInt();
    } else {
      discount = 0;
    }
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Image.network(
                    product.image,
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
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      product.quantity ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    RichText(
                      text: TextSpan(
                        text: '₹ ${product.sellingPrice}  ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 14.5,
                        ),
                        children: [
                          if (product.mrp != product.sellingPrice)
                            TextSpan(
                              text: '₹ ${product.mrp}',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 13.5,
                                decoration: TextDecoration.lineThrough,
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 6,
                ),
                child: ItemAddToCart(
                    store: store,
                    item: "1",
                    productId: product.productId,
                    product: product,
                    isItFromCart: false,
                    storeId: storeId,
                    storeName: storeName,
                    storePhoneNumber: storePhoneNumber,
                    fn: () {
                      if (onAddChangeState != null) onAddChangeState();
                    }),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
