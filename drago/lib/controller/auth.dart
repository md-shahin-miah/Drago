import 'package:drago/helper/validation_helper.dart';
import 'package:drago/model/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  Future<String> registerUser(String username, String email, String pass,
      String confirmPassword) async {
    if (!Validator.isValidEmail(email)) {
      return "Invalid email";
    } else if (pass.length < 6) {
      return "Password must be at least 6 character";
    } else if (confirmPassword != pass) {
      return "Password doen't match";
    } else {
      bool isSuccess = await AuthModel().registerUser(username, email, pass);
      return isSuccess ? "success" : "failed";
    }
  }

  Future<String> loginUser(String username, String pass) async {
    if (pass.length < 6) {
      return "Password must be at least 6 character";
    } else {
      bool isSuccess = await AuthModel().loginUser(username, pass);
      return isSuccess ? "success" : "failed";
    }
  }

  Future<bool> isLoggedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogged = (prefs.getBool('islogged') ?? false);
    return isLogged;
  }

  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userename = (prefs.getString('username') ?? null);
    return userename;
  }

  Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email') ?? null);
    return email;
  }

  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('islogged', false);

    return true;
  }
}
