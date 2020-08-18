import 'package:flutter/material.dart';
import 'package:flutter_app_new/page/main/profile_page.dart';
import 'package:flutter_app_new/style/app_color.dart';
import 'package:flutter_app_new/style/font_style.dart';

import 'main/goods_page.dart';
import 'main/home_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  int _currentPageIndex = 0;
  var _pageController = new PageController(initialPage: 0);
  final double _icon_size = 22;
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
          new HomePage(),
          new GoodsPage(),
          new Text("消息"),
          new ProfilePage()
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

  ///导航
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
    _pageController.animateToPage(current,
        duration: Duration(microseconds: 300), curve: Curves.ease);
  }

  _onPageChange(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }
}