import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:prachar/domain/core/failure/firebase_failure.dart';
import 'package:prachar/domain/user/store_user.dart';

abstract class IAuthFacade {
  Future<Either<FirebaseFailure, Unit>> saveStoreData({
    @required String name,
    @required String address,
    @required String category,
    @required File file,
    @required Address addressModel,
  });
  Future<void> signOut();
  Future<Option<Either<Unit, StoreUser>>> getSignedInUser();
  Future<Either<FirebaseFailure, Map<String, dynamic>>> getCategories();
}
