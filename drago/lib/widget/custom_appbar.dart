import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildAppbar(BuildContext context ,String title, Function onPress){

  return AppBar(
    backgroundColor: Colors.white,
    leading: GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SvgPicture.asset(
          "assets/close.svg",
          color: Colors.black,
        ),
      ),
    ),
    title: Text(
      "Tax",
      style:
      TextStyle(fontWeight: FontWeight.normal, color: Colors.grey[600]),
    ),
    centerTitle: true,
    actions: <Widget>[
      GestureDetector(
        onTap: () {
          onPress;
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
              alignment: Alignment.center,
              child: Text(
                "Save",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
              )),
        ),
      )
    ],
  );
}