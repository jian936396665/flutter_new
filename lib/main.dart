import 'dart:io';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_new/navigatormanager.dart';
import 'package:flutter_app_new/page/main_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

class CodeLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CodeLoginState();
  }
}

class _CodeLoginState extends State {
  TextEditingController userEditController = new TextEditingController();

  @override
  void initState() {
//    userEditController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Align(
        alignment: Alignment.center,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 66,
              left: 16,
              bottom: 32,
            ),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              maxLength: 11,
              controller: userEditController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '请输入手机号',
                prefixIcon: Icon(Icons.verified_user),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                disabledColor: Colors.grey,
                color: Colors.blue,
                onPressed: () {
                  _sendCode();
                },
                child: Text(
                  '请输入验证码',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 268,
                  child: RaisedButton(
                    onPressed: () {
                      _login();
                    },
                    child: Text(
                      '登录',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///发送验证码
  _sendCode() {
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if(!exp.hasMatch(userEditController.text)){
      Fluttertoast.showToast(msg: "请输入正确的手机号！");
      return;
    }
    LoginModelManager.getLoginCode(userEditController.text);
  }

  ///登录
  _login() {
    Navigator.pop(context);
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MainPage(title: "首页",)));
  }
}
