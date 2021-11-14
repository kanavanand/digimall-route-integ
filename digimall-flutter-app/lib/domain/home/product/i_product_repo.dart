import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:prachar/domain/core/failure/firebase_failure.dart';
import 'package:prachar/domain/home/product/product.dart';

abstract class IProductRepo {
  Future<Either<FirebaseFailure, Unit>> addProduct({
    @required Product product,
    @required File file,
  });

  Future<Either<FirebaseFailure, Unit>> editProduct({
    @required Product product,
    File file,
  });

  Future<Either<FirebaseFailure, Unit>> deleteProduct({
    @required String productId,
  });
}
