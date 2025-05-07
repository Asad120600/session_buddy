import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  static const Color primaryColor = Color.fromRGBO(76, 175, 80, 1);

  // Light Theme Colors
  static const Color lightBackground = Colors.white;
  static const Color lightText = Color.fromRGBO(44, 44, 44, 4)  ;

  // Dark Theme Colors
  static const Color darkBackground = Color.fromRGBO(44, 44, 44, 4)  ;
  static const Color darkText = Colors.white;

  static const Color greyColor = Colors.grey;
  static const Color btnColor = Color.fromRGBO(76, 175, 80, 1);
  static const Color borderColor = Colors.grey;
  static const Color lightGrey = Color(0xFFF5F5F5);

  // Get Dynamic Theme Colors
  static Color get background =>
      Get.isDarkMode ? darkBackground : lightBackground;
  static Color get text => Get.isDarkMode ? darkText : lightText;
  static Color get cardColor =>
      Get.isDarkMode ? Colors.grey[900]! : Colors.white;
  static Color get iconColor => Get.isDarkMode ? Colors.white : Colors.black;
}
