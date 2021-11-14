import 'package:flutter/material.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/ui/order/orders_list.dart';
import 'package:prachar/constants/constants.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 30,
                  alignment: Alignment.bottomLeft,
                  child: TabBar(
                      // isScrollable: true,
                      unselectedLabelColor: Colors.grey,
                      // labelPadding: const EdgeInsets.symmetric(
                      //   horizontal: 10,
                      //   vertical: 4,
                      // ),
                      // indicatorSize: TabBarIndicatorSize.tab,
                      indicator: const BoxDecoration(
                        color: Kolors.primaryColor,
                      ),
                      tabs: [
                        Tab(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Kolors.primaryColor,
                              ),
                            ),
                            child: const Text(NEW_ORDERS),
                          ),
                        ),
                        Tab(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Kolors.primaryColor,
                              ),
                            ),
                            child: const Text(COMPLETED),
                          ),
                        ),
                        Tab(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Kolors.primaryColor,
                              ),
                            ),
                            child: const Text("ALL"),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            // RentPage(),
            OrdersListPage(
              orderCategory: OrderCategory.pending,
            ),
            OrdersListPage(
              orderCategory: OrderCategory.completed,
            ),
            OrdersListPage(
              orderCategory: OrderCategory.all,
            ),
          ],
        ),
      ),
    );
  }
}

class OrderButtons extends StatelessWidget {
  const OrderButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 15,
        ),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Kolors.primaryColor,
                    border: Border.all(
                      color: Kolors.primaryColor,
                    ),
                  ),
                  child: Text(
                    "All Orders",
                    textAlign: TextAlign.center,
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(
                      color: Kolors.primaryColor,
                    ),
                  ),
                  child: Text(
                    PENDING,
                    textAlign: TextAlign.center,
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(
                      color: Kolors.primaryColor,
                    ),
                  ),
                  child: Text(
                    COMPLETED,
                    textAlign: TextAlign.center,
                  ),
                )),
          ],
        ));
  }
}
