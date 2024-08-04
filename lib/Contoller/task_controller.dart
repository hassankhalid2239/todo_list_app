import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/Model/task_model.dart';

import '../db/db_helper.dart';

class TaskController extends GetxController{
  @override
  void onReady(){
    getTasks();
    super.onReady();
  }

  var taskList = <TaskModel>[].obs;



  //Insert Data into Database
  Future<int> addTask({TaskModel? task})async{
    return await DbHelper.insert(task);
  }

  //get all data from Database

  void getTasks()async{
    List<Map<String, dynamic>> tasks = await DbHelper.query();
    taskList.assignAll(tasks.map((data)=> new TaskModel.fromJson(data)).toList());
  }

  void delete(TaskModel task){

    DbHelper.delete(task);

  }

  void markTaskCompleted(int id, String isCompleted)async{
    await DbHelper.update(id, isCompleted);
  }




  Stream<List<TaskModel>> getTasksAsStream() {
    return DbHelper.getTasksAsStream();
  }







}