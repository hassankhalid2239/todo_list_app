import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/Utils/theme.dart';

class ThemeController extends GetxController{

  RxBool theme= false.obs;

  void changeTheme(BuildContext context){
    if(theme==true){
      theme=false.obs;
      Get.changeTheme(lightThemeData(context));
    }else if(theme==false){
      theme=true.obs;
      Get.changeTheme(darkThemeData(context));
    }
  }


}