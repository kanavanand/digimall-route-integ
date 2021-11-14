import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:prachar/domain/core/failure/firebase_failure.dart';
import 'package:prachar/domain/home/home_analytics.dart';
import 'package:prachar/domain/home/i_home_repo.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';

@LazySingleton(as: IHomeRepo)
class HomeRepo extends IHomeRepo {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  HomeRepo(this._firebaseFirestore, this._firebaseAuth);

  @override
  Future<Either<FirebaseFailure, HomeAnalytics>> getHomeAnalyticsData() async {
    // TODO: implement getHomeAnalyticsData
    try {
      DocumentSnapshot doc = await _firebaseFirestore.storesCollection
          .doc(_firebaseAuth.currentUser.uid)
          .get();
      HomeAnalytics home = HomeAnalytics.fromJson(
          doc.data()['analytics'] as Map<String, dynamic>);
      return right(home);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure.customError(e.toString()));
    } catch (e) {
      return left(FirebaseFailure.customError(e.toString()));
    }
  }
}
