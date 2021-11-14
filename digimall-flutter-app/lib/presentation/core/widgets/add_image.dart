import 'package:flutter/material.dart';

class AddImage extends StatelessWidget {
  final Function onPressed;
  const AddImage({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        // width: MediaQuery.of(context).size.width,
        height: 100,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add,
              size: 24,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Add Image",
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
