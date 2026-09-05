import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as httpClient;

import 'package:post_mobile_application/constants/url_constant.dart';
import 'package:post_mobile_application/core/api/api_service.dart';
import 'package:post_mobile_application/core/data/local/access_token_storage.dart';

import 'package:post_mobile_application/core/models/auth/login/LoginRequest.dart';
import 'package:post_mobile_application/core/models/auth/login/LoginResponse.dart';
import 'package:post_mobile_application/core/models/auth/login/RefreshTokenRequest.dart';

import 'package:post_mobile_application/core/models/auth/register/register_request.dart';

import 'package:post_mobile_application/routes/app_route_name.dart';

class ApiServiceImpl implements ApiService {
  Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  @override
  Future<LoginResponse> login(LoginRequest req) async {
    LoginResponse loginResponse = LoginResponse();

    var url = Uri.parse(UrlConstants.loginPath);

    print("==================================");
    print("LOGIN REQUEST = ${jsonEncode(req.toJson())}");

    var response = await httpClient.post(
      url,
      body: jsonEncode(req.toJson()),
      headers: headers,
    );

    print("LOGIN STATUS = ${response.statusCode}");
    print("LOGIN BODY   = ${response.body}");
    print("==================================");

    if (response.statusCode == 200) {
      loginResponse = LoginResponse.fromJson(
        jsonDecode(response.body),
      );
    }

    return loginResponse;
  }

  @override
  Future<bool> refreshToken() async {
    LoginResponse loginResponse = LoginResponse();

    var url = Uri.parse(
      UrlConstants.refreshTokenPath,
    );

    var response = await httpClient.post(
      url,
      body: jsonEncode(
        RefreshTokenRequest(
          refreshToken:
          "${AccessTokenStorage.getRefreshToken()}",
        ).toJson(),
      ),
      headers: headers,
    );

    if (response.statusCode == 200) {
      loginResponse = LoginResponse.fromJson(
        jsonDecode(response.body),
      );

      AccessTokenStorage.setAccessToken(
        loginResponse.accessToken ?? "",
      );

      AccessTokenStorage.setRefreshToken(
        loginResponse.refreshToken ?? "",
      );

      return true;
    }

    return false;
  }

  @override
  Future get(String url) async {
    headers["Authorization"] =
    "Bearer ${AccessTokenStorage.getAccessToken()}";

    var response = await httpClient.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    if (response.statusCode == 401) {
      if (await refreshToken()) {
        headers["Authorization"] =
        "Bearer ${AccessTokenStorage.getAccessToken()}";

        var retryResponse = await httpClient.get(
          Uri.parse(url),
          headers: headers,
        );

        if (retryResponse.statusCode == 200) {
          return retryResponse.body;
        }
      } else {
        Get.offNamed(AppRouteName.splash);
      }
    }

    return null;
  }

  @override
  Future<bool> register(RegisterRequest request) async {
    var url = Uri.parse(UrlConstants.registerPath);

    var response = await httpClient.post(
      url,
      headers: headers,
      body: jsonEncode(request.toJson()),
    );

    print("==================================");
    print("REQUEST: ${jsonEncode(request.toJson())}");
    print("STATUS : ${response.statusCode}");
    print("BODY   : ${response.body}");
    print("==================================");

    return response.statusCode == 200;
  }
}