import 'package:get/get.dart';

class StateController extends GetxController{
  var selectedValue = 1.obs;

  void updateSelectedValue(int value) {
    selectedValue.value = value;
  }
}