class AuthResponse {
  String? token;

  AuthResponse({
    this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['authorisation']['token'] as String?,
    );
  }
}