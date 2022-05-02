import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

 showToast({
  required String msg,
  required ToastState state,
  bool? shortTime
}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: shortTime == null ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { success, error, warning }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.success:
      color =  Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color = Colors.amber;
  }
  return color;
}

