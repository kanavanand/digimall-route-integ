import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/application/home/orders/orders_bloc.dart';
import 'package:prachar/domain/home/orders/order.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/ui/order/widgets/cart_dialog.dart';
import 'package:prachar/presentation/ui/order/widgets/reject_bottom_sheat.dart';
import 'package:prachar/presentation/ui/store/pages/cart/order_receipt.dart';
import 'package:prachar/presentation/ui/store/pages/user_orders_list.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prachar/constants/constants.dart';

class OrderDetailTile extends StatefulWidget {
  final Order order;
  final OrderType orderType;
  const OrderDetailTile({
    Key key,
    @required this.order,
    @required this.orderType,
  }) : super(key: key);

  @override
  _OrderDetailTileState createState() => _OrderDetailTileState();
}

class _OrderDetailTileState extends State<OrderDetailTile> {
  String dropdownValue = 'Soon';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return CartDialog(
                order: widget.order,
                orderType: widget.orderType,
              );
            });
      },
      child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          padding: const EdgeInsets.all(
            14,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            boxShadow: [
              const BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image(
                        image: AssetImage("assets/images/shopping_bag.png"),
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        widget.orderType == OrderType.user
                            ? widget.order.storeName ?? ''
                            : widget.order.userContactNo,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Text(
                    timeago.format(widget.order.timestamp.toDate()),
                    style: (widget.order.reason.isEmpty)
                        ? const TextStyle(
                            color: Colors.lightGreen,
                            fontSize: 13,
                            fontStyle: FontStyle.italic, // italic
                          )
                        : TextStyle(
                            color: Colors.redAccent,
                            fontSize: 13,
                            fontStyle: FontStyle.italic, // italic
                          ),
                  ),
                  // IconButton(
                  //   icon: Icon(Icons.arrow_forward_ios),
                  //   onPressed: () {
                  //     Navigator.of(context).push(CupertinoPageRoute(
                  //         builder: (_) => OrderReceipt(
                  //               order: widget.order,
                  //               orderType: widget.orderType,
                  //             )));
                  //   },
                  // ),
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        KeyValuePair(
                          name: ORDER_NUMBER,
                          value: '${widget.order.orderNo}',
                        ),
                        KeyValuePair(
                          name: TOTAL_ITEMS,
                          value: '${widget.order.items}',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        KeyValuePair(
                          name: TOTAL_COST,
                          value: '₹ ${widget.order.orderDetails.grandTotal}',
                        ),
                        KeyValuePair(
                          name: PAYMENT,
                          value: widget.order.payment,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              addressWidget(),
              if (widget.order.reason.isNotEmpty)
                reasonWidget()
              else
                Container(),
              findRightWidget(
                context,
                widget.order.orderDetails.grandTotal,
              ),
            ],
          )),
    );
  }

  Widget addressWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on,
              size: 15,
              color: Colors.pink,
            ),
            const Text(
              ADDRESS_,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          widget.order.address,
          style: TextStyle(
            color: Colors.black54,
            fontStyle: FontStyle.italic,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget reasonWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          REASON,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          widget.order.reason,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget findRightWidget(
    BuildContext context,
    int sale,
  ) {
    if (OrderStatus.confirmed == widget.order.orderStatus) {
      return confirmOrder(context);
    } else if (widget.order.orderStatus == OrderStatus.cancelled) {
      return cancelledOrder(context);
    } else if (OrderStatus.pending == widget.order.orderStatus) {
      return widget.orderType == OrderType.store
          ? newOrderAcceptReject(context, sale)
          : newOrderPending(context);
    } else {
      return rejectOrder();
    }
  }

  Widget newOrderPending(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Kolors.primaryColor,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CartDialog(
                      order: widget.order,
                      orderType: widget.orderType,
                    );
                  });
            },
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Pending",
                  style: TextStyle(
                    color: Kolors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Kolors.primaryColor,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CartDialog(
                      order: widget.order,
                      orderType: widget.orderType,
                    );
                  });
            },
            color: Kolors.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Details",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget newOrderAcceptReject(
    BuildContext context,
    int sale,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      actions: [
                        TextButton(
                            onPressed: () {
                              context
                                  .read<OrdersBloc>()
                                  .add(OrdersEvent.acceptOrder(
                                    deliveryEstimate: dropdownValue,
                                    id: widget.order.id,
                                    sale: sale,
                                  ));
                              updateUserSalescount(context, sale);
                              Navigator.pop(context);
                            },
                            child: Text("Confirm"))
                      ],
                      title: Text("Choose Delivery Time"),
                      content: StatefulBuilder(
                        builder: (BuildContext internalContext, setState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: <String>[
                                  'Soon',
                                  '15 Mins',
                                  '30 Mins',
                                  '1 Hour',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  });
            },
            child: const Text(
              ACCEPT,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Colors.green,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              showBottomSheet(
                  context: context,
                  builder: (context) {
                    return RejectBottomSheat(
                      onReject: (reason) {
                        context.read<OrdersBloc>().add(
                              OrdersEvent.rejectOrder(
                                id: widget.order.id,
                                reason: reason as String,
                              ),
                            );
                      },
                    );
                  });
            },
            child: Text(
              REJECT,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }

  void updateUserSalescount(BuildContext context, int sales) {
    final user = context.read<AuthenticationBloc>().state.storeUser;
    user.store.homeAnalytics.sales += sales;
    context.read<AuthenticationBloc>().add(
          AuthenticationEvent.userModified(user: user),
        );
  }

  Widget rejectOrder() {
    return Row(
      children: [
        Expanded(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {},
            child: Text(
              REJECTED,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }

  Widget confirmOrder(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Colors.green,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CartDialog(
                      order: widget.order,
                      orderType: widget.orderType,
                    );
                  });
            },
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Confirmed",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Kolors.primaryColor,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CartDialog(
                      order: widget.order,
                      orderType: widget.orderType,
                    );
                  });
            },
            color: Kolors.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Details",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget cancelledOrder(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Colors.green,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CartDialog(
                      order: widget.order,
                      orderType: widget.orderType,
                    );
                  });
            },
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Cancelled",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Kolors.primaryColor,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CartDialog(
                      order: widget.order,
                      orderType: widget.orderType,
                    );
                  });
            },
            color: Kolors.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Details",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class KeyValuePair extends StatelessWidget {
  final String name;
  final String value;
  const KeyValuePair({
    Key key,
    @required this.name,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
            // const SizedBox(
            //   width: 20,
            // ),
            Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black38,
              ),
            ),
          ],
        ));
  }
}
