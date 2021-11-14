import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:prachar/domain/core/failure/firebase_failure.dart';
import 'package:prachar/domain/home/orders/i_order_repo.dart';

part 'orders_event.dart';
part 'orders_state.dart';
part 'orders_bloc.freezed.dart';

@injectable
class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final IOrderRepo iOrderRepo;
  OrdersBloc(this.iOrderRepo) : super(OrdersState.initial());

  @override
  Stream<OrdersState> mapEventToState(
    OrdersEvent event,
  ) async* {
    // TODO: implement mapEventToState

    yield* event.map(
        acceptOrder: (e) async* {
          yield state.copyWith(
            failureOption: none(),
          );

          final opt = await iOrderRepo.acceptOrder(
            deliveryEstimate: e.deliveryEstimate,
            orderId: e.id,
            sale: e.sale,
          );

          yield state.copyWith(
            failureOption: optionOf(opt),
          );
        },
        rejectOrder: (e) async* {
          yield state.copyWith(failureOption: none());
          final opt = await iOrderRepo.rejectOrder(
            orderId: e.id,
            reason: e.reason,
          );
          yield state.copyWith(
            failureOption: optionOf(opt),
          );
        },
        started: (e) async* {});
  }
}
