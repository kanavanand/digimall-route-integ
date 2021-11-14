import 'package:flutter/material.dart';

mixin Styles {
  static InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.black54,
        fontSize: 14,
      ),
      fillColor: Colors.grey,
      // focusedBorder: UnderlineInputBorder(
      //   borderSide: BorderSide(color: Colors.black, width: 1.5),
      // ),
      border: InputBorder.none,
    );
  }
}
