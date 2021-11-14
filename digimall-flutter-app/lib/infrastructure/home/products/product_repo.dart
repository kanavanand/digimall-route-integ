import 'dart:io';

import 'package:string_validator/string_validator.dart';
import 'package:characters/characters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/domain/core/failure/firebase_failure.dart';
import 'package:prachar/domain/home/home_analytics.dart';
import 'package:prachar/domain/home/i_home_repo.dart';
import 'package:prachar/domain/home/product/i_product_repo.dart';
import 'package:prachar/domain/home/product/product.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:prachar/presentation/core/pages/app_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@LazySingleton(as: IProductRepo)
class ProductRepo extends IProductRepo {
  final FirebaseFirestore _firebaseFirestore;
  final Reference _storageRef;
  final FirebaseAuth _firebaseAuth;
  ProductRepo(
    this._firebaseFirestore,
    this._storageRef,
    this._firebaseAuth,
  );

  @override
  Future<Either<FirebaseFailure, Unit>> addProduct({
    Product product,
    File file,
  }) async {
    // TODO: implement addProduct
    try {
      String fileUrl = '';
      String uid = _firebaseAuth.currentUser.uid;
      // if (file == null) {
      //   return left(
      //     const FirebaseFailure.customError(
      //         "Please select suitable product image"),
      //   );
      // }
      List<String> substringGenerator(String name) {
        final List<String> keywords = [];
        final keyword = StringBuffer();
        for (final String char in name.characters) {
          if (isAlpha(char)) {
            keyword.write(char);
            if (keyword.length > 2) {
              keywords.add(keyword.toString());
            }
          }
        }
        return keywords;
      }

      List<String> keywordGenerator(String name) {
        final List<String> keywords = [];
        for (final String word in name.split(' ')) {
          keywords.addAll(substringGenerator(word.toLowerCase()));
        }
        return keywords;
      }

      final DocumentReference docRef =
          _firebaseFirestore.storesCollection.doc(uid).productsCollection.doc();

      if (file != null) {
        final UploadTask uploadTask = _storageRef
            .child("Products Images")
            .child(_firebaseAuth.currentUser.uid)
            .child(docRef.id)
            .putFile(file);

        final TaskSnapshot storageSnap = await uploadTask.whenComplete(() {});
        fileUrl = await storageSnap.ref.getDownloadURL();
      }
      if (fileUrl.isEmpty) {
        fileUrl = 'https://image.flaticon.com/icons/png/512/1261/1261163.png';
      }

      final Map<String, dynamic> map = {
        'name': product.name,
        'code': product.code,
        'category': product.category,
        'quantity': product.quantity,
        'mrp': product.mrp,
        'sellingPrice': product.sellingPrice,
        'desc': product.desc,
        'timestamp': Timestamp.now(),
        'image': fileUrl,
        'availability': true,
        'productId': docRef.id,
        'keywords': keywordGenerator(product.name),
        'searchKey': product.name.toLowerCase(),
      };

      await docRef.set(map);

      String productStr = 'products';
      List<String> categories = [product.category];

      await _firebaseFirestore.storesCollection.doc(uid).update({
        'analytics.$productStr': FieldValue.increment(1),
        'productCategories': FieldValue.arrayUnion(categories),
      });

      final user = navigatorKey.currentState.context
          .read<AuthenticationBloc>()
          .state
          .storeUser;
      user.store.productCategories.add(product.category);
      navigatorKey.currentState.context
          .read<AuthenticationBloc>()
          .add(AuthenticationEvent.userModified(user: user));

      return right(unit);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.customError(e.toString()));
    } catch (e) {
      return left(FirebaseFailure.customError(e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, Unit>> deleteProduct(
      {String productId}) async {
    try {
      final String uid = _firebaseAuth.currentUser.uid;
      final DocumentReference docRef = _firebaseFirestore.storesCollection
          .doc(uid)
          .productsCollection
          .doc(productId);

      await docRef.delete();
      String products = 'products';
      await _firebaseFirestore.storesCollection.doc(uid).update(
        {'analytics.$products': FieldValue.increment(-1)},
      );

      final user = navigatorKey.currentState.context
          .read<AuthenticationBloc>()
          .state
          .storeUser;
      user.store.homeAnalytics.products -= 1;
      navigatorKey.currentState.context
          .read<AuthenticationBloc>()
          .add(AuthenticationEvent.userModified(user: user));

      return right(unit);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.customError(e.toString()));
    } catch (e) {
      return left(FirebaseFailure.customError(e.toString()));
    }
  }

  @override
  Future<Either<FirebaseFailure, Unit>> editProduct({
    Product product,
    File file,
  }) async {
    try {
      String fileUrl = '';
      String uid = _firebaseAuth.currentUser.uid;
      final CollectionReference colRef =
          _firebaseFirestore.storesCollection.doc(uid).productsCollection;
      if (file != null) {
        final UploadTask uploadTask = _storageRef
            .child("Products Images")
            .child(_firebaseAuth.currentUser.uid)
            .child(product.productId)
            .putFile(file);

        final TaskSnapshot storageSnap = await uploadTask.whenComplete(() {});
        fileUrl = await storageSnap.ref.getDownloadURL();
      } else {}
      final Map<String, dynamic> map = {
        'name': product.name,
        'code': product.code,
        'category': product.category,
        'quantity': product.quantity,
        'mrp': product.mrp,
        'sellingPrice': product.sellingPrice,
        'desc': product.desc,
      };
      if (fileUrl.isNotEmpty) map.putIfAbsent('image', () => fileUrl);
      await colRef.doc(product.productId).update(map);
      return right(unit);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.customError(e.toString()));
    } catch (e) {
      return left(FirebaseFailure.customError(e.toString()));
    }
  }
}
