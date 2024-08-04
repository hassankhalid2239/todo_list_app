import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list_app/Contoller/theme_controller.dart';
import 'package:todo_list_app/View/task_detail_screen.dart';
import '../Contoller/task_controller.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _taskController = Get.put(TaskController());
  final _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.surface,
          statusBarIconBrightness: Theme.of(context).brightness,),
        elevation: 0,
        forceMaterialTransparency: true,
        // backgroundColor: Color(0xffd9daf3),
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: SvgPicture.asset(
              'assets/svg/todolist.svg',
            colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: (){
                _themeController.changeTheme(context);
              },
              icon: Icon(_themeController.theme==true?
                Icons.light_mode: Icons.dark_mode,
                color: Theme.of(context).colorScheme.onTertiary,),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SvgPicture.asset(
                  'assets/svg/logo.svg',
                  colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
                ),
                title: Obx((){
                  return Text('${_taskController.completedTask} of ${_taskController.taskList.length} task',style: GoogleFonts.bebasNeue(
                    color: Theme.of(context).colorScheme.onPrimary,
                    // color: Color(0xff9395D3),
                  ),);
                }),
                trailing: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.filter_alt_outlined,color: Theme.of(context).colorScheme.onPrimary,),
                ),
              ),
            ),
            Obx(() {
              return Expanded(
                child: ListView.builder(
                  itemCount: _taskController.taskList.length,
                  // itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        // color: Theme.of(context).colorScheme.onSecondary,
                        color: _taskController.taskList[index].isCompleted=='true'?
                        Color(0xffF79E89): Color(0xffF76C6A),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TaskDetailScreen(
                                          task: _taskController.taskList[index],
                                        )));
                          },
                          child: ListTile(
                              title: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                _taskController.taskList[index].title.toString(),
                                // 'Task $index',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    _taskController.taskList[index].description
                                        .toString(),
                                    // 'This is description of task This is description of task This is description of task This is description of task This is description of task$index',
                                    style: GoogleFonts.jost(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Due date: ${_taskController.taskList[index].dueDate}',
                                    // 'Due date: 1 Sep, 2021',
                                    style: GoogleFonts.jost(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ),
                              trailing: Obx(() {
                                if (_taskController.taskList[index].isCompleted ==
                                    'true') {
                                  return GestureDetector(
                                      onTap: () {
                                        _taskController.markTaskCompleted(
                                            int.parse(_taskController.taskList[index].id
                                                .toString()),
                                            false.toString());
                                        _taskController.getTasks();
                                      },
                                      child: const Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                      ));
                                } else {
                                  return GestureDetector(
                                      onTap: () {
                                        _taskController.markTaskCompleted(
                                            int.parse(_taskController.taskList[index].id
                                                .toString()),
                                            true.toString());
                                        _taskController.getTasks();
                                      },
                                      child: const Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.white,
                                      ));
                                }
                              })
                              // trailing:index%2==0? Icon(Icons.check_circle_outline,color: Color(0xffB3B7EE),) : Icon(Icons.check_circle,color: Color(0xffB3B7EE),)
                              ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: SizedBox.fromSize(
        size: const Size.square(70),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTaskScreen()));
          },
          shape: const CircleBorder(),
          // backgroundColor: Theme.of(context).colorScheme.onSecondary,
          backgroundColor: const Color(0xffF76C6A),
          child:  Icon(
            Icons.add_task_outlined,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
