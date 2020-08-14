import 'package:flutter_app_new/inter/idbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper extends IDbHelper{

  static const detabase_version = 1;

  @override
  Future<void> create(String dbName, String tableName) async {
    //获取数据库路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    //打开数据库
    await openDatabase(
        path,
        version:detabase_version,
        onUpgrade: (Database db, int oldVersion, int newVersion) async{
          //数据库升级,只回调一次
          print("数据库需要升级！旧版：$oldVersion,新版：$newVersion");
        },
        onCreate: (Database db, int vers) async{
          //创建表，只回调一次
          await db.execute(tableName);
          await db.close();
        }
    );
  }

  @override
  Future<void> insert(String dbName, String sql) async {
        //获取数据库路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    print("数据库路径：$path");

    Database db = await openDatabase(path);
    await db.transaction((txn) async {
      int count = await txn.rawInsert(sql);
    });
    await db.close();
  }

  @override
  Future<void> update(String dbName, String sql, List arg) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    Database db = await openDatabase(path);
    int count = await db.rawUpdate(sql,arg);//修改条件，对应参数值
    await db.close();
  }

  @override
  Future<void> delete(String dbName, String sql) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    Database db = await openDatabase(path);
    int count = await db.rawDelete(sql);
    await db.close();
  }

  @override
  Future<List<Map<String, dynamic>>> query(String dbName, String sql) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    Database db = await openDatabase(path);
    List<Map<String, dynamic>> list = List.from(await db.rawQuery(sql));
    await db.close();
    return list;
  }

//  ///查全部
//  query(String dbName,String sql) async {
//    var databasesPath = await getDatabasesPath();
//    String path = join(databasesPath, dbName);
//
//    Database db = await openDatabase(path);
//    List<Map> list = await db.rawQuery(sql);
//    await db.close();
//  }

}