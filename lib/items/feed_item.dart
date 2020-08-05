import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/model/feed_model.dart';

class FeedItems extends StatefulWidget{

  FeedItems(this.item);

  final FeedModel item;

  @override
  State<StatefulWidget> createState() {
    return _FeedItemState();
  }

}

class _FeedItemState extends State<FeedItems>{

  _FeedItemState();

  double maxHeight = 0;

  @override
  Widget build(BuildContext context) {
    return _buildContentWidget();
  }

  Widget _buildContentWidget(){
    Uri uri = Uri.parse(widget.item.content.cover.thumbnail_url);
    int width = int.parse(uri.queryParameters["width"]);
    int height = int.parse(uri.queryParameters["height"]);
    return AspectRatio(
      aspectRatio: width/height,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Color(0xff999999), blurRadius: 2, offset: Offset(0.5, 0.5))
        ], borderRadius: BorderRadius.circular(4),color: Colors.white),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              Container(
                color: Colors.red,
                child: Image.network(
                  widget.item.content.cover.thumbnail_url,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                constraints:
                BoxConstraints.expand(width: double.infinity, height: 30),
                color: Colors.black26,
                child: Center(
                  child:Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      widget.item.content.moment_content==null?"":widget.item.content.moment_content,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}