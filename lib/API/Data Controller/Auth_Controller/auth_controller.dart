import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../API_Model/user_model.dart';

class AuthController {
  static String? accessToken;
  static UserModel? userModel;
  static String? accessKey;

  static const String _accessTokenKey = 'access-token';
  static const String _userDataKey = 'user-data';

  static const String _accessKey = '';

  //Data save ro set Method
  static Future<void> setUserData(String token, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    accessToken = token;
    userModel = model;
  }

  //Data save without token
  static Future<void> setUserAccountData(String key, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessKey, key);
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    accessKey = key;
    userModel = model;
  }

  //Data Get Method
  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    String? userData = sharedPreferences.getString(_userDataKey);
    accessToken = token;
    userModel = UserModel.fromJson(jsonDecode(userData!));
  }

  //Data Get Method without token
  static Future<void> getUserAccountData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? key = sharedPreferences.getString(_accessKey);
    String? userData = sharedPreferences.getString(_userDataKey);
    accessKey = key;
    userModel = UserModel.fromJson(jsonDecode(userData!));
  }

  // Data check
  static Future<bool> isUserLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    if (token != null) {
      await getUserData();
      return true;
    }
      return false;
  }

  //After logOut Data Clear
  static Future<void> dataClear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
