// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void successSnackBar(String title, String message) {
  Get.snackbar(title, message,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      icon: Icon(
        Icons.check_circle_sharp,
        color: Colors.white,
      ));
}

void errorSnackBar(String title, String message) {
  Get.snackbar(title, message,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      icon: Icon(
        Icons.error_outline,
        color: Colors.white,
      ));
}

