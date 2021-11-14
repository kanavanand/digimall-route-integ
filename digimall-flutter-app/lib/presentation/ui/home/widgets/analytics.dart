import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/constants/constants.dart';

class AnalyticsSellerWidget extends StatelessWidget {
  const AnalyticsSellerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              SUMMARY,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TrackWidgetRow(
              name1: TOTAL_SALES,
              name2: ORDERS,
              value1: '${state?.storeUser?.store?.homeAnalytics?.sales ?? 0}',
              value2: '${state?.storeUser?.store?.homeAnalytics?.orders ?? 0}',
            ),
            const SizedBox(
              height: 25,
            ),
            TrackWidgetRow(
              name1: TOTAL_PRODUCTS,
              name2: VIEWS,
              value1:
                  '${state?.storeUser?.store?.homeAnalytics?.products ?? 0}',
              value2: '${state?.storeUser?.store?.homeAnalytics?.views ?? 0}',
            ),
          ],
        );
      },
    );
  }
}

class TrackWidgetRow extends StatelessWidget {
  final String name1, value1;
  final String name2, value2;
  const TrackWidgetRow({
    Key key,
    @required this.name1,
    @required this.name2,
    @required this.value1,
    @required this.value2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: TrackWidget(
              name: name1,
              value: value1,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 1,
            child: TrackWidget(
              name: name2,
              value: value2,
            ),
          ),
        ],
      ),
    );
  }
}

class TrackWidget extends StatelessWidget {
  final String value, name;
  const TrackWidget({
    Key key,
    @required this.name,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
