import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/model/user_info.dart';
import 'package:flutter_app_new/model_manager/login_model_manager.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}
class _ProfileState extends State<ProfilePage>{

  UserInfo userInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    UserInfo _userinfo = await LoginModelManager.getUserInfo();
    setState(() {
      userInfo = _userinfo;
    });
  }

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
                  width: 80,
                  height: 80,
                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Image.network(userInfo.user_info.user_photo),
                ),
                Container(
                  height: 80,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(userInfo.user_info.user_name),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(TextUtil.isEmpty(userInfo.user_info.signature)?"该用户很懒，没有设置签名":userInfo.user_info.signature),
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