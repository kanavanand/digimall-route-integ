import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:prachar/presentation/core/widgets/button.dart';
import 'package:prachar/presentation/core/widgets/text_form_with_toplabel.dart';
import 'package:prachar/constants/constants.dart';

class RejectBottomSheat extends StatelessWidget {
  final Function onReject;
  RejectBottomSheat({
    Key key,
    @required this.onReject,
  }) : super(key: key);

  final rejectTEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: [
          const BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormFieldWithTopText(
              tec: rejectTEC,
              hint: ADD_REASON_TO_REJECT,
              error: ADD_REASON_TO_REJECT,
              text: REASON,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ButtonFW(
                    isLoading: false,
                    text: CANCEL,
                    color: Colors.red,
                    onPressed: () {
                      ExtendedNavigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: ButtonFW(
                    isLoading: false,
                    text: "Reject",
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        onReject(rejectTEC.text);
                        ExtendedNavigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
