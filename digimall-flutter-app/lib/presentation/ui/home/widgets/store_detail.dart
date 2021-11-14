import 'package:flutter/material.dart';

class StoreDetailsWidget extends StatelessWidget {
  final String name;
  final String image;
  const StoreDetailsWidget({
    Key key,
    @required this.name,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        vertical: 14,
      ),
      child: Row(
        children: [
          if (image.isNotEmpty)
            Image.network(
              image,
              height: 100,
              width: 100,
            ),
          const SizedBox(
            width: 12,
          ),
          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          )
        ],
      ),
    );
  }
}
