import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geoflutterfire/geoflutterfire.dart' as flutter_fire;
import 'package:location/location.dart';
import 'package:prachar/domain/user/store_user.dart';
import 'package:rxdart/rxdart.dart';

import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/constants/configs.dart';
import 'package:prachar/domain/auth/store.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/ui/store/widgets/store_tile.dart';

enum DiscoveryPageErrorType { locationOff, noStoresInArea }

class DiscoverStoresPage extends StatefulWidget {
  const DiscoverStoresPage({Key key}) : super(key: key);

  @override
  _DiscoverStoresPageState createState() => _DiscoverStoresPageState();
}

class _DiscoverStoresPageState extends State<DiscoverStoresPage> {
  bool _isLoading = false;
  Address addressToUseForSearch;
  Widget errorPage(BuildContext context, String warning1, String warning2,
      String solution, DiscoveryPageErrorType errorType) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 300,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(warning1),
          Text(warning2),
          Image.asset(
            'assets/images/undraw_road_sign_mfpo.png',
            height: 200,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              minimumSize: Size(
                MediaQuery.of(context).size.width / 1.5,
                0,
              ),
              primary: Kolors.primaryColor,
            ),
            onPressed: () {
              if (errorType == DiscoveryPageErrorType.noStoresInArea) {
                showBottomSheet(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                solution,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final addressFromDb =
        context.read<AuthenticationBloc>().state.storeUser.locationAddresses;

    final address = context.read<AuthenticationBloc>().state.userCurrentAddress;

    if (addressToUseForSearch == null) {
      if (addressFromDb != null && addressFromDb.isNotEmpty) {
        setState(() {
          addressToUseForSearch = addressFromDb.last;
        });
      } else {
        setState(() {
          addressToUseForSearch = address;
        });
      }
    }
    print(addressToUseForSearch);
  }

  Widget storesList(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final addressFromDb =
        context.read<AuthenticationBloc>().state.storeUser.locationAddresses;

    final address = context.read<AuthenticationBloc>().state.userCurrentAddress;

    if (addressToUseForSearch == null) {
      if (addressFromDb != null && addressFromDb.isNotEmpty) {
        addressToUseForSearch = addressFromDb.last;
      } else {
        addressToUseForSearch = address;
      }
    }
    final area = addressToUseForSearch?.locality?.toLowerCase() ?? '';
    Query query = FirebaseFirestore.instance.storesCollection
        .where('isDiscoverable', isEqualTo: true);

    // if (area.isNotEmpty) {
    //   query = query.where('searchAreaKey', isEqualTo: area);
    // }

    final geo = flutter_fire.Geoflutterfire();
    final flutter_fire.GeoFirePoint center = geo.point(
      latitude: addressToUseForSearch.coordinates.latitude,
      longitude: addressToUseForSearch.coordinates.longitude,
    );
    final radius = BehaviorSubject<double>.seeded(Configs.geofetchingRadius);
    final stream = radius.switchMap((rad) {
      return geo.collection(collectionRef: query).within(
          center: center, radius: rad, field: 'coordinates', strictMode: true);
    });

    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context,
          AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
        print("Use ADDRESS ${addressToUseForSearch.toMap()}");
        return snapshot.hasData
            ? snapshot.data.length as int > 0
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot doc = snapshot.data[index];
                      final coordinates =
                          doc['coordinates']['geopoint'] as GeoPoint;
                      final distance = center.distance(
                        lat: coordinates.latitude,
                        lng: coordinates.longitude,
                      );

                      final Store store = Store.fromJson(doc.data());
                      return SearchStoreTile(
                        store: store,
                        distance: distance,
                      );
                    })
                : errorPage(
                    context,
                    'No stores nearby',
                    'We will be soon live in your location',
                    "Select Location",
                    DiscoveryPageErrorType.noStoresInArea,
                  )
            : Container();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getLastSelectedAddressToDB();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return Container(
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discover Stores",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Kolors.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                            ),
                            onPressed: () async {
                              showBottomSheet(context);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Text(
                                    _isLoading
                                        ? "Fetching......"
                                        : addressToString(
                                            addressToUseForSearch,
                                          ),
                                    softWrap: false,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                                const Icon(Icons.arrow_downward)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       flex: 1,
                  //       child: SearchWidget(
                  //         hint: "Store name",
                  //         text: "",
                  //         onPressed: () {
                  //           Fluttertoast.showToast(
                  //               msg: "This feature is coming soon.");
                  //           //! Disabled Temporarily
                  //           // ExtendedNavigator.of(context).push(Routes.searchStorePage,
                  //           //     arguments: SearchStorePageArguments(
                  //           //         searchStoreType: SearchStoreType.name,
                  //           //         searchSavedStore: false));
                  //         },
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 20,
                  //     ),
                  //     Expanded(
                  //       flex: 1,
                  //       child: SearchWidget(
                  //         hint: "Area",
                  //         text: "",
                  //         onPressed: () {
                  //           Fluttertoast.showToast(
                  //               msg: "This feature is coming soon.");
                  //           //! Disabled Temporarily
                  //           // ExtendedNavigator.of(context).push(
                  //           //   Routes.searchStorePage,
                  //           //   arguments: SearchStorePageArguments(
                  //           //     searchStoreType: SearchStoreType.area,
                  //           //     searchSavedStore: false,
                  //           //   ),
                  //           // );
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: Kolors.primaryBackgroundColor,
            ),
            if (state.userCurrentAddress?.coordinates != null ||
                (context
                        .read<AuthenticationBloc>()
                        .state
                        .storeUser
                        .locationAddresses
                        .isNotEmpty &&
                    context
                            .read<AuthenticationBloc>()
                            .state
                            .storeUser
                            .locationAddresses
                            .last
                            .coordinates !=
                        null))
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Kolors.primaryBackgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Kolors.primaryColor,
                                ),
                              ),
                            )
                          : storesList(context),
                    )),
              )
            else
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : errorPage(
                      context,
                      'Location not found',
                      'Unable to get your locoation ',
                      "Turn on Location",
                      DiscoveryPageErrorType.locationOff,
                    ),
          ],
        ),
      );
    });
  }

  Future<void> showBottomSheet(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          final List<Address> addresses = context
              .read<AuthenticationBloc>()
              .state
              .storeUser
              .locationAddresses;
          return AlertDialog(
            title: const Center(child: Text("Select Locality")),
            content: StatefulBuilder(builder: (internalContext, snapshot) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return index == 0
                                ? Container()
                                : const Divider(
                                    height: 1,
                                    thickness: 1.5,
                                  );
                          },
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: addresses.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: StadiumBorder(),
                                  side: BorderSide(
                                    width: 0.5,
                                    color: Colors.blue,
                                  ),
                                ),
                                onPressed: () async {
                                  AlertDialog alert = AlertDialog(
                                    content: Row(
                                      children: [
                                        CircularProgressIndicator(),
                                        Container(
                                            margin: EdgeInsets.only(left: 7),
                                            child:
                                                Text("Fetching Location...")),
                                      ],
                                    ),
                                  );
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );

                                  final Address currentLocation =
                                      await getUserLocation(context);
                                  setState(() {
                                    addressToUseForSearch = currentLocation;
                                  });

                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.fitWidth,
                                  child: Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.gps_fixed),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10),
                                        child: Text(
                                          "Use Current Location",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return ListTile(
                              enableFeedback: true,
                              onTap: () async {
                                setState(() {
                                  addressToUseForSearch = addresses[index - 1];
                                });
                                await setLastSelectedAddressToDB();
                                Navigator.pop(context);
                              },
                              title:
                                  Text(addressToString(addresses[index - 1])),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  Future<Address> getUserLocation(BuildContext context) async {
    LocationData myLocation;
    String error;
    final Location location = Location();

    final firestore = FirebaseFirestore.instance;
    try {
      myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        debugPrint(error);
        rethrow;
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        debugPrint(error);
        rethrow;
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
    final uid = FirebaseAuth.instance.currentUser.uid;
    // var dataDB = await firestore.userCollection.doc(uid).get();

    await firestore.userCollection.doc(uid).update({
      'locationAddresses': FieldValue.arrayUnion([first?.toMap()]),
    });
    return first;
  }

  Future setLastSelectedAddressToDB() async {
    final firestore = FirebaseFirestore.instance;
    final uid = FirebaseAuth.instance.currentUser.uid;

    await firestore.userCollection.doc(uid).update({
      'lastUsedAddress': addressToUseForSearch.toMap(),
    });
  }

  Future getLastSelectedAddressToDB() async {
    // TODO Add Loader
    setState(() {
      _isLoading = true;
    });
    Address address;
    final firestore = FirebaseFirestore.instance;
    final uid = FirebaseAuth.instance.currentUser.uid;
    final data = await firestore.userCollection.doc(uid).get();
    setState(() {
      _isLoading = false;
    });
    if (data.exists && data.data()['lastUsedAddress'] != null) {
      address = Address.fromMap(data.data()['lastUsedAddress'] as Map);
      if (address != null) {
        setState(() {
          addressToUseForSearch = address;
        });
        print(address.toMap());
      }
    }
  }
}

String addressToString(Address address) {
  if (address == null) return "Unknown";
  if (address.subThoroughfare != null) {
    return address.subThoroughfare;
  } else if (address.thoroughfare != null) {
    return address.thoroughfare;
  } else if (address.subLocality != null) {
    return address.subLocality;
  } else if (address.locality != null) {
    return address.locality;
  } else if (address.subAdminArea != null) {
    return address.subAdminArea;
  } else if (address.adminArea != null) {
    return address.adminArea;
  } else if (address.countryName != null) {
    return address.countryName;
  } else {
    return "Unknown";
  }
}
