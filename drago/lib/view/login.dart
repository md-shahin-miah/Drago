import 'package:drago/controller/auth.dart';
import 'package:drago/helper/utility_helper.dart';
import 'package:drago/main.dart';
import 'package:drago/view/register.dart';
import 'package:drago/view/vehicle_list.dart';
import 'package:flutter/material.dart';
import 'package:drago/global/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String username;
  String password;
  bool isLoading = false;
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
                                    onChanged: (val) {
                                      username = val;
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
                                    obscureText: true,
                                    onChanged: (val) {
                                      password = val;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Password'),
                                  ),
                                ),
                              ),
                              isLoading
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
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
                                          isLoading = true;
                                        });
                                        String result = await AuthController()
                                            .loginUser(username, password);

                                        if (result == "success") {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => Drago()));
                                        } else {
                                          MyUtil.showInSnackBar(
                                              _scaffoldKey, result);
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      },
                                      color: ColorPrimary,
                                      textColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("ACCEDI".toUpperCase(),
                                            style: TextStyle(fontSize: 14)),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        await prefs.setString('username', "test001");
                        await prefs.setString('email', "test001@gmail.com");
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => Drago()));
                      },
                      child: Text(
                        'Salta adesso',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Text(
                      'Ha dimenticato la password?',
                      style: TextStyle(color: ColorPrimary, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Nuovo qui?',
                          style: TextStyle(color: ColorPrimary, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RegisterPage()));
                          },
                          child: Text(
                            ' Nuovo utente? ',
                            style: TextStyle(
                                color: ColorPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
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
