import 'package:flutter/cupertino.dart';

class HomePageItem extends StatelessWidget{

  String title;
  String icon;

  HomePageItem(String title, String icon){
    this.title = title;
    this.icon = icon;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(icon),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFFfafafa),
          ),
        )
      ],
    );
  }

}