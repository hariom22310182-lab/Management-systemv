class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final String role;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "role": role,
    };
  }
}
