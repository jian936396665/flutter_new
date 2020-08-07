import 'package:flutter/cupertino.dart';
import 'package:flutter_app_new/http/http.dart';
import 'package:flutter_app_new/model/feed_model.dart';
import 'package:flutter_app_new/util/PrintUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeModelManager with ChangeNotifier {

  static Future<FeedDataModel> getCustomerList(
      int page) async {
    var result = await Http.fetch(
        "feed",
        params: {
          "page":page?.toString()??'1',
        });
    if (result != null) {
      if (200 == result['code']) {
        FeedDataModel model = FeedDataModel.fromJson(new Map<String, dynamic>.from(result));
        return model;
      } else {
        // 请求结果不等于200的情况
        Fluttertoast.showToast(msg: result['message']);
      }
    }
    return null;
  }
}
