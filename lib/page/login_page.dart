import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/model/code_login_model.dart';
import 'package:flutter_app_new/model_manager/login_model_manager.dart';
import 'package:flutter_app_new/widget/timer_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_page.dart';

class CodeLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CodeLoginState();
  }
}

///登录
class _CodeLoginState extends State {
  TextEditingController userEditController = new TextEditingController();
  TextEditingController userCodeController = new TextEditingController();
  bool isCanSendCode = true;

  final timerKey = new GlobalKey();

  @override
  Future<void> initState() {
    userEditController.addListener(() {
      setState(() {
        isCanSendCode = userEditController.text.isNotEmpty;
        timerKey.currentState.initState();
      });
    });
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
            child: TextField(
              keyboardType: TextInputType.text,
              maxLength: 11,
              controller: userCodeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '请输入验证码',
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
              child: TimerText(
                key: timerKey,
                onTapCallback: _sendCode,
                isEnable: isCanSendCode,
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
    if (!exp.hasMatch(userEditController.text)) {
      Fluttertoast.showToast(msg: "请输入正确的手机号！");
      return;
    }
    LoginModelManager.getLoginCode(userEditController.text);
  }

  ///登录
  _login() async {
    if (userEditController.text.isEmpty) {
      Fluttertoast.showToast(msg: "请输入用户名");
      return;
    }
    if (userCodeController.text.isEmpty) {
      Fluttertoast.showToast(msg: "请输入验证码");
      return;
    }
    CodeLoginModel loginModel = await LoginModelManager.login(
        userEditController.text, userCodeController.text);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String spLogin = JsonUtil.encodeObj(loginModel);
    prefs.setString("login", spLogin);
    Navigator.pop(context);
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => MainPage(
              title: "首页",
            )));
  }
}