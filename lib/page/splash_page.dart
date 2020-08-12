import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';
import 'main_page.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashState();
  }
}

class _SplashState extends State with SingleTickerProviderStateMixin{
  static const app_name = "Flutter New";

  String text = "";
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller);

    Timer.periodic(Duration(seconds: 1), (timer) {
      _controller.forward();
      timer.cancel();
    });

    Timer.periodic(Duration(seconds: 3), (timer) {
      onAnimalEnd();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Align(
        child: FadeTransition(
          opacity: _animation,
          child: Text(app_name),
        ),
      ),
    );
  }

  ///动画结束
  void onAnimalEnd() {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    prefs.then((value) => {
          Navigator.pop(context),
          if (value.getString("login")!=null)
            {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => MainPage(
                            title: "首页",
                          )))
            }
          else
            {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => CodeLoginPage()))
            }
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
