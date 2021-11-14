import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prachar/presentation/core/pages/styles.dart';

class SearchWidget extends StatelessWidget {
  final String hint;
  final String text;
  final Function onPressed;
  const SearchWidget({
    Key key,
    @required this.hint,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            onPressed();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              hint,
            ),
          ),
        ),
      ],
    );
  }
}
