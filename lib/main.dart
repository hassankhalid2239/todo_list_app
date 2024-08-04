import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/View/splash_screen.dart';
import 'package:todo_list_app/db/db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-do List',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffd9daf3),
        // scaffoldBackgroundColor: Color(0xffB3B7EE),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
