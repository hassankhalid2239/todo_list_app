import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/View/home_screen.dart';
import 'package:todo_list_app/View/splash_screen.dart';
import 'package:todo_list_app/db/db_helper.dart';

import 'Contoller/theme_controller.dart';
import 'Utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDB();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _themeController = Get.put(ThemeController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-do List',
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: _themeController.theme==true? ThemeMode.dark: ThemeMode.light,
      home:  SplashScreen(),
    );
  }
}
