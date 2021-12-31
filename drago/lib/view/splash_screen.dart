import 'dart:async';

import 'package:drago/controller/auth.dart';
import 'package:drago/view/login.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      AuthController().isLoggedUser().then((value) {
        if (value) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => Drago()));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => LoginPage()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(64.0),
        child: Center(
          child: Image.asset('assets/images/splash.png'),
        ),
      ),
    );
  }
}
