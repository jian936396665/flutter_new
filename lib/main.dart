import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_new/home/home_page_item.dart';

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
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPageIndex = 0;
  var _pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageView(
        onPageChanged: _onPageChange,
        children: <Widget>[
          HomePageItem('首页', 'images/ic_main_navigation_home_selected.png'),
          HomePageItem('商城', 'images/ic_main_navigation_home_selected.png'),
          HomePageItem('消息', 'images/ic_main_navigation_home_selected.png'),
          HomePageItem('我的', 'images/ic_main_navigation_home_selected.png')
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('images/ic_main_navigation_home_selected.png'),
            title: Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/ic_main_navigation_home_selected.png'),
            title: Text('商城'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/ic_main_navigation_home_selected.png'),
            title: Text('消息'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/ic_main_navigation_home_selected.png'),
            title: Text('我的'),
          ),
        ],
        currentIndex: _currentPageIndex,
        onTap: _setCurrent(_currentPageIndex),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  /// 首页切换
  _setCurrent(int current) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(current,
          duration: Duration(microseconds: 300), curve: Curves.ease);
    }
  }

  _onPageChange(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }
}
