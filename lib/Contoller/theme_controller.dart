import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/Utils/theme.dart';
import '../db/shared_prefrence.dart';

class ThemeController extends GetxController {
  RxBool theme = false.obs;
  SharedPref sharedPref = SharedPref();

  void changeTheme(BuildContext context) {
    if (theme == true) {
      theme = false.obs;
      sharedPref.setData(false);
      Get.changeTheme(lightThemeData(context));
    } else if (theme == false) {
      theme = true.obs;
      sharedPref.setData(true);
      Get.changeTheme(darkThemeData(context));
    }
  }
}
