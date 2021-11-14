import 'package:flutter/material.dart';
import 'package:prachar/presentation/core/pages/styles.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController tec;
  final String hint;
  final String error;
  final bool isOnlyInt;
  final bool isOptional;
  const CommonTextFormField(
      {Key key,
      @required this.tec,
      @required this.hint,
      @required this.error,
      this.isOptional = false,
      this.isOnlyInt = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: tec,
        keyboardType: isOnlyInt ? TextInputType.number : null,
        validator: (val) {
          return isOptional
              ? null
              : val.isNotEmpty
                  ? null
                  : error;
        },
        decoration: Styles.inputDecoration(hint),
      ),
    );
  }
}
