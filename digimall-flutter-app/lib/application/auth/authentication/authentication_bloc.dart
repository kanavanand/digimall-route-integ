import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:injectable/injectable.dart';
import 'package:prachar/domain/auth/i_auth_facade.dart';
import 'package:prachar/domain/auth/store.dart';
import 'package:prachar/domain/user/store_user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IAuthFacade _authFacade;
  AuthenticationBloc(
    this._authFacade,
  ) : super(AuthenticationState.initial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    // TODO: implement mapEventToState
    yield* event.map(
      authCheckRequested: (e) async* {
        final userOption = await _authFacade.getSignedInUser();
        yield userOption.fold(
          () {
            return state.copyWith(
              isSignedIn: false,
              isDetailsAvailable: false,
              storeUser: StoreUser.empty(),
            );
          },
          (userDetails) => userDetails.fold(
            (docNoExists) {
              return state.copyWith(
                isSignedIn: true,
                isDetailsAvailable: false,
                storeUser: StoreUser.empty(),
              );
            },
            (storeUser) {
              return state.copyWith(
                isSignedIn: true,
                storeUser: storeUser,
                isDetailsAvailable: true,
              );
            },
          ),
        );

        final opt = await _authFacade.getCategories();
        yield opt.fold((l) => null, (map) {
          return state.copyWith(
            categoriesMap: map,
          );
        });
      },
      signedOut: (e) async* {
        await _authFacade.signOut();
        yield state.copyWith(isSignedIn: false);
      },
      userModified: (e) async* {
        // e.user.store = state.
        yield state.copyWith(
          storeUser: e.user,
        );
      },
      updateUserLocation: (e) async* {
        yield state.copyWith(
          userCurrentAddress: e.address,
        );
      },
      getCategories: (e) async* {
        final opt = await _authFacade.getCategories();
        yield opt.fold((l) => null, (map) {
          return state.copyWith(
            categoriesMap: map,
          );
        });
      },
    );
  }
}
