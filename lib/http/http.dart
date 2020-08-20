import 'dart:convert';
import 'dart:io';
import 'package:flutter_app_new/api/api_config.dart';
import 'package:flutter_app_new/api/constant.dart';
import 'package:flutter_app_new/util/PrintUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class Http {
  ///  请求数据返回成功码
  static const int SUCCESS_CODE = 200;

/// 公共参数
  static Map publicParams = {
    'platform': Constant.platform,
    'app_version': Constant.app_version,
    'client': Constant.client,
//    'registration_id': JpushUtil.shared.jpushId,
//    'unique_id':DeviceUtil.shared.uniqueId,
  };

  static Future fetch(String url, {Map params, String type = "get"}) async {
    var response;
    url = _addParams(url,params: publicParams);
    PrintUtil.e(' http publicParams:::' + publicParams.toString());
    if ('get' == type) {
      response = await _get(url, params: params);
    } else if ('post' == type) {
      response = await _post(url, params: params);
    } else {
      return throw Exception("type is errow");
    }

    PrintUtil.e(response.statusCode);

    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      PrintUtil.e(' http result:::' + result.toString());
      return result;
//      if (200 == result['code']) {
//        print({'result::': result['data'].toString()});
//        return result['data'];
//      } else {
//        print({'result::': response.toString()});
//
////        throw Exception('Failed to load $url ' + result['code'].toString());
//      }
    } else {
      Fluttertoast.showToast(msg: "网络错误,请检查网络");
//      throw Exception('Failed to load ' + url);
    }
  }

  static Future _get(String url, {Map params}) async {
    if (!url.startsWith("http")) {
      url = Api.API_DOMAIN + url;
    }
    PrintUtil.selfError("params:::params::" + params.toString());

    url = _addParams(url, params: params);
    PrintUtil.selfError("params:::params::" + url.toString());

    var startTime = DateTime.now().millisecondsSinceEpoch;
//    UserData userData = await UserManager.shared.getUserInfo();
//    String token = userData?.token??"";
    String token = Constant.token;
//    await UserManager.shared.getToken;
    PrintUtil.selfError("token::" + token);
    final response = await http.get(url, headers: {
//      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': token,
    });

    var endTime = DateTime.now().millisecondsSinceEpoch;
    PrintUtil.e(
        {'difTime': endTime - startTime, 'url': url, 'parmas': params ?? null});

    return response;
  }

  static Future _post(String url, {Map params}) async {
    if (!url.startsWith("http")) {
      url = Api.API_DOMAIN + url;
    }
//    url = _addParams(url, params);
    var startTime = DateTime.now().millisecondsSinceEpoch;
//    UserData userData = await UserManager.shared.getUserInfo();
    String token = Constant.token;
    final response = await http.post(url,
        headers: {
//          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + token,
        },
        body: params);
    var endTime = DateTime.now().millisecondsSinceEpoch;

    PrintUtil.e(
        {'difTime': endTime - startTime, 'url': url, 'parmas': params ?? null});

    return response;
  }

  static String _addParams(String url, {Map params}) {
    var returnUrl = url;
    if (null == params) {
      return returnUrl;
    } else {
      List urlArray = url.split('?');

      String mainUri = urlArray[0];
      if (urlArray.length > 1) {
        String mainUriParmasStr = urlArray[1];
        List mainUriParmasList = mainUriParmasStr.split('&');

        if (mainUriParmasList.length > 0) {
          for (int i = 0; i < mainUriParmasList.length; i++) {
            List arr = mainUriParmasList[i].split('=');
            params[arr[0]] = arr[1];
          }
        }
      }

      List<String> newSearch = [];
      PrintUtil.selfError("params:::params::" + params.toString());
      params.forEach(
          (key, value) => {newSearch.add(key + '=' + value.toString() ?? "")});
      returnUrl = mainUri + '?' + newSearch.join('&');
      return returnUrl;
    }
  }
}
