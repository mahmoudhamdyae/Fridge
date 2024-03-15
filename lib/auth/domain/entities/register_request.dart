class RegisterRequest {
  String? name;
  String? phone;
  String? password;
  String? confirmPassword;

  RegisterRequest({
    this.name,
    this.phone,
    this.password,
    this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'password': password,
      'confirm_password': confirmPassword,
    };
  }
}