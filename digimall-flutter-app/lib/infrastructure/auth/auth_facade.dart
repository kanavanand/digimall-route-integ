import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:injectable/injectable.dart';
import 'package:prachar/domain/auth/i_auth_facade.dart';
import 'package:prachar/domain/core/failure/firebase_failure.dart';
import 'package:prachar/domain/user/store_user.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:prachar/services/dynamic_links.dart';

@LazySingleton(as: IAuthFacade)
class AuthFacade extends IAuthFacade {
  final FirebaseFirestore _firebaseFirestore;
  final Reference _storageReference;

  final FirebaseAuth _firebaseAuth;

  AuthFacade(
    this._firebaseAuth,
    this._firebaseFirestore,
    this._storageReference,
  );

  @override
  Future<Either<FirebaseFailure, Unit>> saveStoreData({
    String name,
    String address,
    String category,
    Address addressModel,
    File file,
  }) async {
    try {
      String fileUrl = '';
      String uid = _firebaseAuth.currentUser.uid;
      String no = _firebaseAuth.currentUser.phoneNumber;
      final Uri dynamicLinkForStore =
          await DynamicLinkService.createDynamicLink(uid);
      if (file != null) {
        final UploadTask uploadTask = _storageReference.storeImages
            .child(_firebaseAuth.currentUser.uid)
            .putFile(file);
        final TaskSnapshot storageSnap = await uploadTask.whenComplete(() {});
        fileUrl = await storageSnap.ref.getDownloadURL();
      } else {}
      if (fileUrl.isEmpty)
        fileUrl =
            'https://i.pinimg.com/originals/77/c3/66/77c366436d8bd35fe8b3ce5b8c66992e.png';
      final Map<String, dynamic> map = {
        'name': name ?? '',
        'searchKey': name?.toLowerCase() ?? '',
        'searchAreaKey': addressModel?.locality?.toLowerCase() ?? '',
        'address': address ?? '',
        'category': category ?? '',
        'number': no,
        'image': fileUrl,
        'rating': 5,
        'analytics': {
          'views': 0,
          'sales': 0,
          'orders': 0,
          'products': 0,
        },
        'savedBy': [],
        'id': uid,
        'isDiscoverable': false,
        'dynamicLinkUrl': dynamicLinkForStore.toString(),
      };
      if (addressModel != null) {
        final geo = Geoflutterfire();

        GeoFirePoint point = geo.point(
          latitude: addressModel.coordinates.latitude,
          longitude: addressModel.coordinates.longitude,
        );
        map.putIfAbsent(
            'coordinates',
            () => {
                  'geohash': point.hash,
                  'geopoint': point.geoPoint,
                });

        map.putIfAbsent(
            'addressModel',
            () => {
                  'locality': addressModel.locality,
                  'addressLine': addressModel.addressLine,
                  'adminArea': addressModel.adminArea,
                  'countryName': addressModel.countryName,
                  'countryCode': addressModel.countryCode,
                  'subAdminArea': addressModel.subAdminArea,
                  'subLocality': addressModel.subLocality,
                  'featureName': addressModel.featureName,
                });
      }
      await _firebaseFirestore.storesCollection.doc(uid).set(map);
      final userDoc = await _firebaseFirestore.userCollection.doc(uid).get();
      if (!userDoc.exists) {
        await _firebaseFirestore.userCollection.doc(uid).set({
          'isStore': true,
          'addresses': [],
          'openAs': 'seller',
        });
      } else {
        await _firebaseFirestore.userCollection.doc(uid).update({
          'isStore': true,
          'openAs': 'seller',
        });
      }

      return right(unit);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.customError(e.toString()));
    } catch (e) {
      return left(FirebaseFailure.customError(e.toString()));
    }
  }

  @override
  Future<Option<Either<Unit, StoreUser>>> getSignedInUser() async {
    // TODO: implement getSignedInUser
    try {
      if (_firebaseAuth.currentUser == null) return none();
      final DocumentSnapshot doc = await _firebaseFirestore.userCollection
          .doc(_firebaseAuth.currentUser.uid)
          .get();
      if (doc.exists) {
        Map<String, dynamic> storeMap;
        if (doc.data()['isStore'] as bool) {
          final DocumentSnapshot storeDoc = await _firebaseFirestore
              .storesCollection
              .doc(_firebaseAuth.currentUser.uid)
              .get();
          storeMap = storeDoc.data();
        }
        final StoreUser store =
            StoreUser.fromJson(doc.data(), storeMap, doc.id);

        return some(right(store));
      } else {
        return some(left(unit));
      }
    } on FirebaseException catch (e) {
      return none();
    } catch (e) {
      return none();
    }
  }

  @override
  Future<void> signOut() async {
    // TODO: implement signOut
    await _firebaseAuth.signOut();
  }

  @override
  Future<Either<FirebaseFailure, Map<String, dynamic>>> getCategories() async {
    try {
      final DocumentSnapshot doc = await _firebaseFirestore.assetsCollection
          .doc("ProductCategories")
          .get();
      return right(doc.data());
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.customError(e.message));
    } catch (e) {
      return left(FirebaseFailure.customError(e.toString()));
    }
  }
}
