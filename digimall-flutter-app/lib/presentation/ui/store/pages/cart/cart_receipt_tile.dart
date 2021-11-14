import 'package:flutter/material.dart';
import 'package:prachar/domain/user/store_user.dart';

class CartReceiptTile extends StatelessWidget {
  final CartItem cartItem;

  const CartReceiptTile({
    Key key,
    @required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${cartItem.quantity} X ${cartItem.variant}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '₹ ${cartItem.totalPrice}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 2,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
