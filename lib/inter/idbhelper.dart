abstract class IDbHelper{

  ///创建数据库
  void create(String dbName, String tableName);

  ///插入
  void insert(String dbName, String sql);

  ///修改
  void update(String dbName, String sql, List arg);

  ///删除
  void delete(String dbName, String sql);

  ///查询
  void query(String dbName, String sql);
}