import 'package:post_mobile_application/core/models/auth/login/LoginRequest.dart';
import 'package:post_mobile_application/core/models/auth/login/LoginResponse.dart';
import 'package:post_mobile_application/core/models/auth/register/register_request.dart';

abstract class ApiService {
  Future<LoginResponse> login(LoginRequest req);

  Future<bool> refreshToken();

  Future<dynamic> get(String url);

  Future<bool> register(RegisterRequest request);
}