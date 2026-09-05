import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_mobile_application/core/api/api_service.dart';
import 'package:post_mobile_application/core/models/auth/register/register_request.dart';

class RegisterController extends GetxController {
  final ApiService apiService;

  RegisterController({required this.apiService});

  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var loading = false.obs;

  Future<void> onRegister() async {
    if (usernameController.text.trim().isEmpty ||
        firstNameController.text.trim().isEmpty ||

        phoneController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    loading.value = true;

    bool success = await apiService.register(
      RegisterRequest(
        username: usernameController.text.trim(),
        firstName: firstNameController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
        role: "USER",
        profile: "",
      ),
    );

    loading.value = false;

    if (success) {
      Get.snackbar(
        "Success",
        "Register Successfully",
      );

      Get.back();
    } else {
      Get.snackbar(
        "Error",
        "Register Failed",
      );
    }
  }
  @override
  void onClose() {
    usernameController.dispose();
    firstNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}