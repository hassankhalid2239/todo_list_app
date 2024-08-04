// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/Contoller/task_controller.dart';

import '../Model/task_model.dart';

class TaskDetailScreen extends StatefulWidget {
  final TaskModel? task;
  const TaskDetailScreen({
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
        backgroundColor: const Color(0xff9395D3),
        foregroundColor: Colors.white,
        actions: [
          widget.task!.isCompleted == 'false'
              ? const Icon(
                  Icons.access_time_outlined,
                  color: Colors.white,
                )
              : const SizedBox(),
          const SizedBox(
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
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: PopScope(
        onPopInvoked: (didPop) {
          TaskModel updatedTask = TaskModel(
            id: widget.task!.id,
            title: titleTextController.text,
            description: descriptionTextController.text,
            isCompleted: widget.task!.isCompleted,
            date: widget.task!.date,
            dueDate: dueDateTextController.text.replaceFirst('Due date: ', ''),
          );
          _taskController.updateTask(updatedTask);
          Get.snackbar(
            'InBuild',
            'Update Function is not build !',
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
            ),
            colorText: Colors.pinkAccent,
          );
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: GoogleFonts.jost(
                      color: const Color(0xff9395D3),
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
                  cursorColor: const Color(0xff9395D3),
                  decoration: InputDecoration(
                    label: const Text('Title'),
                    labelStyle: GoogleFonts.jost(
                        color: const Color(0xff9395D3),
                        fontSize: 26,
                        fontWeight: FontWeight.w500),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: GoogleFonts.jost(
                      color: const Color(0xff9395D3),
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
                  cursorColor: const Color(0xff9395D3),
                  decoration: InputDecoration(
                    label: const Text('Description'),
                    labelStyle: GoogleFonts.jost(
                        color: const Color(0xff9395D3),
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    textAlign: TextAlign.end,
                    keyboardType: TextInputType.none,
                    style: GoogleFonts.jost(
                      color: widget.task!.isCompleted == 'false'
                          ? Colors.red
                          : const Color(0xff9395D3),
                    ),
                    controller: dueDateTextController,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          builder: (context, child) => Theme(
                                data: ThemeData().copyWith(
                                    colorScheme: ColorScheme.light(
                                        background: Theme.of(context)
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
                      } else {
                        dueDateTextController.text =
                            'Due date: ${DateFormat('EEE, d MMMM, yyyy').format(DateTime.now())}';
                      }
                    },
                    cursorColor: const Color(0xff9395D3),
                    decoration: const InputDecoration(
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
            style:
                GoogleFonts.jost(color: const Color(0xff9395D3), fontSize: 14),
          ),
        ),
        // color: Colors.transparent,
      ),
    );
  }
}
