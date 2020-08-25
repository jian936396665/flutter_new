import 'package:flutter/material.dart';
import 'package:flutter_app_new/widget/net_loading_dialog.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

///上拉加载基类
class BasePullToRefreshWidget extends StatefulWidget {
  final RefreshType refreshType;
  final StaggeredGridView staggeredGridView;
  final RefreshCallback onRefresh;

  const BasePullToRefreshWidget(
      {Key key,
      this.refreshType = RefreshType.ListView,
      this.staggeredGridView, this.onRefresh})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BaseRefreshState();
  }
}

class _BaseRefreshState extends State<BasePullToRefreshWidget> {

  GlobalKey<LoadingDialog> key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(BasePullToRefreshWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: _item(widget.refreshType),
      onRefresh: widget.onRefresh,
    );
  }

  Widget _item(RefreshType refreshType) {
    switch (refreshType) {
      case RefreshType.ListView:
        return _buildListViewItem();
      case RefreshType.GridView:
        return _buildGridViewItem();
      case RefreshType.StaggeredGridView:
        return _buildStaggeredGridViewItem();
    }
  }

  Widget _buildListViewItem() {}

  Widget _buildGridViewItem() {}

  Widget _buildStaggeredGridViewItem() {
    return widget.staggeredGridView;
  }

}

enum RefreshType { ListView, GridView, StaggeredGridView }
