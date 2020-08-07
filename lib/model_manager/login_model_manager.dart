import 'package:flutter_app_new/http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginModelManager{

  ///发送登录验证码
  static Future<String> getLoginCode(
      String userPhone) async {
    var result = await Http.fetch(
        "sms/login",
        params: {
          "user_phone":userPhone,
        });
    if (result != null) {
      if (200 == result['code']) {
        return result;
      } else {
        Fluttertoast.showToast(msg: result['message']);
      }
    }
    return null;
  }



}