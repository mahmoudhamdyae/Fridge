class RegisterRequest {
  String? name;
  String? phone;
  String? password;
  String? address;

  RegisterRequest({
    this.name,
    this.phone,
    this.password,
    this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'password': password,
      'address': address,
    };
  }
}