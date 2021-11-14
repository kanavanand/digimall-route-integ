import 'package:dartz/dartz.dart';
import 'package:prachar/domain/core/failure/firebase_failure.dart';

abstract class IOrderRepo {
  Future<Either<FirebaseFailure, Unit>> acceptOrder({
    String deliveryEstimate,
    String orderId,
    int sale,
  });
  Future<Either<FirebaseFailure, Unit>> rejectOrder({
    String orderId,
    String reason,
  });
}
