import 'dart:io';

import 'package:another_flushbar/flushbar_helper.dart';

Future<bool> isOnline() async {
  final result = await InternetAddress.lookup('example.com');
  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    return true;
  }
  return false;
}
