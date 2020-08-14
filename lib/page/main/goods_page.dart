import 'package:common_utils/common_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_new/helper/feed_dbhelper.dart';
import 'package:flutter_app_new/model/feed_model.dart';

class GoodsPage extends StatefulWidget{

  GoodsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GoodState();
  }

}
class _GoodState extends State{

  String text;

  @override
  Future<void> initState() async {
    super.initState();
    List<FeedModel> list = await FeedDbHelper.get().queryAll();
    LogUtil.e(list.toString(), tag: "::::goods");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        child: Text("商城"),
      ),
    );
  }

}