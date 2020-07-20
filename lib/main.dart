import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_new/home/home_page_item.dart';
import 'package:flutter_app_new/style/app_color.dart';
import 'package:flutter_app_new/style/font_style.dart';

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
  final double _icon_size = 25;
  final _titles = <String>['首页', '商城', '消息', '我的'];
  final _select_icon = <String>[
    'images/ic_main_navigation_home_selected.png',
    'images/ic_main_navigation_goods_selected.png',
    'images/ic_main_navigation_msg_selected.png',
    'images/ic_main_navigation_mine_selected.png'
  ];
  final _unselect_icon = <String>[
    'images/ic_main_navigation_home_unselected.png',
    'images/ic_main_navigation_goods_unselected.png',
    'images/ic_main_navigation_msg_unselected.png',
    'images/ic_main_navigation_mine_unselected.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageView(
        onPageChanged: _onPageChange,
        controller: _pageController,
        children: <Widget>[
          HomePageItem('首页', 'images/ic_main_navigation_home_selected.png'),
          HomePageItem('商城', 'images/ic_main_navigation_goods_selected.png'),
          HomePageItem('消息', 'images/ic_main_navigation_msg_selected.png'),
          HomePageItem('我的', 'images/ic_main_navigation_mine_selected.png')
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: AppColor.rcNormalColor,
        selectedItemColor: AppColor.rcMainColor,
        selectedFontSize: AppText.normalSize,
        unselectedFontSize: AppText.normalSize,
        type: BottomNavigationBarType.fixed,
        items: _build_bottom_items(),
        currentIndex: _currentPageIndex,
        onTap: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
          _setCurrent(index);
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<BottomNavigationBarItem> _build_bottom_items() {
    var itemList = List<BottomNavigationBarItem>();
    for (int i = 0; i < _titles.length; i++) {
      var icon = i == _currentPageIndex ? _select_icon[i] : _unselect_icon[i];
      var item = BottomNavigationBarItem(
          icon: Image.asset(
            icon,
            width: _icon_size,
            height: _icon_size,
          ),
          title: Text(_titles[i]));
      itemList.add(item);
    }
    return itemList;
  }

  /// 首页切换
  _setCurrent(int current) {
    if (_currentPageIndex != current) {
      _currentPageIndex = current;
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
