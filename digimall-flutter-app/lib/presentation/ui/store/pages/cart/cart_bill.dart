import 'package:flutter/material.dart';
import 'package:prachar/domain/user/store_user.dart';
import 'package:prachar/presentation/ui/store/pages/cart/cart.dart';

class CartBill extends StatelessWidget {
  final OrderDetails orderDetails;
  const CartBill({
    Key key,
    @required this.orderDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        14,
      ),
      color: const Color(0xfffffde7),
      child: Column(
        children: [
          RowTileWthPrice(
            text: "Item Total",
            value: "₹ ${orderDetails?.totalPrice ?? 0}",
          ),
          RowTileWthPrice(
            text: "Discount (%)",
            value: "${orderDetails?.discount ?? 0}",
            isHightlight: true,
          ),
          RowTileWthPrice(
            text: "Delivery Charges",
            value: "₹ ${orderDetails?.deliveryCharges ?? 0}",
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Grand Total",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "₹ ${orderDetails?.grandTotal ?? 0}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
