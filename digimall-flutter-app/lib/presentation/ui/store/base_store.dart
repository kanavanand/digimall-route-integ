import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/constants/constants.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/routes/router.gr.dart';
import 'package:prachar/presentation/ui/store/pages/discovery.dart';
import 'package:prachar/presentation/ui/store/pages/saved_stores.dart';
import 'package:prachar/presentation/ui/store/pages/user_orders_list.dart';
import 'package:prachar/presentation/ui/store/pages/profile/user_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseStorePage extends StatefulWidget {
  const BaseStorePage({Key key}) : super(key: key);

  @override
  _BaseStorePageState createState() => _BaseStorePageState();
}

class _BaseStorePageState extends State<BaseStorePage> {
  final PageController _pagecontroller = PageController();

  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    // getUserLocation();
  }

  void changeTab() {
    _pagecontroller.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInCubic,
    );
    setState(() {
      pageIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pagecontroller,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SavedStoresPage(
            changeTabFunction: changeTab,
          ),
          const DiscoverStoresPage(),
          const UserOrdersList(),
          const UserProfilePage(
            userProfileType: UserProfileType.user,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: onTap,
        items: [
          // ignore: prefer_const_literals_to_create_immutables
          const BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              size: 27,
              color: Kolors.PrimaryColorDark,
            ),
            icon: Icon(Icons.home, size: 20, color: Colors.black45),
            label: "My Stores",
            backgroundColor: Kolors.primaryColor,
          ),
          const BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.search_rounded,
              size: 27,
              color: Kolors.PrimaryColorDark,
            ),
            icon: Icon(
              Icons.search_rounded,
              size: 20,
              color: Colors.black45,
            ),
            label: 'Discover',
          ),
          const BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.shopping_bag_outlined,
              size: 27,
              color: Kolors.PrimaryColorDark,
            ),
            icon: Icon(
              Icons.shopping_bag_outlined,
              size: 20,
              color: Colors.black45,
            ),
            label: 'Orders',
          ),
          const BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person,
              size: 27,
              color: Kolors.PrimaryColorDark,
            ),
            icon: Icon(
              Icons.person,
              size: 20,
              color: Colors.black45,
            ),
            label: 'User',
          ),
        ],
      ),
    );
  }

  void onTap(int pageIndex) {
    _pagecontroller.animateToPage(pageIndex,
        duration: const Duration(microseconds: 200), curve: Curves.linear);
  }

  void onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
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
