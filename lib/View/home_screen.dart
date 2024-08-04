import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list_app/View/task_detail_screen.dart';
import '../Contoller/task_controller.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9395D3),
        title: Text('What Todo',style: GoogleFonts.jost(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600
        ),),
      ),
      body: Obx((){
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          itemCount: _taskController.taskList.length,
          // itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.white,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskDetailScreen(
                      task: _taskController.taskList[index],
                    )));
                  },
                  child: ListTile(
                      title: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        _taskController.taskList[index].title.toString(),
                        // 'Task $index',
                        style: GoogleFonts.jost(
                            color: Color(0xff9395D3),
                            fontWeight: FontWeight.w600
                        ),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            _taskController.taskList[index].description.toString(),
                            // 'This is description of task This is description of task This is description of task This is description of task This is description of task$index',
                            style: GoogleFonts.jost(
                              color: Color(0xff9395D3),
                            ),),
                          SizedBox(height: 10,),
                          Text(
                            'Due date: ${_taskController.taskList[index].dueDate}',
                            // 'Due date: 1 Sep, 2021',
                            style: GoogleFonts.jost(
                                color: Color(0xff9395D3),
                                fontSize: 12
                            ),),
                        ],
                      ),
                      trailing:Obx((){
                        if(_taskController.taskList[index].isCompleted=='true'){
                          return GestureDetector(
                            onTap: (){
                              _taskController.markTaskCompleted(
                                  int.parse(_taskController.taskList[index].id.toString()),
                                  false.toString());
                              _taskController.getTasks();
                            },
                              child: Icon(Icons.check_circle,color: Color(0xffB3B7EE),));
                        }else{
                          return GestureDetector(
                              onTap: (){
                                _taskController.markTaskCompleted(
                                    int.parse(_taskController.taskList[index].id.toString()),
                                    true.toString());
                                _taskController.getTasks();
                              },
                              child: Icon(Icons.check_circle_outline,color: Color(0xffB3B7EE),));
                        }
                      })
                      // trailing:index%2==0? Icon(Icons.check_circle_outline,color: Color(0xffB3B7EE),) : Icon(Icons.check_circle,color: Color(0xffB3B7EE),)
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton:FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskScreen()));
        },
        shape: const CircleBorder(),
        backgroundColor: const Color(0xff9395D3),
        child: const Icon(
          Icons.add,
          size: 28,
          color: Colors.white,
        ),
      ),
    );
  }
}



























