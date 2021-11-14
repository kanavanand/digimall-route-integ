import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/presentation/ui/store/pages/cart/cart.dart';
import 'package:prachar/constants/constants.dart';

class ConfirmOrderPage extends StatelessWidget {
  const ConfirmOrderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                STORE_NAME,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const Text(
                ORDER_ID,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          actions: [
            const Icon(Icons.call),
            const SizedBox(
              width: 14,
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 12,
          ),
          child: ListView(
            children: [
              const Text(
                ORDER_PLACED,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 15,
                ),
                child: ListView.builder(
                  itemCount: state.storeUser.cartItemsList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return RowTileWthPrice(
                        text: state.storeUser.cartItemsList[index].name,
                        value:
                            "₹ ${state.storeUser.cartItemsList[index].totalPrice}");
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Divider(
                  thickness: 2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: RowTileWthPrice(
                  text: TOTAL,
                  value: "₹ ${state.storeUser.orderDetails.grandTotal}",
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
