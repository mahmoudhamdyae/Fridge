class RegisterRequest {
  String? name;
  String? phone;
  String? password;
  String? address;
  String? fridgeName;

  RegisterRequest({
    this.name,
    this.phone,
    this.password,
    this.address,
    this.fridgeName,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'password': password,
      'address': address,
      'fridge_name': fridgeName
    };
  }
}