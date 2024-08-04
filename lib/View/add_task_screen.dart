import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/Model/task_model.dart';
import '../Contoller/task_controller.dart';
import 'Widgets/custom_textformfield.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _taskController = Get.put(TaskController());

  final titleTextController = TextEditingController();

  final descriptionTextController = TextEditingController();

  final date = DateFormat('EEE, d MMMM, yyyy, h:mma').format(DateTime.now());

  final dueDateTextController = TextEditingController(text:DateFormat('EEE, d MMMM, yyyy').format(DateTime.now()));

  final bool isCompleted= false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleTextController.dispose();
    descriptionTextController.dispose();
    dueDateTextController.dispose();
  }

  void submitData()async{
    if(titleTextController.text.isNotEmpty && descriptionTextController.text.isNotEmpty){
      //add task
      await _addTaskToDb();
      _taskController.getTasks();
      Get.back();
    }else if(titleTextController.text.isEmpty || descriptionTextController.text.isEmpty){
      Get.snackbar(
        'Required',
        'All fields are required !',
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        icon: Icon(Icons.warning_amber_rounded,
          color: Colors.red,),
        colorText: Colors.pinkAccent,
      );
    }
  }

  _addTaskToDb()async{
    int value = await _taskController.addTask(
      task: TaskModel(
        title: titleTextController.text,
        description: descriptionTextController.text,
        date: date,
        dueDate: dueDateTextController.text,
        isCompleted: isCompleted.toString()
      )
    );
    print("My id is "+"$value");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9395D3),
        foregroundColor: Colors.white,
        title: Text('Add Task',style: GoogleFonts.jost(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600
        ),),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
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
                            DateFormat('EEE, d MMMM, yyyy').format(pickedDate);
                      }else{
                        dueDateTextController.text=
                            DateFormat('EEE, d MMMM, yyyy').format(DateTime.now());
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Date',
                      suffixIcon: Icon(Icons.date_range,color: Color(0xff9395D3),),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                CustomInputField(
                    controller: titleTextController,
                    labelText: 'Title',
                    cursorColor: Color(0xff9395D3),
                    borderColor: Color(0xff9395D3)),
                SizedBox(height: 10,),
                CustomInputField(
                  minLines: 1,
                    maxLines: 15,
                    controller: descriptionTextController,
                    labelText: 'Detail',
                    cursorColor: Color(0xff9395D3),
                    borderColor: Color(0xff9395D3)),
                SizedBox(height: 10,),
                SizedBox(height: 25,),
                SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                        backgroundColor: WidgetStatePropertyAll(Color(0xff9395D3))
                    ),
                    onPressed: (){
                      submitData();
                    },
                    child: Text('Add',style: GoogleFonts.jost(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
