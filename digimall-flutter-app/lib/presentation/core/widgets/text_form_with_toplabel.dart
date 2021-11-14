import 'package:flutter/material.dart';
import 'package:prachar/presentation/core/pages/styles.dart';
import 'package:prachar/presentation/core/widgets/text_form_field.dart';

class TextFormFieldWithTopText extends StatelessWidget {
  final TextEditingController tec;
  final String hint;
  final String error;
  final String text;
  final bool isOnlyInt;
  final bool isOptional;
  const TextFormFieldWithTopText({
    Key key,
    @required this.tec,
    @required this.hint,
    @required this.error,
    @required this.text,
    this.isOnlyInt = false,
    this.isOptional = false,
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
        CommonTextFormField(
          tec: tec,
          hint: hint,
          error: error,
          isOnlyInt: isOnlyInt,
          isOptional: isOptional,
        )
      ],
    );
  }
}
