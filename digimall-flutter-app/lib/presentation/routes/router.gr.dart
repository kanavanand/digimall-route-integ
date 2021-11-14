// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:auto_route/legacy.dart';
import 'package:flutter/material.dart';

import '../../domain/auth/store.dart';
import '../../domain/home/product/product.dart';
import '../auth/login/login.dart';
import '../auth/login/verify_login.dart';
import '../auth/onboarding/shop_details.dart';
import '../auth/onboarding/user_choice.dart';
import '../core/pages/splash.dart';
import '../ui/base_page.dart';
import '../ui/products/add_product.dart';
import '../ui/products/products_search.dart';
import '../ui/store/base_store.dart';
import '../ui/store/pages/cart/cart.dart';
import '../ui/store/pages/confirm_order.dart';
import '../ui/store/pages/delivery_address.dart';
import '../ui/store/pages/search_store.dart';
import '../ui/store/pages/user_orders_page.dart';
import '../ui/store/store_details/store_details.dart';

class Routes {
  static const String splashPage = '/';
  static const String basePage = '/base-page';
  static const String shopDetailsPage = '/shop-details-page';
  static const String addProductPage = '/add-product-page';
  static const String loginPage = '/login-page';
  static const String productsSearchStorePage = '/products-search-store-page';
  static const String searchStorePage = '/search-store-page';
  static const String verifyLoginPage = '/verify-login-page';
  static const String userChoicePage = '/user-choice-page';
  static const String baseStorePage = '/base-store-page';
  static const String storeDetailsPage = '/store-details-page';
  static const String cartPage = '/cart-page';
  static const String deliveryAddressPage = '/delivery-address-page';
  static const String confirmOrderPage = '/confirm-order-page';
  static const String userOrdersPage = '/user-orders-page';
  static const all = <String>{
    splashPage,
    basePage,
    shopDetailsPage,
    addProductPage,
    loginPage,
    productsSearchStorePage,
    searchStorePage,
    verifyLoginPage,
    userChoicePage,
    baseStorePage,
    storeDetailsPage,
    cartPage,
    deliveryAddressPage,
    confirmOrderPage,
    userOrdersPage,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashPage, page: SplashPage),
    RouteDef(Routes.basePage, page: BasePage),
    RouteDef(Routes.shopDetailsPage, page: ShopDetailsPage),
    RouteDef(Routes.addProductPage, page: AddProductPage),
    RouteDef(Routes.loginPage, page: LoginPage),
    RouteDef(Routes.productsSearchStorePage, page: ProductsSearchStorePage),
    RouteDef(Routes.searchStorePage, page: SearchStorePage),
    RouteDef(Routes.verifyLoginPage, page: VerifyLoginPage),
    RouteDef(Routes.userChoicePage, page: UserChoicePage),
    RouteDef(Routes.baseStorePage, page: BaseStorePage),
    RouteDef(Routes.storeDetailsPage, page: StoreDetailsPage),
    RouteDef(Routes.cartPage, page: CartPage),
    RouteDef(Routes.deliveryAddressPage, page: DeliveryAddressPage),
    RouteDef(Routes.confirmOrderPage, page: ConfirmOrderPage),
    RouteDef(Routes.userOrdersPage, page: UserOrdersPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SplashPage(),
        settings: data,
      );
    },
    BasePage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const BasePage(),
        settings: data,
      );
    },
    ShopDetailsPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ShopDetailsPage(),
        settings: data,
      );
    },
    AddProductPage: (data) {
      final args = data.getArgs<AddProductPageArguments>(
        orElse: () => AddProductPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddProductPage(
          key: args.key,
          product: args.product,
          updateProductsFn: args.updateProductsFn,
        ),
        settings: data,
      );
    },
    LoginPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LoginPage(),
        settings: data,
      );
    },
    ProductsSearchStorePage: (data) {
      final args =
          data.getArgs<ProductsSearchStorePageArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProductsSearchStorePage(
          key: args.key,
          store: args.store,
          productsSearchType: args.productsSearchType,
        ),
        settings: data,
      );
    },
    SearchStorePage: (data) {
      final args = data.getArgs<SearchStorePageArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SearchStorePage(
          key: args.key,
          searchStoreType: args.searchStoreType,
          searchSavedStore: args.searchSavedStore,
        ),
        settings: data,
      );
    },
    VerifyLoginPage: (data) {
      final args = data.getArgs<VerifyLoginPageArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => VerifyLoginPage(
          key: args.key,
          verificationId: args.verificationId,
          resentToken: args.resentToken,
          mobileNo: args.mobileNo,
        ),
        settings: data,
      );
    },
    UserChoicePage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const UserChoicePage(),
        settings: data,
      );
    },
    BaseStorePage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const BaseStorePage(),
        settings: data,
      );
    },
    StoreDetailsPage: (data) {
      final args = data.getArgs<StoreDetailsPageArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => StoreDetailsPage(
          key: args.key,
          store: args.store,
        ),
        settings: data,
      );
    },
    CartPage: (data) {
      final args = data.getArgs<CartPageArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => CartPage(
          key: args.key,
          store: args.store,
        ),
        settings: data,
      );
    },
    DeliveryAddressPage: (data) {
      final args = data.getArgs<DeliveryAddressPageArguments>(
        orElse: () => DeliveryAddressPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => DeliveryAddressPage(key: args.key),
        settings: data,
      );
    },
    ConfirmOrderPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ConfirmOrderPage(),
        settings: data,
      );
    },
    UserOrdersPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const UserOrdersPage(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushSplashPage() => push<dynamic>(Routes.splashPage);

  Future<dynamic> pushBasePage() => push<dynamic>(Routes.basePage);

  Future<dynamic> pushShopDetailsPage() =>
      push<dynamic>(Routes.shopDetailsPage);

  Future<dynamic> pushAddProductPage({
    Key key,
    Product product,
    Function updateProductsFn,
  }) =>
      push<dynamic>(
        Routes.addProductPage,
        arguments: AddProductPageArguments(
            key: key, product: product, updateProductsFn: updateProductsFn),
      );

  Future<dynamic> pushLoginPage() => push<dynamic>(Routes.loginPage);

  Future<dynamic> pushProductsSearchStorePage({
    Key key,
    Store store,
    @required ProductsSearchType productsSearchType,
  }) =>
      push<dynamic>(
        Routes.productsSearchStorePage,
        arguments: ProductsSearchStorePageArguments(
            key: key, store: store, productsSearchType: productsSearchType),
      );

  Future<dynamic> pushSearchStorePage({
    Key key,
    @required SearchStoreType searchStoreType,
    @required bool searchSavedStore,
  }) =>
      push<dynamic>(
        Routes.searchStorePage,
        arguments: SearchStorePageArguments(
            key: key,
            searchStoreType: searchStoreType,
            searchSavedStore: searchSavedStore),
      );

  Future<dynamic> pushVerifyLoginPage({
    Key key,
    @required String verificationId,
    @required int resentToken,
    @required String mobileNo,
  }) =>
      push<dynamic>(
        Routes.verifyLoginPage,
        arguments: VerifyLoginPageArguments(
            key: key,
            verificationId: verificationId,
            resentToken: resentToken,
            mobileNo: mobileNo),
      );

  Future<dynamic> pushUserChoicePage() => push<dynamic>(Routes.userChoicePage);

  Future<dynamic> pushBaseStorePage() => push<dynamic>(Routes.baseStorePage);

  Future<dynamic> pushStoreDetailsPage({
    Key key,
    @required Store store,
  }) =>
      push<dynamic>(
        Routes.storeDetailsPage,
        arguments: StoreDetailsPageArguments(key: key, store: store),
      );

  Future<dynamic> pushCartPage({
    Key key,
    @required Store store,
  }) =>
      push<dynamic>(
        Routes.cartPage,
        arguments: CartPageArguments(key: key, store: store),
      );

  Future<dynamic> pushDeliveryAddressPage({
    Key key,
  }) =>
      push<dynamic>(
        Routes.deliveryAddressPage,
        arguments: DeliveryAddressPageArguments(key: key),
      );

  Future<dynamic> pushConfirmOrderPage() =>
      push<dynamic>(Routes.confirmOrderPage);

  Future<dynamic> pushUserOrdersPage() => push<dynamic>(Routes.userOrdersPage);
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// AddProductPage arguments holder class
class AddProductPageArguments {
  final Key key;
  final Product product;
  final Function updateProductsFn;
  AddProductPageArguments({this.key, this.product, this.updateProductsFn});
}

/// ProductsSearchStorePage arguments holder class
class ProductsSearchStorePageArguments {
  final Key key;
  final Store store;
  final ProductsSearchType productsSearchType;
  ProductsSearchStorePageArguments(
      {this.key, this.store, @required this.productsSearchType});
}

/// SearchStorePage arguments holder class
class SearchStorePageArguments {
  final Key key;
  final SearchStoreType searchStoreType;
  final bool searchSavedStore;
  SearchStorePageArguments(
      {this.key,
      @required this.searchStoreType,
      @required this.searchSavedStore});
}

/// VerifyLoginPage arguments holder class
class VerifyLoginPageArguments {
  final Key key;
  final String verificationId;
  final int resentToken;
  final String mobileNo;
  VerifyLoginPageArguments(
      {this.key,
      @required this.verificationId,
      @required this.resentToken,
      @required this.mobileNo});
}

/// StoreDetailsPage arguments holder class
class StoreDetailsPageArguments {
  final Key key;
  final Store store;
  StoreDetailsPageArguments({this.key, @required this.store});
}

/// CartPage arguments holder class
class CartPageArguments {
  final Key key;
  final Store store;
  CartPageArguments({this.key, @required this.store});
}

/// DeliveryAddressPage arguments holder class
class DeliveryAddressPageArguments {
  final Key key;
  DeliveryAddressPageArguments({this.key});
}
