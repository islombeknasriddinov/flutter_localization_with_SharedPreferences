import 'dart:convert';

import 'package:flutter_localization/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/account_model.dart';

class Prefs{
  //Save String
  static void storeName(String name) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("name", name);
  }

  static Future<String> loadName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("name")!;
  }

  static Future<bool> removeName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove("name");
  }

  //Save Object
  static void storeUser(dynamic user, String key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String stringUser = jsonEncode(user);
    preferences.setString(key, stringUser);
  }

  static Future<User?> loadUser(String key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String stringUser = preferences.getString(key)!;
    if(stringUser == null || stringUser.isEmpty){
      return null;
    }

    Map<String, dynamic> map = jsonDecode(stringUser);
    return User.fromJson(map);
  }

  static Future<Account?> loadAccount(String key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String stringUser = preferences.getString(key)!;
    if(stringUser == null || stringUser.isEmpty){
      return null;
    }

    Map<String, dynamic> map = jsonDecode(stringUser);
    return Account.fromJson(map);
  }

  static Future<bool> removeUser(String key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }
}