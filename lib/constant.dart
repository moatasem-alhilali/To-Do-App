import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool female=false;
TextEditingController nameController=TextEditingController();
bool selected=false;
Future<bool?> showToast({String? message, ToastShowColor? states}) {
  return Fluttertoast.showToast(
      msg: message!,

      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choseTheColor(states!),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastShowColor {
  ERROR,
  SUCCESS,
  WARNING,
}

Color choseTheColor(ToastShowColor states) {
  Color? color;
  switch (states) {
    case ToastShowColor.ERROR:
      color = Colors.red;
      break;
    case ToastShowColor.SUCCESS:
      color = Colors.blue;
      break;
    case ToastShowColor.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}