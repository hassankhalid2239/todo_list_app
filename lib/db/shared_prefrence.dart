// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPref {
//   // var theme;
//   void setData(var theme) async {
//     var ref = await SharedPreferences.getInstance();
//     ref.setBool('theme', true);
//   }
//
//   Future<Bool> isTheme() async {
//     var re = await SharedPreferences.getInstance();
//     Bool theme = re.getBool('theme')!;
//     return theme;
//   }
//
//   theme() async {
//     var re = await SharedPreferences.getInstance();
//     String theme = re.getString('theme')!;
//     if (theme == 'Light') {
//       return ThemeMode.light;
//     } else if (theme == 'Dark') {
//       return ThemeMode.dark;
//     } else {
//       return ThemeMode.system;
//     }
//   }
// }
