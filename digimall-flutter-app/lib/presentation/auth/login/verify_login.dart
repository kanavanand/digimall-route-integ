import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/domain/user/store_user.dart';
import 'package:prachar/presentation/core/pages/app_widget.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/core/widgets/text_form_with_toplabel.dart';
import 'package:prachar/presentation/routes/router.gr.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prachar/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyLoginPage extends StatefulWidget {
  final String verificationId;
  final int resentToken;
  final String mobileNo;
  const VerifyLoginPage({
    Key key,
    @required this.verificationId,
    @required this.resentToken,
    @required this.mobileNo,
  }) : super(key: key);

  @override
  _VerifyLoginPageState createState() => _VerifyLoginPageState();
}

class _VerifyLoginPageState extends State<VerifyLoginPage> {
  final codeTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kolors.primaryColor,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          APP_NAME,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        // width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            const SizedBox(
              height: 70,
            ),
            const Text(
              "Welcome to $APP_NAME",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Kolors.primaryColor,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 18,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: CupertinoTextField(
                        clearButtonMode: OverlayVisibilityMode.editing,
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        placeholder: '6 digit OTP',
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            border: Border.all(color: Kolors.primaryColor)),
                        controller: codeTEC,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {
                    signIn();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Kolors.primaryColor,
                  child: Text(
                    VERIFY_OTP,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            InkWell(
              onTap: () {
                resentOTP();
              },
              child: const Text(
                RESENT_OTP,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Kolors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    final AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: codeTEC.text,
    );
    await _auth.signInWithCredential(phoneAuthCredential).then((value) async {
      Fluttertoast.showToast(msg: SIGN_IN_SUCCESSFUL);
      await saveUserInStoreSavedByList();
      checkIfUserExists();
    }).catchError((e) {
      Fluttertoast.showToast(msg: "$SIGN_IN_FAILED ${e.toString()}");
    });
  }

  Future<void> resentOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.mobileNo,
      forceResendingToken: widget.resentToken,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int resendToken) {
        debugPrint("$OTP_SENT: $verificationId");
        Fluttertoast.showToast(msg: "$OTP_RESENT_SUCCESSFULLY");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> checkIfUserExists() async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    final DocumentSnapshot doc =
        await FirebaseFirestore.instance.userCollection.doc(uid).get();
    if (uid != null) await setFCMToken();
    if (doc.exists) {
      context
          .read<AuthenticationBloc>()
          .add(const AuthenticationEvent.getCategories());
      Map<String, dynamic> storeMap;
      if (doc.data()['isStore'] as bool) {
        final DocumentSnapshot storeDoc = await FirebaseFirestore
            .instance.storesCollection
            .doc(FirebaseAuth.instance.currentUser.uid)
            .get();
        storeMap = storeDoc.data();
      }
      final StoreUser store = StoreUser.fromJson(doc.data(), storeMap, doc.id);
      navigatorKey.currentState.context.read<AuthenticationBloc>().add(
            AuthenticationEvent.userModified(
              user: store,
            ),
          );
      if (store.openAs == 'buyer') {
        ExtendedNavigator.of(context).pop();
        ExtendedNavigator.of(context).replace(Routes.baseStorePage);
      } else if (store.openAs == 'seller') {
        ExtendedNavigator.of(context).pop();

        ExtendedNavigator.of(context).replace(Routes.basePage);
      } else {
        ExtendedNavigator.of(context).pop();

        ExtendedNavigator.of(context).replace(Routes.baseStorePage);
      }
    } else {
      ExtendedNavigator.of(context).pop();
      ExtendedNavigator.of(context).replace(Routes.userChoicePage);
    }
  }
}

Future setFCMToken() async {
  final String uid = FirebaseAuth.instance.currentUser.uid;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final String fCMtoken = await messaging.getToken();
  if (uid != null) {
    await FirebaseFirestore.instance.collection('tokens').doc(uid).set({
      'activeTokens': FieldValue.arrayUnion([fCMtoken]),
      'inactiveTokens': FieldValue.arrayRemove([fCMtoken])
    }, SetOptions(merge: true));
  }
}

Future<void> saveUserInStoreSavedByList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final storeIdFromDB = await prefs.getString('storeId');
  if (storeIdFromDB != null) {
    print("Store id to save in db is $storeIdFromDB");
    final DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("Stores")
        .doc(storeIdFromDB.trim())
        .get();
    await FirebaseFirestore.instance.storesCollection
        .doc(storeIdFromDB.trim())
        .update({
      'savedBy': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser.uid])
    });
    print((await FirebaseFirestore.instance
            .collection("Stores")
            .doc(storeIdFromDB.trim())
            .get())
        .data());
  }
}
