import 'package:flutter/foundation.dart' as Foundation;
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:location/location.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/domain/auth/store.dart';
import 'package:prachar/presentation/core/pages/app_widget.dart';
import 'package:prachar/presentation/core/widgets/loading.dart';
import 'package:prachar/presentation/routes/router.gr.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  Future onResumeHandleDynamicLink() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      _handleDynamicLink(dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });
  }

  Future initDynamicLinks(BuildContext context) async {
    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDynamicLink(data);
  }

  Future<void> _handleDynamicLink(PendingDynamicLinkData data) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    //TODO : Implement check hasDetailsSaved
    final deepLink = data?.link;
    print("deepLink is $deepLink");
    if (deepLink != null) {
      final queryParams = deepLink.queryParameters;
      if (queryParams.isNotEmpty) {
        final storeId = queryParams['storeId'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('storeId', storeId);
        print(await prefs.getString('storeId'));
        if (currentUser == null) {
          return;
        }
        final uid = currentUser.uid;
        final DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection("Stores")
            .doc(storeId.trim())
            .get();
        print("storeId is $storeId");

        if (doc.exists) {
          await FirebaseFirestore.instance.storesCollection
              .doc(storeId)
              .update({
            'savedBy': FieldValue.arrayUnion([uid])
          });

          final Store store = Store.fromJson(doc.data());
          print("Redirecting to ${store.name}");
          ExtendedNavigator.of(navigatorKey.currentState.context).push(
            Routes.storeDetailsPage,
            arguments: StoreDetailsPageArguments(
              store: store,
            ),
          );
        } else {
          ExtendedNavigator.of(navigatorKey.currentState.context)
              .replace(Routes.baseStorePage);
        }
      }
    }
  }

  Future checkUpdates() async {
    //Check for notification only in release mode
    if (Foundation.kReleaseMode) {
      print("CHECKING FOR UPDATES");
      AppUpdateInfo updateInfo;

      try {
        updateInfo = await InAppUpdate.checkForUpdate();
      } on PlatformException catch (e) {
        print(e);
      }
      print("UPDATE INFO IS $updateInfo");
      if (updateInfo != null) {
        if (updateInfo.updateAvailability > 0) {
          if (updateInfo.updatePriority == 1) {
            return;
          } else if (updateInfo.updatePriority > 3) {
            await InAppUpdate.performImmediateUpdate();
          } else {
            await InAppUpdate.startFlexibleUpdate();
            await InAppUpdate.completeFlexibleUpdate();
          }
        }
      } else {
        print("No Update available");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initDynamicLinks(context);
    checkUpdates();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print('App Resumed');
      onResumeHandleDynamicLink();
    }
  }

  @override
  Widget build(BuildContext context) {
    // initUniLinks(context);
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        if (state?.isSignedIn ?? false) {
          if (state?.isDetailsAvailable ?? false) {
            // await getUserLocation();
            context
                .read<AuthenticationBloc>()
                .add(const AuthenticationEvent.getCategories());
            if (state.storeUser.openAs == 'seller') {
              ExtendedNavigator.of(context).replace(Routes.basePage);
            } else {
              ExtendedNavigator.of(context).replace(Routes.baseStorePage);
            }
          } else {
            ExtendedNavigator.of(context).replace(Routes.userChoicePage);
          }
        } else {
          ExtendedNavigator.of(context).popUntilRoot();
          ExtendedNavigator.of(context).replace(Routes.loginPage);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/logo.png',
                height: 200,
                width: 200,
              ),
              const CircularProgressLoading(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getUserLocation() async {
    LocationData myLocation;
    String error;
    final Location location = Location();

    try {
      myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        debugPrint(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        debugPrint(error);
      }
      myLocation = null;
    }
    final coordinates = Coordinates(myLocation.latitude, myLocation.longitude);
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    debugPrint(
        ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
    context.read<AuthenticationBloc>().add(
          AuthenticationEvent.updateUserLocation(
            address: first,
          ),
        );
  }
}
