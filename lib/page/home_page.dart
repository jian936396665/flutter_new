import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/items/feed_item.dart';
import 'package:flutter_app_new/model/feed_model.dart';
import 'package:flutter_app_new/model_manager/home_model_manager.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State {
  var _scrollController = new ScrollController(initialScrollOffset: 0);
  List<FeedModel> data = new List();

  @override
  void initState() {
    super.initState();
    _getFeedData();
  }

  void _getFeedData() async {
    FeedDataModel model = await HomeModelManager.getCustomerList(1);
    setState(() {
      data = model.data;
    });
    LogUtil.e(data, tag: "_getFeedData");
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      controller: _scrollController,
      padding: EdgeInsets.all(8),
      crossAxisCount: 4,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        FeedModel item = data[index];
        return FeedItems(item);
      },
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index == 0 ? 1.5 : 2),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }
}
