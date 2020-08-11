import 'package:flutter_app_new/http/http.dart';
import 'package:flutter_app_new/model/code_login_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginModelManager{

  ///发送登录验证码
  static Future<String> getLoginCode(
      String userPhone) async {
    var result = await Http.fetch(
        "sms/login",
        params: {
          "user_phone":userPhone,
        }, type: "post");
    if (result != null) {
      if (200 == result['code']) {
        return result;
      } else {
        Fluttertoast.showToast(msg: result['message']);
      }
    }
    return null;
  }

  ///验证码登录
  static Future<CodeLoginModel> login(
      String userPhone, String code) async {
    var result = await Http.fetch(
        "auth/code-login",
        params: {
          "auth_identify":userPhone,
          "code":code,
        },type: "post");
    if (result != null) {
      if (200 == result['code']) {
        CodeLoginModel model = new CodeLoginModel.fromJson(new Map<String, dynamic>.from(result));
        return model;
      } else {
        Fluttertoast.showToast(msg: result['message']);
      }
    }
    return null;
  }

}