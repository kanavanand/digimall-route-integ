import 'package:flutter/material.dart';
import 'package:prachar/domain/home/product/product.dart';
import 'package:prachar/domain/user/store_user.dart';
import 'package:prachar/presentation/ui/store/widgets/item_add.dart';

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;
  final String id;
  final Function fn;
  const CartItemTile({
    Key key,
    @required this.cartItem,
    @required this.id,
    this.fn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  cartItem.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ItemAddToCart(
                item: '${cartItem.quantity}',
                productId: id,
                isItFromCart: true,
                product:
                    Product(name: cartItem.name, sellingPrice: cartItem.price),
                fn: fn,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹ ${cartItem.price}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
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
