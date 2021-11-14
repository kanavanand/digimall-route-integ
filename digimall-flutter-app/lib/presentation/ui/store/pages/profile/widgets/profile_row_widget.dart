import 'package:flutter/material.dart';
import 'package:prachar/presentation/core/styles/colors.dart';

class ProfileRowWidget extends StatelessWidget {
  final IconData iconData;
  final String name;
  final Function onPressed;
  const ProfileRowWidget({
    Key key,
    @required this.iconData,
    @required this.name,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Icon(
                iconData,
                size: 25,
                color: Kolors.primaryColor,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                name,
                style: const TextStyle(
                  color: Kolors.PrimaryColorDark,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
