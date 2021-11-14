// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_storage/firebase_storage.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/auth/authentication/authentication_bloc.dart' as _i17;
import 'application/auth/onboarding/onboarding_bloc.dart' as _i14;
import 'application/home/orders/orders_bloc.dart' as _i15;
import 'application/home/products/products_bloc.dart' as _i16;
import 'domain/auth/i_auth_facade.dart' as _i8;
import 'domain/home/i_home_repo.dart' as _i5;
import 'domain/home/orders/i_order_repo.dart' as _i10;
import 'domain/home/product/i_product_repo.dart' as _i12;
import 'infrastructure/auth/auth_facade.dart' as _i9;
import 'infrastructure/core/firebase_injectable_module.dart' as _i18;
import 'infrastructure/home/home_repo.dart' as _i6;
import 'infrastructure/home/orders/order_repo.dart' as _i11;
import 'infrastructure/home/products/product_repo.dart'
    as _i13; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<_i3.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i4.FirebaseFirestore>(
      () => firebaseInjectableModule.firestore);
  gh.lazySingleton<_i5.IHomeRepo>(() =>
      _i6.HomeRepo(get<_i4.FirebaseFirestore>(), get<_i3.FirebaseAuth>()));
  gh.lazySingleton<_i7.Reference>(
      () => firebaseInjectableModule.storageReference);
  gh.lazySingleton<_i8.IAuthFacade>(() => _i9.AuthFacade(
      get<_i3.FirebaseAuth>(),
      get<_i4.FirebaseFirestore>(),
      get<_i7.Reference>()));
  gh.lazySingleton<_i10.IOrderRepo>(() => _i11.OrderRepo(
      get<_i4.FirebaseFirestore>(),
      get<_i7.Reference>(),
      get<_i3.FirebaseAuth>()));
  gh.lazySingleton<_i12.IProductRepo>(() => _i13.ProductRepo(
      get<_i4.FirebaseFirestore>(),
      get<_i7.Reference>(),
      get<_i3.FirebaseAuth>()));
  gh.factory<_i14.OnboardingBloc>(
      () => _i14.OnboardingBloc(get<_i8.IAuthFacade>()));
  gh.factory<_i15.OrdersBloc>(() => _i15.OrdersBloc(get<_i10.IOrderRepo>()));
  gh.factory<_i16.ProductsBloc>(
      () => _i16.ProductsBloc(get<_i12.IProductRepo>()));
  gh.factory<_i17.AuthenticationBloc>(
      () => _i17.AuthenticationBloc(get<_i8.IAuthFacade>()));
  return get;
}

class _$FirebaseInjectableModule extends _i18.FirebaseInjectableModule {}
