import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:post_mobile_application/core/api/api_service.dart';
import 'package:post_mobile_application/core/data/local/access_token_storage.dart';
import 'package:post_mobile_application/core/models/auth/login/LoginRequest.dart';
import 'package:post_mobile_application/routes/app_route_name.dart';

class LoginController extends GetxController {
  final ApiService apiService;

  LoginController({required this.apiService});

  var usernameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;

  var loading = false.obs;

  Future<void> onLogin() async {
    var email = usernameController.value.text.trim();
    var password = passwordController.value.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter your email",
      );
      return;
    }

    if (password.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter your password",
      );
      return;
    }

    loading.value = true;

    var response = await apiService.login(
      LoginRequest(
        email: email,
        password: password,
      ),
    );

    loading.value = false;

    if (response.accessToken != null) {
      AccessTokenStorage.setAccessToken(
        response.accessToken ?? "",
      );

      AccessTokenStorage.setRefreshToken(
        response.refreshToken ?? "",
      );

      Get.snackbar(
        "Success",
        "Login Successfully",
      );

      Get.offNamed(AppRouteName.home);
    } else {
      Get.snackbar(
        "Error",
        "Email or password incorrect",
      );
    }
  }

  @override
  void onClose() {
    usernameController.value.dispose();
    passwordController.value.dispose();
    super.onClose();
  }
}