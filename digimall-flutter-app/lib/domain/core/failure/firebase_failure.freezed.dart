// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'firebase_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$FirebaseFailureTearOff {
  const _$FirebaseFailureTearOff();

// ignore: unused_element
  _CustomError customError(String error) {
    return _CustomError(
      error,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $FirebaseFailure = _$FirebaseFailureTearOff();

/// @nodoc
mixin _$FirebaseFailure {
  String get error;

  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult customError(String error),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult customError(String error),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult customError(_CustomError value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult customError(_CustomError value),
    @required TResult orElse(),
  });

  @JsonKey(ignore: true)
  $FirebaseFailureCopyWith<FirebaseFailure> get copyWith;
}

/// @nodoc
abstract class $FirebaseFailureCopyWith<$Res> {
  factory $FirebaseFailureCopyWith(
          FirebaseFailure value, $Res Function(FirebaseFailure) then) =
      _$FirebaseFailureCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class _$FirebaseFailureCopyWithImpl<$Res>
    implements $FirebaseFailureCopyWith<$Res> {
  _$FirebaseFailureCopyWithImpl(this._value, this._then);

  final FirebaseFailure _value;
  // ignore: unused_field
  final $Res Function(FirebaseFailure) _then;

  @override
  $Res call({
    Object error = freezed,
  }) {
    return _then(_value.copyWith(
      error: error == freezed ? _value.error : error as String,
    ));
  }
}

/// @nodoc
abstract class _$CustomErrorCopyWith<$Res>
    implements $FirebaseFailureCopyWith<$Res> {
  factory _$CustomErrorCopyWith(
          _CustomError value, $Res Function(_CustomError) then) =
      __$CustomErrorCopyWithImpl<$Res>;
  @override
  $Res call({String error});
}

/// @nodoc
class __$CustomErrorCopyWithImpl<$Res>
    extends _$FirebaseFailureCopyWithImpl<$Res>
    implements _$CustomErrorCopyWith<$Res> {
  __$CustomErrorCopyWithImpl(
      _CustomError _value, $Res Function(_CustomError) _then)
      : super(_value, (v) => _then(v as _CustomError));

  @override
  _CustomError get _value => super._value as _CustomError;

  @override
  $Res call({
    Object error = freezed,
  }) {
    return _then(_CustomError(
      error == freezed ? _value.error : error as String,
    ));
  }
}

/// @nodoc
class _$_CustomError implements _CustomError {
  const _$_CustomError(this.error) : assert(error != null);

  @override
  final String error;

  @override
  String toString() {
    return 'FirebaseFailure.customError(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CustomError &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  _$CustomErrorCopyWith<_CustomError> get copyWith =>
      __$CustomErrorCopyWithImpl<_CustomError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult customError(String error),
  }) {
    assert(customError != null);
    return customError(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult customError(String error),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (customError != null) {
      return customError(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult customError(_CustomError value),
  }) {
    assert(customError != null);
    return customError(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult customError(_CustomError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (customError != null) {
      return customError(this);
    }
    return orElse();
  }
}

abstract class _CustomError implements FirebaseFailure {
  const factory _CustomError(String error) = _$_CustomError;

  @override
  String get error;
  @override
  @JsonKey(ignore: true)
  _$CustomErrorCopyWith<_CustomError> get copyWith;
}
