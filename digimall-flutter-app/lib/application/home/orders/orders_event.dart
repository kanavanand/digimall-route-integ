part of 'orders_bloc.dart';

@freezed
abstract class OrdersEvent with _$OrdersEvent {
  const factory OrdersEvent.started() = _Started;

  const factory OrdersEvent.rejectOrder({
    @required String id,
    @required String reason,
  }) = _RejectOrder;

  const factory OrdersEvent.acceptOrder({
    @required String deliveryEstimate,
    @required String id,
    @required int sale,
  }) = _AcceptOrder;
}
