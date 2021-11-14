import 'package:auto_route/annotations.dart';
import 'package:prachar/presentation/auth/login/login.dart';
import 'package:prachar/presentation/auth/login/verify_login.dart';
import 'package:prachar/presentation/auth/onboarding/shop_details.dart';
import 'package:prachar/presentation/auth/onboarding/user_choice.dart';
import 'package:prachar/presentation/ui/base_page.dart';
import 'package:prachar/presentation/core/pages/splash.dart';
import 'package:prachar/presentation/ui/products/add_product.dart';
import 'package:prachar/presentation/ui/products/products_search.dart';
import 'package:prachar/presentation/ui/store/base_store.dart';
import 'package:prachar/presentation/ui/store/pages/cart/cart.dart';
import 'package:prachar/presentation/ui/store/pages/confirm_order.dart';
import 'package:prachar/presentation/ui/store/pages/delivery_address.dart';
import 'package:prachar/presentation/ui/store/pages/search_store.dart';
import 'package:prachar/presentation/ui/store/store_details/store_details.dart';
import 'package:prachar/presentation/ui/store/pages/user_orders_page.dart';

@MaterialAutoRouter(
    generateNavigationHelperExtension: true,
    routes: <AutoRoute>[
      MaterialRoute(page: SplashPage, initial: true),
      MaterialRoute(
        page: BasePage,
      ),
      MaterialRoute(
        page: ShopDetailsPage,
      ),
      MaterialRoute(
        page: AddProductPage,
      ),
      MaterialRoute(
        page: LoginPage,
      ),
      MaterialRoute(
        page: ProductsSearchStorePage,
      ),
      MaterialRoute(
        page: SearchStorePage,
      ),
      MaterialRoute(
        page: VerifyLoginPage,
      ),
      MaterialRoute(
        page: UserChoicePage,
      ),
      MaterialRoute(
        page: BaseStorePage,
      ),
      MaterialRoute(
        page: StoreDetailsPage,
      ),
      MaterialRoute(
        page: CartPage,
      ),
      MaterialRoute(
        page: DeliveryAddressPage,
      ),
      MaterialRoute(
        page: ConfirmOrderPage,
      ),
      MaterialRoute(
        page: UserOrdersPage,
      ),
    ])
class $Router {}
