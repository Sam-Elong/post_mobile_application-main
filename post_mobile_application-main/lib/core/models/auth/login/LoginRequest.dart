class LoginRequest {
  LoginRequest({
    this.email,
    this.password,
  });

  String? email;
  String? password;

  LoginRequest.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}