import 'package:sqflite/sqflite.dart';
import 'package:todo/models/note.dart';
import 'package:todo/models/task.dart';

class DBHelperNotes {
  static Database? _db;
  static const int _version = 1;
  static const String _tablename = 'notes';

  static Future<void> initDb() async {
    if (_db != null) {
      return ;
    }
    try {
      String _path = await getDatabasesPath() + 'ccccccccccc';
      _db =
      await openDatabase(_path, version: _version, onCreate: (db, version) {
        print("data opend");
        return db.execute('''
      CREATE TABLE $_tablename(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        note TEXT NOT NULL,
        dateTimeEdit TEXT NOT NULL,
        dateTimeCreated TEXT NOT NULL
      )
      ''');
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> addNote(Note note) async {
    print("insert");
    return await _db!.insert(_tablename, note.toJson());
  }

  static Future<int> deleteNote(Note note) async {
  //  Database db = await instance.database;
    return await _db!.delete(
      _tablename,
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  static Future<int> deleteAllNotes() async {
   // Database db = await instance.database;
    return await _db!.delete(_tablename);
  }

  static Future<int> updateNote(Note note) async {
   // Database db = await instance.database;
    return await _db!.update(
      _tablename,
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

    static Future<List<Map<String, dynamic>>> getAllData() async {
      print("query function called");
      return _db!.query(_tablename);
    }


}
