import 'package:drago/global/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthModel {
  Future<bool> registerUser(
      String username, String email, String password) async {
    final response = await http.post('$BaseUrl$RegistrationPath',
        body: {'username': username, 'email': email, 'password': password});

    if (response.statusCode == 200) {
      if (response.body == "\"success\"") {
        print('result form response : ${response.body}');
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setBool('islogged', true);
        await prefs.setString('username', username);
        await prefs.setString('email', email);

        return true;
      }
    }
    return false;
  }

  Future<bool> loginUser(String username, String password) async {
    print('$BaseUrl$LoginPath');
    final response = await http.post(
        'https://dreamriseit.com/drago/Api/Drago/user_login',
        body: {'username': username, 'password': password});

    print(response.body);

    if (response.statusCode == 200) {
      if (response.body == "\"success\"") {
        print('result form response : ${response.body}');
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setBool('islogged', true);
        await prefs.setString('username', username);

        return true;
      }
    }
    return false;
  }
}
