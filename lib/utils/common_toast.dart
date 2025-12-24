import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension FlutterToast on String {
  void showToast({bool? isKeyboardOpen}) {
    Fluttertoast.showToast(
      msg: this,
      toastLength: Toast.LENGTH_LONG,
      gravity: isKeyboardOpen == true && Platform.isIOS
          ? ToastGravity.CENTER
          : ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.black.withOpacity(0.85),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
