import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:prachar/domain/auth/store.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/routes/router.gr.dart';

class SearchStoreTile extends StatelessWidget {
  final Store store;
  final double distance;
  const SearchStoreTile({
    Key key,
    @required this.store,
    this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ExtendedNavigator.of(context).push(
          Routes.storeDetailsPage,
          arguments: StoreDetailsPageArguments(
            store: store,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(
          12,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.network(
                      store.image,
                      width: 55,
                      height: 55,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          store.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Kolors.primaryBackgroundColor,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                store.category,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Kolors.primaryColor,
                                  fontSize: 9,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (distance != null)
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE5F5E7),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 9,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      '${distance.toInt()} Km',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Color(0xFF0D5A11),
                                        fontSize: 9,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              store.address,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
// Row(
//   children: [
//     Icon(
//       Icons.star,
//       color: Colors.yellow[700],
//     ),
//     const SizedBox(
//       width: 10,
//     ),
//     Text(
//       store?.rating ?? '',
//       style: const TextStyle(
//         color: Colors.black54,
//         fontSize: 14,
//       ),
//     ),
//   ],
// ),
