import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  final String USER = "user";
  SharedPreferences sharedPreferences;
  bool isLoggedIn = false;
  Future<dynamic> storeSession(String access_token) async {
    print("<------------------------");
    isLoggedIn = true;
    sharedPreferences = await SharedPreferences.getInstance();
    print("STORING ACCESS TOKEN :------------");
    var result = await sharedPreferences.setString(USER, access_token);
    print(result);
    //return result;
  }

  Future<dynamic> getSessionDetails() async {
    print("GET ACCESS TOKEN :------------");
    sharedPreferences = await SharedPreferences.getInstance();
    var result = await sharedPreferences.getString(USER);
    print("ACCESS TOKEN: $result");
    return result;
    print("<------------------------");
  }

  void clearData() async {
    print("Logout");
    isLoggedIn = false;
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
