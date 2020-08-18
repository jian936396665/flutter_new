import 'package:flutter_app_new/inter/idbhelper.dart';
import 'package:flutter_app_new/model/feed_model.dart';
import 'package:flutter_app_new/util/database_helper.dart';

class FeedDbHelper{

  FeedDbHelper _instance;
  DatabaseHelper _databaseHelper;

  static const feed_dbname = "feed.db";
  static const feed_table = "feed_table";

  FeedDbHelper.get(){
    if(_instance==null){
      _instance = new FeedDbHelper();
    }
    if(_databaseHelper==null){
      _databaseHelper = new DatabaseHelper();
      String sql = "CREATE TABLE $feed_table (id INTEGER PRIMARY KEY, content TEXT, image_url TEXT)";
      _databaseHelper.create(feed_dbname, sql);
    }
  }

  FeedDbHelper();

  void insert(List<FeedModel> arg) {
    for(int i=0;i<arg.length;i++) {
      String sql = "INSERT INTO $feed_table (content,image_url) VALUES('${arg[i].content.moment_content}','${arg[i].content.cover.thumbnail_url}')";
      _databaseHelper.insert(feed_dbname, sql);
    }
  }

  void update(String sql, List<FeedModel> arg) {
    _databaseHelper.update(feed_dbname, sql, arg);
  }

  Future<List<FeedModel>> queryAll() async {
    String sql = "SELECT * FROM $feed_table";
    List<Map<String, dynamic>> list = await _databaseHelper.query(feed_dbname, sql);
    List<FeedModel> newlist = new List();
    for(int i=0;i<list.length;i++){
      Cover cover = new Cover(list[i]["image_url"]);
      Content content = new Content(cover, list[i]["content"]);
      FeedModel model = new FeedModel(content);
      newlist.add(model);
    }
    return newlist;
  }

}