part of 'authentication_bloc.dart';

@freezed
abstract class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.authCheckRequested() = AuthCheckRequested;
  const factory AuthenticationEvent.signedOut() = SignedOut;
  const factory AuthenticationEvent.userModified({StoreUser user}) =
      UserModified;
  const factory AuthenticationEvent.updateUserLocation({Address address}) =
      _UpdateUserLocation;
  const factory AuthenticationEvent.getCategories() = _GetCategories;
}
