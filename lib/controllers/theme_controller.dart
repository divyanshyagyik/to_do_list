import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  ThemeData get theme => isDarkMode.value ? ThemeData.dark() : ThemeData.light();

  void toggleTheme() {
    isDarkMode.toggle();
    Get.changeTheme(theme);
  }
}