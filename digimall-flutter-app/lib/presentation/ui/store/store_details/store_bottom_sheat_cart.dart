import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:prachar/domain/auth/store.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/routes/router.gr.dart';
import 'package:prachar/constants/constants.dart';

class StoreBottomSheatCart extends StatelessWidget {
  final Function updateCartFn;
  final Store store;
  const StoreBottomSheatCart({
    Key key,
    @required this.updateCartFn,
    @required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Kolors.primaryColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.shopping_cart,
            color: Colors.white,
            size: 22,
          ),
          GestureDetector(
            onTap: () {
              ExtendedNavigator.of(context)
                  .push(Routes.cartPage,
                      arguments: CartPageArguments(store: store))
                  .then((value) {
                updateCartFn();
              });
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                color: Kolors.primaryColor,
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
              child: const Text(
                VIEW_CART,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Row(
//                 children: [
//                   const Text(
//                     "View Cart",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const Icon(
//                     Icons.arrow_forward,
//                     size: 13,
//                     color: Colors.white,
//                   ),
//                 ],
//               ),
