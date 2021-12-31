import 'package:flutter/material.dart';

class MyUtil {
  static void showInSnackBar(
      GlobalKey<ScaffoldState> _scaffoldKey, String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }
}
