part of 'authentication_bloc.dart';

@freezed
abstract class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    @required StoreUser storeUser,
    @required bool isSignedIn,
    @required bool isDetailsAvailable,
    Address userCurrentAddress,
    Map<String, dynamic> categoriesMap,
  }) = _AuthenticationState;

  factory AuthenticationState.initial() => AuthenticationState(
        isSignedIn: false,
        isDetailsAvailable: false,
        storeUser: StoreUser.empty(),
      );
}
