import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_new/navigatormanager.dart';
import 'package:flutter_app_new/page/login_page.dart';
import 'package:flutter_app_new/page/main_page.dart';
import 'package:flutter_app_new/widget/timer_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/code_login_model.dart';
import 'model_manager/login_model_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      // 在组件渲染之后，再覆写状态栏颜色
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      LogUtil.init(isDebug: true);
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CodeLoginPage(),
      routes: <String, WidgetBuilder>{
//        '/page': (context) => MainPage(title: '首页'),
      },
      navigatorKey: RouteManager.navigatorKey,
      navigatorObservers: [NavigatorManager.getInstance()],
    );
  }
}


