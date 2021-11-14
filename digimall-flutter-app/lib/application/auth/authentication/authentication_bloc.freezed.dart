// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'authentication_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$AuthenticationEventTearOff {
  const _$AuthenticationEventTearOff();

// ignore: unused_element
  AuthCheckRequested authCheckRequested() {
    return const AuthCheckRequested();
  }

// ignore: unused_element
  SignedOut signedOut() {
    return const SignedOut();
  }

// ignore: unused_element
  UserModified userModified({StoreUser user}) {
    return UserModified(
      user: user,
    );
  }

// ignore: unused_element
  _UpdateUserLocation updateUserLocation({Address address}) {
    return _UpdateUserLocation(
      address: address,
    );
  }

// ignore: unused_element
  _GetCategories getCategories() {
    return const _GetCategories();
  }
}

/// @nodoc
// ignore: unused_element
const $AuthenticationEvent = _$AuthenticationEventTearOff();

/// @nodoc
mixin _$AuthenticationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult authCheckRequested(),
    @required TResult signedOut(),
    @required TResult userModified(StoreUser user),
    @required TResult updateUserLocation(Address address),
    @required TResult getCategories(),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult authCheckRequested(),
    TResult signedOut(),
    TResult userModified(StoreUser user),
    TResult updateUserLocation(Address address),
    TResult getCategories(),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult authCheckRequested(AuthCheckRequested value),
    @required TResult signedOut(SignedOut value),
    @required TResult userModified(UserModified value),
    @required TResult updateUserLocation(_UpdateUserLocation value),
    @required TResult getCategories(_GetCategories value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult authCheckRequested(AuthCheckRequested value),
    TResult signedOut(SignedOut value),
    TResult userModified(UserModified value),
    TResult updateUserLocation(_UpdateUserLocation value),
    TResult getCategories(_GetCategories value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $AuthenticationEventCopyWith<$Res> {
  factory $AuthenticationEventCopyWith(
          AuthenticationEvent value, $Res Function(AuthenticationEvent) then) =
      _$AuthenticationEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthenticationEventCopyWithImpl<$Res>
    implements $AuthenticationEventCopyWith<$Res> {
  _$AuthenticationEventCopyWithImpl(this._value, this._then);

  final AuthenticationEvent _value;
  // ignore: unused_field
  final $Res Function(AuthenticationEvent) _then;
}

/// @nodoc
abstract class $AuthCheckRequestedCopyWith<$Res> {
  factory $AuthCheckRequestedCopyWith(
          AuthCheckRequested value, $Res Function(AuthCheckRequested) then) =
      _$AuthCheckRequestedCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthCheckRequestedCopyWithImpl<$Res>
    extends _$AuthenticationEventCopyWithImpl<$Res>
    implements $AuthCheckRequestedCopyWith<$Res> {
  _$AuthCheckRequestedCopyWithImpl(
      AuthCheckRequested _value, $Res Function(AuthCheckRequested) _then)
      : super(_value, (v) => _then(v as AuthCheckRequested));

  @override
  AuthCheckRequested get _value => super._value as AuthCheckRequested;
}

/// @nodoc
class _$AuthCheckRequested implements AuthCheckRequested {
  const _$AuthCheckRequested();

  @override
  String toString() {
    return 'AuthenticationEvent.authCheckRequested()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is AuthCheckRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult authCheckRequested(),
    @required TResult signedOut(),
    @required TResult userModified(StoreUser user),
    @required TResult updateUserLocation(Address address),
    @required TResult getCategories(),
  }) {
    assert(authCheckRequested != null);
    assert(signedOut != null);
    assert(userModified != null);
    assert(updateUserLocation != null);
    assert(getCategories != null);
    return authCheckRequested();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult authCheckRequested(),
    TResult signedOut(),
    TResult userModified(StoreUser user),
    TResult updateUserLocation(Address address),
    TResult getCategories(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (authCheckRequested != null) {
      return authCheckRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult authCheckRequested(AuthCheckRequested value),
    @required TResult signedOut(SignedOut value),
    @required TResult userModified(UserModified value),
    @required TResult updateUserLocation(_UpdateUserLocation value),
    @required TResult getCategories(_GetCategories value),
  }) {
    assert(authCheckRequested != null);
    assert(signedOut != null);
    assert(userModified != null);
    assert(updateUserLocation != null);
    assert(getCategories != null);
    return authCheckRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult authCheckRequested(AuthCheckRequested value),
    TResult signedOut(SignedOut value),
    TResult userModified(UserModified value),
    TResult updateUserLocation(_UpdateUserLocation value),
    TResult getCategories(_GetCategories value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (authCheckRequested != null) {
      return authCheckRequested(this);
    }
    return orElse();
  }
}

abstract class AuthCheckRequested implements AuthenticationEvent {
  const factory AuthCheckRequested() = _$AuthCheckRequested;
}

/// @nodoc
abstract class $SignedOutCopyWith<$Res> {
  factory $SignedOutCopyWith(SignedOut value, $Res Function(SignedOut) then) =
      _$SignedOutCopyWithImpl<$Res>;
}

/// @nodoc
class _$SignedOutCopyWithImpl<$Res>
    extends _$AuthenticationEventCopyWithImpl<$Res>
    implements $SignedOutCopyWith<$Res> {
  _$SignedOutCopyWithImpl(SignedOut _value, $Res Function(SignedOut) _then)
      : super(_value, (v) => _then(v as SignedOut));

  @override
  SignedOut get _value => super._value as SignedOut;
}

/// @nodoc
class _$SignedOut implements SignedOut {
  const _$SignedOut();

  @override
  String toString() {
    return 'AuthenticationEvent.signedOut()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is SignedOut);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult authCheckRequested(),
    @required TResult signedOut(),
    @required TResult userModified(StoreUser user),
    @required TResult updateUserLocation(Address address),
    @required TResult getCategories(),
  }) {
    assert(authCheckRequested != null);
    assert(signedOut != null);
    assert(userModified != null);
    assert(updateUserLocation != null);
    assert(getCategories != null);
    return signedOut();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult authCheckRequested(),
    TResult signedOut(),
    TResult userModified(StoreUser user),
    TResult updateUserLocation(Address address),
    TResult getCategories(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (signedOut != null) {
      return signedOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult authCheckRequested(AuthCheckRequested value),
    @required TResult signedOut(SignedOut value),
    @required TResult userModified(UserModified value),
    @required TResult updateUserLocation(_UpdateUserLocation value),
    @required TResult getCategories(_GetCategories value),
  }) {
    assert(authCheckRequested != null);
    assert(signedOut != null);
    assert(userModified != null);
    assert(updateUserLocation != null);
    assert(getCategories != null);
    return signedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult authCheckRequested(AuthCheckRequested value),
    TResult signedOut(SignedOut value),
    TResult userModified(UserModified value),
    TResult updateUserLocation(_UpdateUserLocation value),
    TResult getCategories(_GetCategories value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (signedOut != null) {
      return signedOut(this);
    }
    return orElse();
  }
}

abstract class SignedOut implements AuthenticationEvent {
  const factory SignedOut() = _$SignedOut;
}

/// @nodoc
abstract class $UserModifiedCopyWith<$Res> {
  factory $UserModifiedCopyWith(
          UserModified value, $Res Function(UserModified) then) =
      _$UserModifiedCopyWithImpl<$Res>;
  $Res call({StoreUser user});
}

/// @nodoc
class _$UserModifiedCopyWithImpl<$Res>
    extends _$AuthenticationEventCopyWithImpl<$Res>
    implements $UserModifiedCopyWith<$Res> {
  _$UserModifiedCopyWithImpl(
      UserModified _value, $Res Function(UserModified) _then)
      : super(_value, (v) => _then(v as UserModified));

  @override
  UserModified get _value => super._value as UserModified;

  @override
  $Res call({
    Object user = freezed,
  }) {
    return _then(UserModified(
      user: user == freezed ? _value.user : user as StoreUser,
    ));
  }
}

/// @nodoc
class _$UserModified implements UserModified {
  const _$UserModified({this.user});

  @override
  final StoreUser user;

  @override
  String toString() {
    return 'AuthenticationEvent.userModified(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserModified &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(user);

  @JsonKey(ignore: true)
  @override
  $UserModifiedCopyWith<UserModified> get copyWith =>
      _$UserModifiedCopyWithImpl<UserModified>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult authCheckRequested(),
    @required TResult signedOut(),
    @required TResult userModified(StoreUser user),
    @required TResult updateUserLocation(Address address),
    @required TResult getCategories(),
  }) {
    assert(authCheckRequested != null);
    assert(signedOut != null);
    assert(userModified != null);
    assert(updateUserLocation != null);
    assert(getCategories != null);
    return userModified(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult authCheckRequested(),
    TResult signedOut(),
    TResult userModified(StoreUser user),
    TResult updateUserLocation(Address address),
    TResult getCategories(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (userModified != null) {
      return userModified(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult authCheckRequested(AuthCheckRequested value),
    @required TResult signedOut(SignedOut value),
    @required TResult userModified(UserModified value),
    @required TResult updateUserLocation(_UpdateUserLocation value),
    @required TResult getCategories(_GetCategories value),
  }) {
    assert(authCheckRequested != null);
    assert(signedOut != null);
    assert(userModified != null);
    assert(updateUserLocation != null);
    assert(getCategories != null);
    return userModified(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult authCheckRequested(AuthCheckRequested value),
    TResult signedOut(SignedOut value),
    TResult userModified(UserModified value),
    TResult updateUserLocation(_UpdateUserLocation value),
    TResult getCategories(_GetCategories value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (userModified != null) {
      return userModified(this);
    }
    return orElse();
  }
}

abstract class UserModified implements AuthenticationEvent {
  const factory UserModified({StoreUser user}) = _$UserModified;

  StoreUser get user;
  @JsonKey(ignore: true)
  $UserModifiedCopyWith<UserModified> get copyWith;
}

/// @nodoc
abstract class _$UpdateUserLocationCopyWith<$Res> {
  factory _$UpdateUserLocationCopyWith(
          _UpdateUserLocation value, $Res Function(_UpdateUserLocation) then) =
      __$UpdateUserLocationCopyWithImpl<$Res>;
  $Res call({Address address});
}

/// @nodoc
class __$UpdateUserLocationCopyWithImpl<$Res>
    extends _$AuthenticationEventCopyWithImpl<$Res>
    implements _$UpdateUserLocationCopyWith<$Res> {
  __$UpdateUserLocationCopyWithImpl(
      _UpdateUserLocation _value, $Res Function(_UpdateUserLocation) _then)
      : super(_value, (v) => _then(v as _UpdateUserLocation));

  @override
  _UpdateUserLocation get _value => super._value as _UpdateUserLocation;

  @override
  $Res call({
    Object address = freezed,
  }) {
    return _then(_UpdateUserLocation(
      address: address == freezed ? _value.address : address as Address,
    ));
  }
}

/// @nodoc
class _$_UpdateUserLocation implements _UpdateUserLocation {
  const _$_UpdateUserLocation({this.address});

  @override
  final Address address;

  @override
  String toString() {
    return 'AuthenticationEvent.updateUserLocation(address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UpdateUserLocation &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(other.address, address)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(address);

  @JsonKey(ignore: true)
  @override
  _$UpdateUserLocationCopyWith<_UpdateUserLocation> get copyWith =>
      __$UpdateUserLocationCopyWithImpl<_UpdateUserLocation>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult authCheckRequested(),
    @required TResult signedOut(),
    @required TResult userModified(StoreUser user),
    @required TResult updateUserLocation(Address address),
    @required TResult getCategories(),
  }) {
    assert(authCheckRequested != null);
    assert(signedOut != null);
    assert(userModified != null);
    assert(updateUserLocation != null);
    assert(getCategories != null);
    return updateUserLocation(address);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult authCheckRequested(),
    TResult signedOut(),
    TResult userModified(StoreUser user),
    TResult updateUserLocation(Address address),
    TResult getCategories(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (updateUserLocation != null) {
      return updateUserLocation(address);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult authCheckRequested(AuthCheckRequested value),
    @required TResult signedOut(SignedOut value),
    @required TResult userModified(UserModified value),
    @required TResult updateUserLocation(_UpdateUserLocation value),
    @required TResult getCategories(_GetCategories value),
  }) {
    assert(authCheckRequested != null);
    assert(signedOut != null);
    assert(userModified != null);
    assert(updateUserLocation != null);
    assert(getCategories != null);
    return updateUserLocation(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult authCheckRequested(AuthCheckRequested value),
    TResult signedOut(SignedOut value),
    TResult userModified(UserModified value),
    TResult updateUserLocation(_UpdateUserLocation value),
    TResult getCategories(_GetCategories value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (updateUserLocation != null) {
      return updateUserLocation(this);
    }
    return orElse();
  }
}

abstract class _UpdateUserLocation implements AuthenticationEvent {
  const factory _UpdateUserLocation({Address address}) = _$_UpdateUserLocation;

  Address get address;
  @JsonKey(ignore: true)
  _$UpdateUserLocationCopyWith<_UpdateUserLocation> get copyWith;
}

/// @nodoc
abstract class _$GetCategoriesCopyWith<$Res> {
  factory _$GetCategoriesCopyWith(
          _GetCategories value, $Res Function(_GetCategories) then) =
      __$GetCategoriesCopyWithImpl<$Res>;
}

/// @nodoc
class __$GetCategoriesCopyWithImpl<$Res>
    extends _$AuthenticationEventCopyWithImpl<$Res>
    implements _$GetCategoriesCopyWith<$Res> {
  __$GetCategoriesCopyWithImpl(
      _GetCategories _value, $Res Function(_GetCategories) _then)
      : super(_value, (v) => _then(v as _GetCategories));

  @override
  _GetCategories get _value => super._value as _GetCategories;
}

/// @nodoc
class _$_GetCategories implements _GetCategories {
  const _$_GetCategories();

  @override
  String toString() {
    return 'AuthenticationEvent.getCategories()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _GetCategories);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult authCheckRequested(),
    @required TResult signedOut(),
    @required TResult userModified(StoreUser user),
    @required TResult updateUserLocation(Address address),
    @required TResult getCategories(),
  }) {
    assert(authCheckRequested != null);
    assert(signedOut != null);
    assert(userModified != null);
    assert(updateUserLocation != null);
    assert(getCategories != null);
    return getCategories();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult authCheckRequested(),
    TResult signedOut(),
    TResult userModified(StoreUser user),
    TResult updateUserLocation(Address address),
    TResult getCategories(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (getCategories != null) {
      return getCategories();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult authCheckRequested(AuthCheckRequested value),
    @required TResult signedOut(SignedOut value),
    @required TResult userModified(UserModified value),
    @required TResult updateUserLocation(_UpdateUserLocation value),
    @required TResult getCategories(_GetCategories value),
  }) {
    assert(authCheckRequested != null);
    assert(signedOut != null);
    assert(userModified != null);
    assert(updateUserLocation != null);
    assert(getCategories != null);
    return getCategories(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult authCheckRequested(AuthCheckRequested value),
    TResult signedOut(SignedOut value),
    TResult userModified(UserModified value),
    TResult updateUserLocation(_UpdateUserLocation value),
    TResult getCategories(_GetCategories value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (getCategories != null) {
      return getCategories(this);
    }
    return orElse();
  }
}

abstract class _GetCategories implements AuthenticationEvent {
  const factory _GetCategories() = _$_GetCategories;
}

/// @nodoc
class _$AuthenticationStateTearOff {
  const _$AuthenticationStateTearOff();

// ignore: unused_element
  _AuthenticationState call(
      {@required StoreUser storeUser,
      @required bool isSignedIn,
      @required bool isDetailsAvailable,
      Address userCurrentAddress,
      Map<String, dynamic> categoriesMap}) {
    return _AuthenticationState(
      storeUser: storeUser,
      isSignedIn: isSignedIn,
      isDetailsAvailable: isDetailsAvailable,
      userCurrentAddress: userCurrentAddress,
      categoriesMap: categoriesMap,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $AuthenticationState = _$AuthenticationStateTearOff();

/// @nodoc
mixin _$AuthenticationState {
  StoreUser get storeUser;
  bool get isSignedIn;
  bool get isDetailsAvailable;
  Address get userCurrentAddress;
  Map<String, dynamic> get categoriesMap;

  @JsonKey(ignore: true)
  $AuthenticationStateCopyWith<AuthenticationState> get copyWith;
}

/// @nodoc
abstract class $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationStateCopyWith(
          AuthenticationState value, $Res Function(AuthenticationState) then) =
      _$AuthenticationStateCopyWithImpl<$Res>;
  $Res call(
      {StoreUser storeUser,
      bool isSignedIn,
      bool isDetailsAvailable,
      Address userCurrentAddress,
      Map<String, dynamic> categoriesMap});
}

/// @nodoc
class _$AuthenticationStateCopyWithImpl<$Res>
    implements $AuthenticationStateCopyWith<$Res> {
  _$AuthenticationStateCopyWithImpl(this._value, this._then);

  final AuthenticationState _value;
  // ignore: unused_field
  final $Res Function(AuthenticationState) _then;

  @override
  $Res call({
    Object storeUser = freezed,
    Object isSignedIn = freezed,
    Object isDetailsAvailable = freezed,
    Object userCurrentAddress = freezed,
    Object categoriesMap = freezed,
  }) {
    return _then(_value.copyWith(
      storeUser:
          storeUser == freezed ? _value.storeUser : storeUser as StoreUser,
      isSignedIn:
          isSignedIn == freezed ? _value.isSignedIn : isSignedIn as bool,
      isDetailsAvailable: isDetailsAvailable == freezed
          ? _value.isDetailsAvailable
          : isDetailsAvailable as bool,
      userCurrentAddress: userCurrentAddress == freezed
          ? _value.userCurrentAddress
          : userCurrentAddress as Address,
      categoriesMap: categoriesMap == freezed
          ? _value.categoriesMap
          : categoriesMap as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$AuthenticationStateCopyWith<$Res>
    implements $AuthenticationStateCopyWith<$Res> {
  factory _$AuthenticationStateCopyWith(_AuthenticationState value,
          $Res Function(_AuthenticationState) then) =
      __$AuthenticationStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {StoreUser storeUser,
      bool isSignedIn,
      bool isDetailsAvailable,
      Address userCurrentAddress,
      Map<String, dynamic> categoriesMap});
}

/// @nodoc
class __$AuthenticationStateCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res>
    implements _$AuthenticationStateCopyWith<$Res> {
  __$AuthenticationStateCopyWithImpl(
      _AuthenticationState _value, $Res Function(_AuthenticationState) _then)
      : super(_value, (v) => _then(v as _AuthenticationState));

  @override
  _AuthenticationState get _value => super._value as _AuthenticationState;

  @override
  $Res call({
    Object storeUser = freezed,
    Object isSignedIn = freezed,
    Object isDetailsAvailable = freezed,
    Object userCurrentAddress = freezed,
    Object categoriesMap = freezed,
  }) {
    return _then(_AuthenticationState(
      storeUser:
          storeUser == freezed ? _value.storeUser : storeUser as StoreUser,
      isSignedIn:
          isSignedIn == freezed ? _value.isSignedIn : isSignedIn as bool,
      isDetailsAvailable: isDetailsAvailable == freezed
          ? _value.isDetailsAvailable
          : isDetailsAvailable as bool,
      userCurrentAddress: userCurrentAddress == freezed
          ? _value.userCurrentAddress
          : userCurrentAddress as Address,
      categoriesMap: categoriesMap == freezed
          ? _value.categoriesMap
          : categoriesMap as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
class _$_AuthenticationState implements _AuthenticationState {
  const _$_AuthenticationState(
      {@required this.storeUser,
      @required this.isSignedIn,
      @required this.isDetailsAvailable,
      this.userCurrentAddress,
      this.categoriesMap})
      : assert(storeUser != null),
        assert(isSignedIn != null),
        assert(isDetailsAvailable != null);

  @override
  final StoreUser storeUser;
  @override
  final bool isSignedIn;
  @override
  final bool isDetailsAvailable;
  @override
  final Address userCurrentAddress;
  @override
  final Map<String, dynamic> categoriesMap;

  @override
  String toString() {
    return 'AuthenticationState(storeUser: $storeUser, isSignedIn: $isSignedIn, isDetailsAvailable: $isDetailsAvailable, userCurrentAddress: $userCurrentAddress, categoriesMap: $categoriesMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthenticationState &&
            (identical(other.storeUser, storeUser) ||
                const DeepCollectionEquality()
                    .equals(other.storeUser, storeUser)) &&
            (identical(other.isSignedIn, isSignedIn) ||
                const DeepCollectionEquality()
                    .equals(other.isSignedIn, isSignedIn)) &&
            (identical(other.isDetailsAvailable, isDetailsAvailable) ||
                const DeepCollectionEquality()
                    .equals(other.isDetailsAvailable, isDetailsAvailable)) &&
            (identical(other.userCurrentAddress, userCurrentAddress) ||
                const DeepCollectionEquality()
                    .equals(other.userCurrentAddress, userCurrentAddress)) &&
            (identical(other.categoriesMap, categoriesMap) ||
                const DeepCollectionEquality()
                    .equals(other.categoriesMap, categoriesMap)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(storeUser) ^
      const DeepCollectionEquality().hash(isSignedIn) ^
      const DeepCollectionEquality().hash(isDetailsAvailable) ^
      const DeepCollectionEquality().hash(userCurrentAddress) ^
      const DeepCollectionEquality().hash(categoriesMap);

  @JsonKey(ignore: true)
  @override
  _$AuthenticationStateCopyWith<_AuthenticationState> get copyWith =>
      __$AuthenticationStateCopyWithImpl<_AuthenticationState>(
          this, _$identity);
}

abstract class _AuthenticationState implements AuthenticationState {
  const factory _AuthenticationState(
      {@required StoreUser storeUser,
      @required bool isSignedIn,
      @required bool isDetailsAvailable,
      Address userCurrentAddress,
      Map<String, dynamic> categoriesMap}) = _$_AuthenticationState;

  @override
  StoreUser get storeUser;
  @override
  bool get isSignedIn;
  @override
  bool get isDetailsAvailable;
  @override
  Address get userCurrentAddress;
  @override
  Map<String, dynamic> get categoriesMap;
  @override
  @JsonKey(ignore: true)
  _$AuthenticationStateCopyWith<_AuthenticationState> get copyWith;
}
