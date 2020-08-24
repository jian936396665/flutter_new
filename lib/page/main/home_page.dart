import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_new/helper/feed_dbhelper.dart';
import 'package:flutter_app_new/items/feed_item.dart';
import 'package:flutter_app_new/model/feed_model.dart';
import 'package:flutter_app_new/model_manager/home_model_manager.dart';
import 'package:flutter_app_new/widget/net_loading_dialog.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State with AutomaticKeepAliveClientMixin {
  var _scrollController = new ScrollController(initialScrollOffset: 0);
  List<FeedModel> data = new List();
  int page = 1;
  bool dissmissDialog = false;

  GlobalKey<LoadingDialog> key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      var px = _scrollController.position.pixels;
      if (px == _scrollController.position.maxScrollExtent) {
        _onLoadMore();
      }
    });
    Timer.periodic(Duration(microseconds: 200), (timer) {
      _getFeedData(page);
      timer.cancel();
    });
  }

  void _getFeedData(int page) async {
    _showDialog();
    FeedDataModel model = await HomeModelManager.getCustomerList(page);
    setState(() {
      data.addAll(model.data);
    });
    FeedDbHelper.get().insert(data);
    setState(() {
      key.currentState.dismissDialog();
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
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
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

  Future<void> _onRefresh() {
    page = 1;
    _getFeedData(page);
  }

  @override
  bool get wantKeepAlive => true;

  void _showDialog() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return NetLoadingDialog(key: key, dismissDialog: _dissmissDialog);
        });
  }

  _dissmissDialog(Function func) {
    if (dissmissDialog) {
      Navigator.of(context).pop();
    }
  }
}
