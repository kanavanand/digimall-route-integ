import 'package:flutter/material.dart';
import 'package:prachar/presentation/ui/store/pages/user_orders_list.dart';
import 'package:prachar/constants/constants.dart';

class UserOrdersPage extends StatelessWidget {
  const UserOrdersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ORDERS),
      ),
      body: const UserOrdersList(),
    );
  }
}
