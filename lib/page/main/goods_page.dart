
import 'package:flutter/material.dart';
import 'package:flutter_app_new/helper/feed_dbhelper.dart';
import 'package:flutter_app_new/model/feed_model.dart';

class GoodsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoodState();
  }
}

class _GoodState extends State<GoodsPage>{

  List<FeedModel> _list = new List();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _list.length,
          itemBuilder: (BuildContext context, int index){
            return _buildItem(_list[index]);
          }
      ),
    );
  }

  Widget _buildItem(FeedModel model){
    return Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            child: Image.network(model.content.cover.thumbnail_url),
          ),
          Container(
            child: Expanded(child: Text(model.content.moment_content)),
          ),
        ],
      ),
    );
  }

  Future<void> _loadData() async {
    List<FeedModel> data = await FeedDbHelper.get().queryAll();
    setState(() {
      _list.clear();
      _list.addAll(data);
    });
  }

}
