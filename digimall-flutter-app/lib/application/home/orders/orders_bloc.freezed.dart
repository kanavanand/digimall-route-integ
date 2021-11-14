// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'orders_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$OrdersEventTearOff {
  const _$OrdersEventTearOff();

// ignore: unused_element
  _Started started() {
    return const _Started();
  }

// ignore: unused_element
  _RejectOrder rejectOrder({@required String id, @required String reason}) {
    return _RejectOrder(
      id: id,
      reason: reason,
    );
  }

// ignore: unused_element
  _AcceptOrder acceptOrder(
      {@required String deliveryEstimate,
      @required String id,
      @required int sale}) {
    return _AcceptOrder(
      deliveryEstimate: deliveryEstimate,
      id: id,
      sale: sale,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $OrdersEvent = _$OrdersEventTearOff();

/// @nodoc
mixin _$OrdersEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult started(),
    @required TResult rejectOrder(String id, String reason),
    @required TResult acceptOrder(String deliveryEstimate, String id, int sale),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult started(),
    TResult rejectOrder(String id, String reason),
    TResult acceptOrder(String deliveryEstimate, String id, int sale),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult started(_Started value),
    @required TResult rejectOrder(_RejectOrder value),
    @required TResult acceptOrder(_AcceptOrder value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult started(_Started value),
    TResult rejectOrder(_RejectOrder value),
    TResult acceptOrder(_AcceptOrder value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $OrdersEventCopyWith<$Res> {
  factory $OrdersEventCopyWith(
          OrdersEvent value, $Res Function(OrdersEvent) then) =
      _$OrdersEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$OrdersEventCopyWithImpl<$Res> implements $OrdersEventCopyWith<$Res> {
  _$OrdersEventCopyWithImpl(this._value, this._then);

  final OrdersEvent _value;
  // ignore: unused_field
  final $Res Function(OrdersEvent) _then;
}

/// @nodoc
abstract class _$StartedCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) then) =
      __$StartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$StartedCopyWithImpl<$Res> extends _$OrdersEventCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(_Started _value, $Res Function(_Started) _then)
      : super(_value, (v) => _then(v as _Started));

  @override
  _Started get _value => super._value as _Started;
}

/// @nodoc
class _$_Started implements _Started {
  const _$_Started();

  @override
  String toString() {
    return 'OrdersEvent.started()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Started);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult started(),
    @required TResult rejectOrder(String id, String reason),
    @required TResult acceptOrder(String deliveryEstimate, String id, int sale),
  }) {
    assert(started != null);
    assert(rejectOrder != null);
    assert(acceptOrder != null);
    return started();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult started(),
    TResult rejectOrder(String id, String reason),
    TResult acceptOrder(String deliveryEstimate, String id, int sale),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult started(_Started value),
    @required TResult rejectOrder(_RejectOrder value),
    @required TResult acceptOrder(_AcceptOrder value),
  }) {
    assert(started != null);
    assert(rejectOrder != null);
    assert(acceptOrder != null);
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult started(_Started value),
    TResult rejectOrder(_RejectOrder value),
    TResult acceptOrder(_AcceptOrder value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements OrdersEvent {
  const factory _Started() = _$_Started;
}

/// @nodoc
abstract class _$RejectOrderCopyWith<$Res> {
  factory _$RejectOrderCopyWith(
          _RejectOrder value, $Res Function(_RejectOrder) then) =
      __$RejectOrderCopyWithImpl<$Res>;
  $Res call({String id, String reason});
}

/// @nodoc
class __$RejectOrderCopyWithImpl<$Res> extends _$OrdersEventCopyWithImpl<$Res>
    implements _$RejectOrderCopyWith<$Res> {
  __$RejectOrderCopyWithImpl(
      _RejectOrder _value, $Res Function(_RejectOrder) _then)
      : super(_value, (v) => _then(v as _RejectOrder));

  @override
  _RejectOrder get _value => super._value as _RejectOrder;

  @override
  $Res call({
    Object id = freezed,
    Object reason = freezed,
  }) {
    return _then(_RejectOrder(
      id: id == freezed ? _value.id : id as String,
      reason: reason == freezed ? _value.reason : reason as String,
    ));
  }
}

/// @nodoc
class _$_RejectOrder implements _RejectOrder {
  const _$_RejectOrder({@required this.id, @required this.reason})
      : assert(id != null),
        assert(reason != null);

  @override
  final String id;
  @override
  final String reason;

  @override
  String toString() {
    return 'OrdersEvent.rejectOrder(id: $id, reason: $reason)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RejectOrder &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(reason);

  @JsonKey(ignore: true)
  @override
  _$RejectOrderCopyWith<_RejectOrder> get copyWith =>
      __$RejectOrderCopyWithImpl<_RejectOrder>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult started(),
    @required TResult rejectOrder(String id, String reason),
    @required TResult acceptOrder(String deliveryEstimate, String id, int sale),
  }) {
    assert(started != null);
    assert(rejectOrder != null);
    assert(acceptOrder != null);
    return rejectOrder(id, reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult started(),
    TResult rejectOrder(String id, String reason),
    TResult acceptOrder(String deliveryEstimate, String id, int sale),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (rejectOrder != null) {
      return rejectOrder(id, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult started(_Started value),
    @required TResult rejectOrder(_RejectOrder value),
    @required TResult acceptOrder(_AcceptOrder value),
  }) {
    assert(started != null);
    assert(rejectOrder != null);
    assert(acceptOrder != null);
    return rejectOrder(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult started(_Started value),
    TResult rejectOrder(_RejectOrder value),
    TResult acceptOrder(_AcceptOrder value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (rejectOrder != null) {
      return rejectOrder(this);
    }
    return orElse();
  }
}

abstract class _RejectOrder implements OrdersEvent {
  const factory _RejectOrder({@required String id, @required String reason}) =
      _$_RejectOrder;

  String get id;
  String get reason;
  @JsonKey(ignore: true)
  _$RejectOrderCopyWith<_RejectOrder> get copyWith;
}

/// @nodoc
abstract class _$AcceptOrderCopyWith<$Res> {
  factory _$AcceptOrderCopyWith(
          _AcceptOrder value, $Res Function(_AcceptOrder) then) =
      __$AcceptOrderCopyWithImpl<$Res>;
  $Res call({String deliveryEstimate, String id, int sale});
}

/// @nodoc
class __$AcceptOrderCopyWithImpl<$Res> extends _$OrdersEventCopyWithImpl<$Res>
    implements _$AcceptOrderCopyWith<$Res> {
  __$AcceptOrderCopyWithImpl(
      _AcceptOrder _value, $Res Function(_AcceptOrder) _then)
      : super(_value, (v) => _then(v as _AcceptOrder));

  @override
  _AcceptOrder get _value => super._value as _AcceptOrder;

  @override
  $Res call({
    Object deliveryEstimate = freezed,
    Object id = freezed,
    Object sale = freezed,
  }) {
    return _then(_AcceptOrder(
      deliveryEstimate: deliveryEstimate == freezed
          ? _value.deliveryEstimate
          : deliveryEstimate as String,
      id: id == freezed ? _value.id : id as String,
      sale: sale == freezed ? _value.sale : sale as int,
    ));
  }
}

/// @nodoc
class _$_AcceptOrder implements _AcceptOrder {
  const _$_AcceptOrder(
      {@required this.deliveryEstimate, @required this.id, @required this.sale})
      : assert(deliveryEstimate != null),
        assert(id != null),
        assert(sale != null);

  @override
  final String deliveryEstimate;
  @override
  final String id;
  @override
  final int sale;

  @override
  String toString() {
    return 'OrdersEvent.acceptOrder(deliveryEstimate: $deliveryEstimate, id: $id, sale: $sale)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AcceptOrder &&
            (identical(other.deliveryEstimate, deliveryEstimate) ||
                const DeepCollectionEquality()
                    .equals(other.deliveryEstimate, deliveryEstimate)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.sale, sale) ||
                const DeepCollectionEquality().equals(other.sale, sale)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(deliveryEstimate) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(sale);

  @JsonKey(ignore: true)
  @override
  _$AcceptOrderCopyWith<_AcceptOrder> get copyWith =>
      __$AcceptOrderCopyWithImpl<_AcceptOrder>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult started(),
    @required TResult rejectOrder(String id, String reason),
    @required TResult acceptOrder(String deliveryEstimate, String id, int sale),
  }) {
    assert(started != null);
    assert(rejectOrder != null);
    assert(acceptOrder != null);
    return acceptOrder(deliveryEstimate, id, sale);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult started(),
    TResult rejectOrder(String id, String reason),
    TResult acceptOrder(String deliveryEstimate, String id, int sale),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (acceptOrder != null) {
      return acceptOrder(deliveryEstimate, id, sale);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult started(_Started value),
    @required TResult rejectOrder(_RejectOrder value),
    @required TResult acceptOrder(_AcceptOrder value),
  }) {
    assert(started != null);
    assert(rejectOrder != null);
    assert(acceptOrder != null);
    return acceptOrder(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult started(_Started value),
    TResult rejectOrder(_RejectOrder value),
    TResult acceptOrder(_AcceptOrder value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (acceptOrder != null) {
      return acceptOrder(this);
    }
    return orElse();
  }
}

abstract class _AcceptOrder implements OrdersEvent {
  const factory _AcceptOrder(
      {@required String deliveryEstimate,
      @required String id,
      @required int sale}) = _$_AcceptOrder;

  String get deliveryEstimate;
  String get id;
  int get sale;
  @JsonKey(ignore: true)
  _$AcceptOrderCopyWith<_AcceptOrder> get copyWith;
}

/// @nodoc
class _$OrdersStateTearOff {
  const _$OrdersStateTearOff();

// ignore: unused_element
  _OrdersState call(
      {@required Option<Either<FirebaseFailure, Unit>> failureOption}) {
    return _OrdersState(
      failureOption: failureOption,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $OrdersState = _$OrdersStateTearOff();

/// @nodoc
mixin _$OrdersState {
  Option<Either<FirebaseFailure, Unit>> get failureOption;

  @JsonKey(ignore: true)
  $OrdersStateCopyWith<OrdersState> get copyWith;
}

/// @nodoc
abstract class $OrdersStateCopyWith<$Res> {
  factory $OrdersStateCopyWith(
          OrdersState value, $Res Function(OrdersState) then) =
      _$OrdersStateCopyWithImpl<$Res>;
  $Res call({Option<Either<FirebaseFailure, Unit>> failureOption});
}

/// @nodoc
class _$OrdersStateCopyWithImpl<$Res> implements $OrdersStateCopyWith<$Res> {
  _$OrdersStateCopyWithImpl(this._value, this._then);

  final OrdersState _value;
  // ignore: unused_field
  final $Res Function(OrdersState) _then;

  @override
  $Res call({
    Object failureOption = freezed,
  }) {
    return _then(_value.copyWith(
      failureOption: failureOption == freezed
          ? _value.failureOption
          : failureOption as Option<Either<FirebaseFailure, Unit>>,
    ));
  }
}

/// @nodoc
abstract class _$OrdersStateCopyWith<$Res>
    implements $OrdersStateCopyWith<$Res> {
  factory _$OrdersStateCopyWith(
          _OrdersState value, $Res Function(_OrdersState) then) =
      __$OrdersStateCopyWithImpl<$Res>;
  @override
  $Res call({Option<Either<FirebaseFailure, Unit>> failureOption});
}

/// @nodoc
class __$OrdersStateCopyWithImpl<$Res> extends _$OrdersStateCopyWithImpl<$Res>
    implements _$OrdersStateCopyWith<$Res> {
  __$OrdersStateCopyWithImpl(
      _OrdersState _value, $Res Function(_OrdersState) _then)
      : super(_value, (v) => _then(v as _OrdersState));

  @override
  _OrdersState get _value => super._value as _OrdersState;

  @override
  $Res call({
    Object failureOption = freezed,
  }) {
    return _then(_OrdersState(
      failureOption: failureOption == freezed
          ? _value.failureOption
          : failureOption as Option<Either<FirebaseFailure, Unit>>,
    ));
  }
}

/// @nodoc
class _$_OrdersState implements _OrdersState {
  const _$_OrdersState({@required this.failureOption})
      : assert(failureOption != null);

  @override
  final Option<Either<FirebaseFailure, Unit>> failureOption;

  @override
  String toString() {
    return 'OrdersState(failureOption: $failureOption)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _OrdersState &&
            (identical(other.failureOption, failureOption) ||
                const DeepCollectionEquality()
                    .equals(other.failureOption, failureOption)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failureOption);

  @JsonKey(ignore: true)
  @override
  _$OrdersStateCopyWith<_OrdersState> get copyWith =>
      __$OrdersStateCopyWithImpl<_OrdersState>(this, _$identity);
}

abstract class _OrdersState implements OrdersState {
  const factory _OrdersState(
          {@required Option<Either<FirebaseFailure, Unit>> failureOption}) =
      _$_OrdersState;

  @override
  Option<Either<FirebaseFailure, Unit>> get failureOption;
  @override
  @JsonKey(ignore: true)
  _$OrdersStateCopyWith<_OrdersState> get copyWith;
}
