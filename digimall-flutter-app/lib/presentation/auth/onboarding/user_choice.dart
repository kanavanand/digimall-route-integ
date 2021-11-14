import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/application/auth/onboarding/onboarding_bloc.dart';
import 'package:prachar/constants/constants.dart';
import 'package:prachar/presentation/core/pages/app_widget.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/routes/router.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:introduction_screen/introduction_screen.dart';

class UserChoicePage extends StatelessWidget {
  const UserChoicePage({Key key}) : super(key: key);
  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 15.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 25.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kolors.primaryColor,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'DigiMall',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          return IntroductionScreen(
            next: Text("Seller"),
            done: Text("Explore"),
            onDone: () {},
            pages: [
              PageViewModel(
                title: "Explore Stores Nearby",
                body:
                    "Buy Groceries, Fruits & Vegetables and Food from your nearby stores digitally.",
                image: _buildImage('undraw_shopping_app_flsj'),
                decoration: pageDecoration,
                footer: InkWell(
                    onTap: () async {
                      ExtendedNavigator.of(context).popUntilRoot();
                      await saveBuyersProfile(state.getAddress);
                      navigatorKey.currentState.context
                          .read<AuthenticationBloc>()
                          .add(const AuthenticationEvent.authCheckRequested());
                      context
                          .read<AuthenticationBloc>()
                          .add(const AuthenticationEvent.getCategories());
                      ExtendedNavigator.of(context)
                          .replace(Routes.baseStorePage);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      decoration: BoxDecoration(
                        color: Kolors.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Explore Stores",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    )),
              ),
              PageViewModel(
                title: "Create Digital Store",
                body:
                    "Register your shop, create your digital catalogue and star selling online",
                image: _buildImage('undraw_business_shop_qw5t'),
                decoration: pageDecoration,
                footer: InkWell(
                  onTap: () {
                    ExtendedNavigator.of(context).replace(
                      Routes.shopDetailsPage,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    decoration: BoxDecoration(
                      color: Kolors.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Register as Seller",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Future<void> saveBuyersProfile(Address address) async {
  final uid = FirebaseAuth.instance.currentUser.uid;
  final map = {
    'addresses': [],
    'isStore': false,
    'openAs': 'buyer',
    'cart': {},
  };
  if (address != null) {
    map.addAll({
      'locationAddresses': FieldValue.arrayUnion([address?.toMap()]),
    });
  }
  await FirebaseFirestore.instance.userCollection.doc(uid).set(map);
}
