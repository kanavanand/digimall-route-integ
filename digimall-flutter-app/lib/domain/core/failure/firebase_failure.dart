import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebase_failure.freezed.dart';

@freezed
abstract class FirebaseFailure with _$FirebaseFailure {
  const factory FirebaseFailure.customError(String error) = _CustomError;
}
