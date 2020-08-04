import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
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
  List<FeedModel> data = new List();
  var modelManager = new HomeModelManager();

  @override
  void initState() {
    super.initState();
    modelManager.feed();
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
    return ChangeNotifierProvider.value(
      value: modelManager,
      child: new StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemCount: data.length,
        itemBuilder: (context, i) {
          return new Material(
            elevation: 5,
            borderRadius: new BorderRadius.all(
              new Radius.circular(8.0),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) {
                      return new HomePage();
                    },
                  ),
                );
              },
              child: Image.network(data[i].content.cover.thumbnail_url),
            ),
          );
        }, staggeredTileBuilder: (index) => new StaggeredTile.count(2, index == 0 ? 1.5 : 2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}
