class LoginRequest {
  String? phone;
  String? password;

  LoginRequest({
    this.phone,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
    };
  }
}