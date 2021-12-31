import 'package:drago/controller/auth.dart';
import 'package:drago/global/constant.dart';
import 'package:drago/view/login.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drago'),
      ),
      body: Center(
        child: RaisedButton(
            color: ColorPrimary,
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              await AuthController().logout();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => LoginPage()));
            }),
      ),
    );
  }
}
