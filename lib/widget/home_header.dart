import 'package:flutter/material.dart';
import 'package:flutter_app_new/page/main/home_page.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class HomeHeader extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeHeaderState();
  }
}
class _HomeHeaderState extends State<HomeHeader>{

  final _titles = <Color>[Colors.red, Colors.blue, Colors.blue, Colors.amber];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildList()[0],
    );
  }

  List<Widget> _buildList(){
    List<Widget> widgets = new List();
//    for(int i=0;i<_titles.length;i++) {
//      widgets.add(new Material(
//        color:_titles[i],
//        shape: BeveledRectangleBorder(
//            borderRadius: new BorderRadius.circular(8.0),
//        ),
//        child: new Container(
//          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//          height: 80,
//          child: Text(_titles[i].toString()),
//        ),
//      ));
//    }
    widgets.add(new StickyHeader(
      overlapHeaders: true,
      header: Container(
        height: 50,
        child: Text("header"),
      ),
      content: Container(
        child: HomePage(),
      ),
    ));
    return widgets;
  }

}