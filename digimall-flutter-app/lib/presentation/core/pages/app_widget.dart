import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/application/auth/onboarding/onboarding_bloc.dart';
import 'package:prachar/application/home/orders/orders_bloc.dart';
import 'package:prachar/application/home/products/products_bloc.dart';
import 'package:prachar/presentation/core/pages/theme.dart';
import 'package:prachar/presentation/routes/router.gr.dart' as route;
import 'package:prachar/presentation/ui/home/home_page.dart';
import 'package:prachar/constants/constants.dart';
import '../../../injection.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppWidget extends StatelessWidget {
  const AppWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<OnboardingBloc>()
            ..add(
              const OnboardingEvent.initial(),
            ),
        ),
        BlocProvider(
          create: (context) => getIt<AuthenticationBloc>()
            ..add(const AuthenticationEvent.authCheckRequested()),
        ),
        BlocProvider(create: (context) => getIt<ProductsBloc>()),
        BlocProvider(create: (context) => getIt<OrdersBloc>()),
      ],
      child: MaterialApp(
        title: APP_NAME,
        debugShowCheckedModeBanner: false,
        builder: ExtendedNavigator(
          router: route.Router(),
          navigatorKey: navigatorKey,
        ),
        home: const HomePage(),
        navigatorKey: navigatorKey,
        theme: appThemeData[AppTheme.orangeLight],
      ),
    );
  }
}
