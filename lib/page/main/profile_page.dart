import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}
class _ProfileState extends State<ProfilePage>{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  color: Colors.redAccent,
                  width: 80,
                  height: 80,
                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Image.network("https://www.baidu.com"),
                ),
                Container(
                  height: 80,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("用户名"),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text("昵称"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}