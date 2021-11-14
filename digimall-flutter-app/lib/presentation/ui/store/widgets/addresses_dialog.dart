import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/domain/auth/store.dart';
import 'package:prachar/domain/user/store_user.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/core/widgets/button.dart';
import 'package:prachar/presentation/routes/router.gr.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AddressesDialog extends StatefulWidget {
  final List<String> addressesList;
  final Store store;
  const AddressesDialog({
    Key key,
    @required this.addressesList,
    @required this.store,
  }) : super(key: key);

  @override
  _AddressesDialogState createState() => _AddressesDialogState();
}

class _AddressesDialogState extends State<AddressesDialog> {
  int selectedIndex;
  List<String> addressList;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    addressList = widget.addressesList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Address",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              GestureDetector(
                onTap: () {
                  ExtendedNavigator.of(context).popAndPush(
                    Routes.deliveryAddressPage,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add,
                        color: Colors.black87,
                      ),
                      const Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        ListView.builder(
          itemBuilder: (context, index) {
            return RadioListTile(
              value: index,
              groupValue: selectedIndex,
              title: Text(addressList[index]),
              onChanged: (val) {
                setState(() {
                  selectedIndex = val as int;
                });
              },
              activeColor: Colors.red,
              selected: false,
            );
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: addressList.length,
        ),
        ButtonFW(
          isLoading: isLoading,
          text: "Select Address",
          onPressed: () {
            if (selectedIndex != null) {
              Navigator.pop(context, addressList[selectedIndex]);
            } else {
              FlushbarHelper.createInformation(message: "Please select address")
                  .show(context);
            }
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
