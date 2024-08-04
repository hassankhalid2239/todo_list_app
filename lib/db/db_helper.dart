import 'package:sqflite/sqflite.dart';
import 'package:todo_list_app/Model/task_model.dart';

class DbHelper{
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "tasks";

  static Future<void> initDB()async{
    if(_db != null){
      return;
    }
    try{
      String path = await getDatabasesPath() + 'tasks.db';
      _db = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version){
          print('Creating a new one');
          return db.execute(
            "CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "title TEXT, description TEXT, date TEXT,"
                "dueDate TEXT, isCompleted TEXT)",
          );
        }
      );
    }catch(e){
      print(e);
    }
  }

  static Future<int> insert(TaskModel? task)async{
    print('insert function called');
    return await _db?.insert(_tableName, task!.toJson())??1;
  }

  static Future<List<Map<String, dynamic>>> query()async{
    print('query function called');
    return await _db!.query(_tableName);
  }

  static delete(TaskModel task)async{
    await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id, String isCompleted)async{
    await _db!.rawUpdate(
      '''
      UPDATE tasks
      SET isCompleted = ?
      WHERE id =?
      ''',[isCompleted, id]
    );
  }



  static Stream<List<TaskModel>> getTasksAsStream() async* {
    List<Map<String, dynamic>> taskMaps = await query();
    List<TaskModel> tasks = taskMaps.map((task) => TaskModel.fromJson(task)).toList();
    yield tasks;
  }

}