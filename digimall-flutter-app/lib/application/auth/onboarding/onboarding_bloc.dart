import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:prachar/domain/auth/i_auth_facade.dart';
import 'package:prachar/domain/core/failure/firebase_failure.dart';
import 'package:location/location.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter/services.dart';
import 'package:prachar/presentation/core/pages/app_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'onboarding_event.dart';
part 'onboarding_state.dart';
part 'onboarding_bloc.freezed.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final IAuthFacade iAuthFacade;
  OnboardingBloc(this.iAuthFacade) : super(OnboardingState.initial());

  @override
  Stream<OnboardingState> mapEventToState(
    OnboardingEvent event,
  ) async* {
    // TODO: implement mapEventToState
    yield* event.map(
      initial: (e) async* {
        final Address a = await getUserLocation();
        yield state.copyWith(
          getAddress: a,
        );
      },
      getDataStep1: (e) async* {
        yield state.copyWith(
          businessName: e.name,
          failureOption: none(),
          step: 2,
        );
      },
      getDataStep2AndSave: (e) async* {
        yield state.copyWith(
          isLoading: true,
          address: e.address,
          failureOption: none(),
        );

        final result = await iAuthFacade.saveStoreData(
          name: state.businessName,
          address: e.address,
          category: state.category,
          file: state.file,
          addressModel: state.getAddress,
        );

        yield state.copyWith(
          isLoading: false,
          failureOption: optionOf(result),
        );
      },
      getFile: (e) async* {
        yield state.copyWith(
          file: e.file,
          failureOption: none(),
        );
      },
      getCategory: (e) async* {
        yield state.copyWith(
          category: e.category,
        );
      },
    );
  }

  Future<Address> getUserLocation() async {
    LocationData myLocation;
    String error;
    final Location location = Location();

    try {
      myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        debugPrint(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        debugPrint(error);
      }
      myLocation = null;
    }
    final coordinates = Coordinates(myLocation.latitude, myLocation.longitude);
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    debugPrint(
        ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');

    return first;
  }
}
