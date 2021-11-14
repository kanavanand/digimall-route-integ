import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/presentation/auth/login/login.dart';
import 'package:prachar/presentation/core/pages/app_widget.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/routes/router.gr.dart';
import 'package:prachar/presentation/ui/store/pages/profile/widgets/header.dart';
import 'package:prachar/presentation/ui/store/pages/profile/widgets/profile_row_widget.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prachar/constants/constants.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

enum UserProfileType {
  user,
  store,
}

class UserProfilePage extends StatelessWidget {
  final UserProfileType userProfileType;
  const UserProfilePage({
    Key key,
    @required this.userProfileType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "My Account",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Kolors.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            )),
                        // Image.asset("assets/images/delivery_boy.png")
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Kolors.primaryBackgroundColor,
            ),
            ProfileHeader(
              userProfileType: userProfileType,
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            // ProfileRowWidget(
            //   iconData: Icons.edit_location,
            //   name: SAVED_ADDRESS,
            //   onPressed: () {},
            // ),
            ProfileRowWidget(
              iconData: Icons.share_outlined,
              name: SHARE_PRACHAR_APP,
              onPressed: () {
                Share.share(
                    'Hi,\nCheckout Digimall App.\nBuy Groceries, Fruits & Vegetables and Food from your nearby stores digitally.\nDownload: https://play.google.com/store/apps/details?id=com.business.prachar');
              },
            ),
            if (!checkIfStoreExists() &&
                userProfileType == UserProfileType.user)
              ProfileRowWidget(
                iconData: Icons.add,
                name: CREATE_SELLER_ACCOUNT,
                onPressed: () {
                  ExtendedNavigator.of(context).push(Routes.shopDetailsPage);
                },
              )
            else
              Container(),
            ProfileRowWidget(
              iconData: Icons.exit_to_app,
              name: SIGN_OUT,
              onPressed: () async {
                //TODO: Better implementation
                await deactivateTokens();
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false);
              },
            ),
            // ProfileRowWidget(
            //   iconData: Icons.delete_outline_outlined,
            //   name: DELETE_ACCOUNT,
            //   onPressed: () {},
            // ),
            ProfileRowWidget(
              iconData: Icons.star_border_outlined,
              name: RATE_US,
              onPressed: () {},
            ),
            ProfileRowWidget(
              iconData: Icons.message,
              name: "Message our team",
              onPressed: () {
                _launchURL(
                    "'https://api.whatsapp.com/send/?phone=+917009563513&text=Hi,Can you help me! &app_absent=0'");
              },
            ),
            ProfileRowWidget(
              iconData: Icons.call,
              name: "Call Us",
              onPressed: () {
                _makePhoneCall("+917009563513");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: checkIfStoreExists()
          ? FloatingActionButton.extended(
              backgroundColor: Kolors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onPressed: () async {
                final uid = FirebaseAuth.instance.currentUser.uid;

                if (userProfileType == UserProfileType.store) {
                  FirebaseFirestore.instance.userCollection
                      .doc(uid)
                      .update({'openAs': 'buyer'});
                  ExtendedNavigator.of(context).replace(Routes.baseStorePage);
                } else {
                  FirebaseFirestore.instance.userCollection
                      .doc(uid)
                      .update({'openAs': 'seller'});
                  ExtendedNavigator.of(context).replace(Routes.basePage);
                }
              },
              label: Text(
                userProfileType == UserProfileType.store
                    ? "Switch to buyer"
                    : "Swich to seller",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : Container(),
    );
  }

  bool checkIfStoreExists() {
    return navigatorKey.currentState.context
            .read<AuthenticationBloc>()
            .state
            .storeUser
            ?.isStore ??
        false;
  }
}

Future deactivateTokens() async {
  final String uid = FirebaseAuth.instance.currentUser.uid;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final String fCMtoken = await messaging.getToken();
  if (uid != null) {
    await FirebaseFirestore.instance.collection('tokens').doc(uid).set({
      'activeTokens': FieldValue.arrayRemove([fCMtoken]),
      'inactiveTokens': FieldValue.arrayUnion([fCMtoken]),
    }, SetOptions(merge: true));
  }
}

Future _launchURL(String number) async {
  var URL =
      'https://api.whatsapp.com/send/?phone=$number&text=Hello%20,%20I%20found%20you%20on%20DiGi%20Mall%20&app_absent=0';
  if (await canLaunch(URL)) {
    await launch(URL);
  } else {
    throw "Could not launch $URL";
  }
}

Future<void> _makePhoneCall(String number) async {
  final url = 'tel:$number';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
