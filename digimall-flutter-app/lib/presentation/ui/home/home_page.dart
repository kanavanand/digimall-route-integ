import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/presentation/core/widgets/loading.dart';
import 'package:prachar/presentation/ui/home/widgets/analytics.dart';
import 'package:prachar/presentation/ui/home/widgets/link.dart';
import 'package:prachar/presentation/ui/home/widgets/store_detail.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              StoreDetailsWidget(
                name: state.storeUser?.store?.name ?? 'Store',
                image: state.storeUser?.store?.image ?? '',
              ),
              const SizedBox(
                height: 20,
              ),
              const LinkWidget(),
              const SizedBox(
                height: 16,
              ),
              const AnalyticsSellerWidget(),
            ],
          ),
        )
            // : const Center(
            //     child: CircularProgressLoading(),
            //   )
            ;
      },
    );
  }
}
