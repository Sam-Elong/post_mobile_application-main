class RegisterRequest {
  String? username;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? password;
  String? confirmPassword;
  String? role;
  String? profile;

  RegisterRequest({
    this.username,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.password,
    this.confirmPassword,
    this.role,
    this.profile,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "firstName": firstName,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "role": role,
      "profile": profile,
    };
  }
}