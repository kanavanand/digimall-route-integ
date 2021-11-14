import 'package:dartz/dartz.dart';
import 'package:prachar/domain/core/failure/firebase_failure.dart';
import 'package:prachar/domain/home/home_analytics.dart';

abstract class IHomeRepo {
  Future<Either<FirebaseFailure, HomeAnalytics>> getHomeAnalyticsData();
}
