import 'package:sqflite/sqflite.dart';
import 'package:todo_list_app/Model/task_model.dart';

class DbHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "tasks";

  static Future<void> initDB() async {
    if (_db != null) {
      return;
    }
    try {
      String path = await getDatabasesPath() + 'tasks.db';
      _db =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        // print('Creating a new one');
        return db.execute(
          "CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title TEXT, description TEXT, date TEXT,"
          "dueDate TEXT, isCompleted TEXT)",
        );
      });
    } catch (e) {
      // print(e);
    }
  }

  static Future<int> insert(TaskModel? task) async {
    // print('insert function called');
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    // print('query function called');
    return await _db!.query(_tableName);
  }

  // static Future<List<Map<String, dynamic>>> queryAll() async {
  //   // print('query function called');
  //   return await _db!.rawQuery(
  //     '''
  //     SELECT COUNT(*)
  //     FROM tasks
  //     WHERE isCompleted = 'true'
  //     '''
  //   );
  // }
  // Function to get the count of completed tasks
  static Future<int> getCompletedTaskCount() async {
    final List<Map<String, dynamic>> result = await _db!.rawQuery(
        'SELECT COUNT(*) as count FROM $_tableName WHERE isCompleted = ?',
        ['true']
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  static delete(TaskModel task) async {
    await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id, String isCompleted) async {
    await _db!.rawUpdate('''
      UPDATE tasks
      SET isCompleted = ?
      WHERE id =?
      ''', [isCompleted, id]);
  }

  static updateTask(TaskModel task) async {
    await _db!.update(
      _tableName,
      task.toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
