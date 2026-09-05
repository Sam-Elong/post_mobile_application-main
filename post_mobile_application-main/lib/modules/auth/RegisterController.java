import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void onRegister() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty) {
      Get.snackbar("Error", "Please enter username");
      return;
    }

    if (password.isEmpty) {
      Get.snackbar("Error", "Please enter password");
      return;
    }

    Get.snackbar(
      "Success",
      "Register Successfully",
    );

    Get.back();
  }
}