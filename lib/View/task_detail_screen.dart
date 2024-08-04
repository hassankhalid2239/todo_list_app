import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/Contoller/task_controller.dart';
import 'package:todo_list_app/db/db_helper.dart';

import '../Model/task_model.dart';

class TaskDetailScreen extends StatefulWidget {
  final TaskModel? task;
  TaskDetailScreen({
    super.key,
    required this.task,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final _taskController = Get.put(TaskController());

  final titleTextController = TextEditingController();

  final descriptionTextController = TextEditingController();

  final date = DateFormat('EEE, d MMMM, yyyy, h:mma').format(DateTime.now());

  final dueDateTextController = TextEditingController(
      text: DateFormat('EEE, d MMMM, yyyy').format(DateTime.now()));

  final bool isCompleted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleTextController.text = widget.task!.title.toString();
    descriptionTextController.text = widget.task!.description.toString();
    dueDateTextController.text = 'Due date: ${widget.task!.dueDate.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff9395D3),
        foregroundColor: Colors.white,
        actions: [
          widget.task!.isCompleted == 'false'
              ? Icon(
                  Icons.access_time_outlined,
                  color: Colors.white,
                )
              : SizedBox(),
          SizedBox(
            width: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                _taskController.delete(widget.task!);
                _taskController.getTasks();
                Get.back();
              },
              icon: Icon(
                Icons.delete_outline,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: PopScope(
        onPopInvoked: (didPop) {
          Get.snackbar(
            'InBuild',
            'Update Function is not build !',
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            icon: Icon(Icons.warning_amber_rounded,
              color: Colors.red,),
            colorText: Colors.pinkAccent,
          );

        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: GoogleFonts.jost(
                      color: Color(0xff9395D3),
                      fontSize: 26,
                      fontWeight: FontWeight.w500),
                  maxLines: 5,
                  minLines: 1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'title should not empty!';
                    } else {
                      return null;
                    }
                  },
                  controller: titleTextController,
                  cursorColor: Color(0xff9395D3),
                  decoration: InputDecoration(
                    label: Text('Title'),
                    labelStyle: GoogleFonts.jost(
                        color: Color(0xff9395D3),
                        fontSize: 26,
                        fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: GoogleFonts.jost(
                      color: Color(0xff9395D3),
                      fontSize: 16,
                      height: 1.5,
                      wordSpacing: 1.5,
                      letterSpacing: 0.5),
                  maxLines: 5,
                  minLines: 1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'title should not empty!';
                    } else {
                      return null;
                    }
                  },
                  controller: descriptionTextController,
                  cursorColor: Color(0xff9395D3),
                  decoration: InputDecoration(
                    label: Text('Description'),
                    labelStyle: GoogleFonts.jost(
                        color: Color(0xff9395D3),
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    textAlign: TextAlign.end,
                    keyboardType: TextInputType.none,
                    style: GoogleFonts.jost(
                      color: widget.task!.isCompleted == 'false'
                          ? Colors.red
                          : Color(0xff9395D3),
                    ),
                    controller: dueDateTextController,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          builder: (context, child) => Theme(
                            data: ThemeData().copyWith(
                                colorScheme:
                                ColorScheme.light(
                                    background:
                                    Theme.of(context)
                                        .colorScheme
                                        .background)),
                            child: child!,
                          ),
                          context: context,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        dueDateTextController.text =
                            'Due date: ${DateFormat('EEE, d MMMM, yyyy').format(pickedDate)}';
                      }else{
                        dueDateTextController.text=
                            'Due date: ${DateFormat('EEE, d MMMM, yyyy').format(DateTime.now())}';
                      }
                    },
                    cursorColor: Color(0xff9395D3),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 40,
        padding: EdgeInsets.zero,
        color: Colors.transparent,
        // color: Colors.yellowAccent,
        child: Center(
          child: Text(
            'Created at ${widget.task!.date}',
            // 'Created at $date',
            style: GoogleFonts.jost(color: Color(0xff9395D3), fontSize: 14),
          ),
        ),
        // color: Colors.transparent,
      ),
    );
  }
}

//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:todo_list_app/Contoller/task_controller.dart';
// import 'package:todo_list_app/View/edit_task_screen.dart';
//
// import '../Model/task_model.dart';
//
// class TaskDetailScreen extends StatelessWidget {
//   final TaskModel? task;
//   TaskDetailScreen({super.key,
//     required this.task,
//
// });
//
//   final _taskController = Get.put(TaskController());
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Color(0xff9395D3),
//         foregroundColor: Colors.white,
//         actions: [
//           task!.isCompleted=='false'?
//           Icon(Icons.access_time_outlined,color: Colors.white,):SizedBox(),
//           SizedBox(width: 5,),
//           IconButton(
//             onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>EditTaskScreen(
//                 task: task,
//               )));
//             },
//             icon: Icon(Icons.edit_outlined,color: Colors.white,),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 5),
//             child: IconButton(
//               onPressed: (){
//                 _taskController.delete(task!);
//                 _taskController.getTasks();
//                 Get.back();
//               },
//               icon: Icon(Icons.delete_outline,color: Colors.white,),
//             ),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 10,),
//               Text(
//                 task!.title.toString(),
//                 // title,
//                 // 'Design Logo',
//
//                 style: GoogleFonts.jost(
//                   color: Color(0xff9395D3),
//                   fontSize: 26,
//                   fontWeight: FontWeight.w500
//               ),),
//               SizedBox(height: 20,),
//               Text(
//                 task!.description.toString(),
//                 // description,
//                 // 'This is description of task This is description of task This is description of task This is description of task This is description of task',
//                 style: GoogleFonts.jost(
//                   color: Color(0xff9395D3),
//                   fontSize: 16,
//                   height: 1.5,
//                   wordSpacing: 1.5,
//                   letterSpacing: 0.5
//                 ),),
//               SizedBox(height: 20,),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Text.rich(
//                   TextSpan(text: 'Due date: ',
//                     style: GoogleFonts.jost(
//                         color: Color(0xff9395D3),
//                         fontSize: 14
//                     ),
//                   children: [
//                     TextSpan(text: '${task!.dueDate}',
//                     style: GoogleFonts.jost(
//                       color: task!.isCompleted=='false'?
//                       Colors.red : Color(0xff9395D3),
//                     // color: Color(0xff9395D3),
//                     fontSize: 14
//                 ),)
//                   ])
//                   // 'Due date: $dueDate',
//                   ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         height: 40,
//         padding: EdgeInsets.zero,
//         color: Colors.transparent,
//         // color: Colors.yellowAccent,
//         child: Center(
//           child: Text(
//
//             'Created at ${task!.date}',
//             // 'Created at $date',
//             style: GoogleFonts.jost(
//                 color: Color(0xff9395D3),
//                 fontSize: 14
//             ),),
//         ),
//         // color: Colors.transparent,
//       ),
//     );
//   }
// }
