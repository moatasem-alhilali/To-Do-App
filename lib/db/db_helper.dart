import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tablename = 'tasks';

  static Future<void> initDb() async {
    if (_db != null) {
      return ;
    }
    try {
      String _path = await getDatabasesPath() + 'tasked._to_doss dbssss';
      _db =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        print("data opend");
        return db.execute(
          'CREATE TABLE $_tablename('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'title STRING, note TEXT, date STRING, '
          'startTime STRING, endTime STRING, '
          'remind INTEGER, repeat STRING, '
          'color INTEGER, '
          'isCompleted INTEGER)',
        );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> deleteAllNotes() async {
    // Database db = await instance.database;
    return await _db!.delete(_tablename);
  }
  static Future<int> insert(Task task) async {

    print("insert");
    return await _db!.insert(_tablename, task.toJson());
  }

  static Future<int> delete(Task task) async {
    print("delete");

    return await _db!.delete(_tablename, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    return _db!.query(_tablename);
  }

  static Future<int> update(Task task) async {
    print("update function called");
    return await _db!.rawUpdate(
      'UPDATE $_tablename SET isCompleted = ? WHERE id = ? ',
      [task.isCompleted,  task.id],
    );
  }
}
