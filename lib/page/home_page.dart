import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/items/feed_item.dart';
import 'package:flutter_app_new/model/feed_model.dart';
import 'package:flutter_app_new/model_manager/home_model_manager.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State with AutomaticKeepAliveClientMixin{
  var _scrollController = new ScrollController(initialScrollOffset: 0);
  List<FeedModel> data = new List();
  int page = 1;

  @override
  void initState() {
    super.initState();
    _getFeedData(page);
    _scrollController.addListener(() {
      var px = _scrollController.position.pixels;
      if (px == _scrollController.position.maxScrollExtent) {
        _onLoadMore();
      }
    });
  }

  void _getFeedData(int page) async {
    FeedDataModel model = await HomeModelManager.getCustomerList(page);
    setState(() {
      data.addAll(model.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: StaggeredGridView.countBuilder(
        controller: _scrollController,
        padding: EdgeInsets.all(8),
        crossAxisCount: 4,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          FeedModel item = data[index];
          return FeedItems(item);
        },
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.fit(2),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      onRefresh: _onRefresh,
    );
  }

  void _onLoadMore() {
    page++;
    _getFeedData(page);
  }

  Future<void> _onRefresh(){
    page = 1;
    _getFeedData(page);
  }

  @override
  bool get wantKeepAlive => true;

}
