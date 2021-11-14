import 'package:flutter/material.dart';
import 'package:prachar/presentation/core/widgets/loading.dart';

///full width button
class ButtonFW extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isLoading;
  final Color color;
  const ButtonFW({
    Key key,
    @required this.isLoading,
    this.onPressed,
    this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          if (!isLoading) {
            onPressed();
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 50,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color ?? Colors.green[600],
            borderRadius: BorderRadius.circular(8),
          ),
          child: isLoading
              ? const CircularProgressLoading()
              : Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
        ),
      ),
    );
  }
}
