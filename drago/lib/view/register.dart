import 'package:drago/controller/auth.dart';
import 'package:drago/helper/utility_helper.dart';
import 'package:drago/view/homepage_main.dart';
import 'package:drago/view/vehicle_list.dart';
import 'package:flutter/material.dart';
import 'package:drago/global/constant.dart';

import '../main.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String username, email, password, confirmPassword;
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.cover,
                        alignment: Alignment.centerRight)),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(width: 5, height: 400, color: ColorPrimary),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                          child: Image.asset(
                        'assets/images/logo_white.png',
                        height: 50,
                      )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Card(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12.0, 4, 12, 4),
                                  child: TextField(
                                    onChanged: (value) {
                                      username = value;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Nome utente'),
                                  ),
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12.0, 4, 12, 4),
                                  child: TextField(
                                    onChanged: (value) {
                                      email = value;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'E-mail'),
                                  ),
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12.0, 4, 12, 4),
                                  child: TextField(
                                    onChanged: (value) {
                                      password = value;
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Password'),
                                  ),
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12.0, 4, 12, 4),
                                  child: TextField(
                                    obscureText: true,
                                    onChanged: (value) {
                                      confirmPassword = value;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Conferma password'),
                                  ),
                                ),
                              ),
                              showProgress
                                  ? Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: CircularProgressIndicator(),
                                    )
                                  : RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side:
                                              BorderSide(color: ColorPrimary)),
                                      onPressed: () async {
                                        setState(() {
                                          showProgress = true;
                                        });

                                        String result = await AuthController()
                                            .registerUser(username, email,
                                                password, confirmPassword);
                                        print('result is $result');
                                        if (result == 'success') {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => Drago()));
                                        } else {
                                          setState(() {
                                            showProgress = false;
                                          });
                                          MyUtil.showInSnackBar(
                                              _scaffoldKey, result);
                                        }
                                      },
                                      color: ColorPrimary,
                                      textColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Iscriviti".toUpperCase(),
                                            style: TextStyle(fontSize: 14)),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hai già un account?',
                          style: TextStyle(color: ColorPrimary, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => LoginPage()));
                          },
                          child: Text(
                            ' Accedi ',
                            style: TextStyle(
                                color: ColorPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          'adesso',
                          style: TextStyle(color: ColorPrimary, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
