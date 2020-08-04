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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Color(0xff999999), blurRadius: 2, offset: Offset(0.5, 0.5))
      ], borderRadius: BorderRadius.circular(4),color: Colors.white),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Container(
              child: Image.network(
                widget.item.content.cover.thumbnail_url,
                fit: BoxFit.cover,
              ),
              constraints: BoxConstraints.expand(),
            ),
            Container(
              constraints:
              BoxConstraints.expand(width: double.infinity, height: 30),
              color: Colors.black26,
              child: Center(
                child: Text(
                  widget.item.content.moment_content==null?"":widget.item.content.moment_content,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}