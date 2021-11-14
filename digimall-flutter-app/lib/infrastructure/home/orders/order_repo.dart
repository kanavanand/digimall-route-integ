import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:prachar/domain/core/failure/firebase_failure.dart';
import 'package:prachar/domain/home/orders/i_order_repo.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:http/http.dart' as http;

@LazySingleton(as: IOrderRepo)
class OrderRepo extends IOrderRepo {
  final FirebaseFirestore _firebaseFirestore;
  final Reference _storageRef;
  final FirebaseAuth _firebaseAuth;
  OrderRepo(
    this._firebaseFirestore,
    this._storageRef,
    this._firebaseAuth,
  );

  @override
  Future<Either<FirebaseFailure, Unit>> acceptOrder({
    String orderId,
    int sale,
    String deliveryEstimate,
  }) async {
    try {
      String uid = _firebaseAuth.currentUser.uid;
      String signedInUserPhonenumber = _firebaseAuth.currentUser.phoneNumber;
      await _firebaseFirestore.allOrdersCollection.doc(orderId).update({
        'orderStatus': 'confirmed',
        'deliveryEstimate': deliveryEstimate,
      });

      String sales = 'sales';
      await _firebaseFirestore.storesCollection.doc(uid).update({
        'analytics.$sales': FieldValue.increment(sale),
      });
      try {
        await http.get(
          Uri.parse(
            'https://prachaaradmin2.azurewebsites.net/v1/acceptordernoti?number=$signedInUserPhonenumber',
          ),
        );
      } catch (e) {
        log('API Request to prachar azure failed ${e.toString()}');
      }
      Fluttertoast.showToast(msg: "Order accepted");
      return right(unit);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.customError(e.toString()));
    } catch (e) {
      return left(FirebaseFailure.customError(e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, Unit>> rejectOrder({
    String orderId,
    String reason,
  }) async {
    try {
      String uid = _firebaseAuth.currentUser.uid;
      await _firebaseFirestore.allOrdersCollection.doc(orderId).update({
        'orderStatus': 'rejected',
        'reason': reason,
      });
      Fluttertoast.showToast(msg: "Order rejected");

      return right(unit);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.customError(e.toString()));
    } catch (e) {
      return left(FirebaseFailure.customError(e.toString()));
    }
  }
}
