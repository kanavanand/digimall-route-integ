part of 'orders_bloc.dart';

@freezed
abstract class OrdersState with _$OrdersState {
  const factory OrdersState({
    @required Option<Either<FirebaseFailure, Unit>> failureOption,
  }) = _OrdersState;

  factory OrdersState.initial() => OrdersState(
        failureOption: none(),
      );
}
