import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Constant{
  static String platform = Platform.isAndroid?'android':'ios';
  static const String app_version = "1.0.2";
  static const String client = "rcat_app";
  static String token;

  static void loadToken(){
    SharedPreferences.getInstance().then((value){
      if(value.getString("login")!=null && token==null) {
        Map<String, dynamic> jsonValue = jsonDecode(value.getString("login"));
        token = "Bearer ${jsonValue["token"]}";
      }
    });

  }
}