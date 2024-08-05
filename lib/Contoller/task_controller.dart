import 'package:get/get.dart';
import 'package:todo_list_app/Model/task_model.dart';
import '../db/db_helper.dart';

class TaskController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTasks();
    getCompletedTask();
  }

  var taskList = <TaskModel>[].obs;
  var completedTask;
  int ct = 0;

  //Insert Data into Database
  Future<int> addTask({TaskModel? task}) async {
    return await DbHelper.insert(task);
  }

  //get all data from Database

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DbHelper.query();
    taskList.assignAll(tasks.map((data) => TaskModel.fromJson(data)).toList());
    getCompletedTask();
  }

  void getTasksByTime() async {
    List<Map<String, dynamic>> tasks = await DbHelper.query();
    taskList.assignAll(tasks.map((data) => TaskModel.fromJson(data)).toList());
    getCompletedTask();
  }

  void delete(TaskModel task) {
    DbHelper.delete(task);
  }

  Future<int> getCompletedTask() async {
    completedTask = await DbHelper.getCompletedTaskCount();
    ct = completedTask;
    return completedTask;
  }

  void markTaskCompleted(int id, String isCompleted) async {
    await DbHelper.update(id, isCompleted);
  }

  void updateTask(TaskModel task) async {
    await DbHelper.updateTask(task);
    getTasks(); // Refresh task list
  }
}
