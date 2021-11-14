import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/presentation/core/pages/app_widget.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/routes/router.gr.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prachar/constants/constants.dart';

class DeliveryAddressPage extends StatefulWidget {
  DeliveryAddressPage({
    Key key,
  }) : super(key: key);

  @override
  _DeliveryAddressPageState createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  final formKey = GlobalKey<FormState>();
  final houseNoTEC = TextEditingController();
  final localityTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ADD_ADDRESS,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                ENTER_FLAT_NUMBER,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: houseNoTEC,
                decoration: const InputDecoration(
                  hintText: HOUSE_NUMBER,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: localityTEC,
                decoration: const InputDecoration(
                  hintText: COLONY_STREET_LOCALITY,
                ),
              ),
              Expanded(child: Container()),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      addAddress(houseNoTEC.text, localityTEC.text);
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  color: Kolors.primaryColor,
                  child: const Text(
                    ADD_ADDRESS,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addAddress(String houseNo, String address2) async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    String address = '$houseNo  $address2';
    List<String> list = [address];
    await FirebaseFirestore.instance.userCollection.doc(uid).update(
      {'addresses': FieldValue.arrayUnion(list)},
    ).then((value) {
      Fluttertoast.showToast(msg: "Address added successfully");
    });
    final user = navigatorKey.currentState.context
        .read<AuthenticationBloc>()
        .state
        .storeUser;
    user.addresses.add(address);
    navigatorKey.currentState.context
        .read<AuthenticationBloc>()
        .add(AuthenticationEvent.userModified(user: user));
    ExtendedNavigator.of(navigatorKey.currentState.context)
        .pop("${houseNo} ${address2}");
  }
}
