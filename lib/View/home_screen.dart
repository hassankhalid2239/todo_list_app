import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list_app/Contoller/state_controller.dart';
import 'package:todo_list_app/Contoller/theme_controller.dart';
import 'package:todo_list_app/View/Widgets/circular_progress_bar.dart';
import 'package:todo_list_app/View/task_detail_screen.dart';
import '../Contoller/task_controller.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _taskController = Get.put(TaskController());
  // final _themeController = Get.put(ThemeController());
  final _stateController = Get.put(StateController());
  final _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.surface,
          statusBarIconBrightness: Theme.of(context).brightness,
        ),
        elevation: 0,
        forceMaterialTransparency: true,
        // backgroundColor: Color(0xffd9daf3),
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: SvgPicture.asset(
            'assets/svg/todolist.svg',
            colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                _themeController.changeTheme(context);
              },
              icon: Icon(
                _themeController.theme == true
                    ? Icons.light_mode
                    : Icons.dark_mode,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SizedBox(
                    height: 25,
                    width: 25,
                    child: Obx(() {
                      if(_taskController.taskList.length!=0){
                        return MyCircularProgressBar(
                          totalTasks: _taskController.taskList.length.toDouble(),
                          completedTasks: _taskController.ct.toDouble(),
                        );
                      }else{
                        return CircularProgressIndicator(
                          value: 0,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                        );
                      }
                    })),
                title: Obx(() {
                  return Text(
                    '${_taskController.completedTask == 0 ? 0 : _taskController.completedTask} of ${_taskController.taskList.length} task',
                    style: GoogleFonts.bebasNeue(
                      color: Theme.of(context).colorScheme.onPrimary,
                      // color: Color(0xff9395D3),
                    ),
                  );
                }),
                trailing: PopupMenuButton(
                  tooltip: 'filter',
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  position: PopupMenuPosition.under,
                  color: Theme.of(context).colorScheme.surfaceBright,
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      // onTap: (){
                      //   _taskController.getTasks();
                      // },
                      child: Obx(() {
                        return Text(
                          'All',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: _stateController.selectedValue.value == 1
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.color,
                              ),
                        );
                      }),
                    ),
                    PopupMenuItem(
                      value: 2,
                      // onTap: (){
                      //   _taskController.getTasks();
                      // },
                      child: Obx(() {
                        return Text(
                          'By Time',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: _stateController.selectedValue.value == 2
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.color,
                              ),
                        );
                      }),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Obx(() {
                        return Text(
                          'Deadline',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: _stateController.selectedValue.value == 3
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.color,
                              ),
                        );
                      }),
                    ),
                  ],
                  onSelected: (value) {
                    _stateController.updateSelectedValue(value);
                    _taskController.getTasks();
                  },
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
                        color: _taskController.taskList[index].isCompleted ==
                                'true'
                            ? Color(0xffF79E89)
                            : Color(0xffF76C6A),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          splashFactory: InkRipple.splashFactory,
                          splashColor: Colors.redAccent,
                          overlayColor:
                              const WidgetStatePropertyAll(Colors.redAccent),
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
                                _taskController.taskList[index].title
                                    .toString(),
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
                                if (_taskController
                                        .taskList[index].isCompleted ==
                                    'true') {
                                  return GestureDetector(
                                      onTap: () {
                                        _taskController.markTaskCompleted(
                                            int.parse(_taskController
                                                .taskList[index].id
                                                .toString()),
                                            false.toString());
                                        _taskController.getTasks();
                                      },
                                      child: const Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                        size: 30,
                                      ));
                                } else {
                                  return GestureDetector(
                                      onTap: () {
                                        _taskController.markTaskCompleted(
                                            int.parse(_taskController
                                                .taskList[index].id
                                                .toString()),
                                            true.toString());
                                        _taskController.getTasks();
                                      },
                                      child: const Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.white,
                                        size: 30,
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
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
