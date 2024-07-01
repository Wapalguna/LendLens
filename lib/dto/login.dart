// ignore_for_file: non_constant_identifier_names

class Login {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final int id_user;
  final String role;

  Login(
      {required this.accessToken,
      required this.tokenType,
      required this.expiresIn,
      required this.id_user,
      required this.role
      });

  factory Login.fromJson(Map<String, dynamic> json) {
    if (json['access_token'] == null) {
      throw ArgumentError('One of the required fields is missing or null');
    }

    return Login(
      accessToken: json['access_token'] as String,
      tokenType: json['type'] as String,
      expiresIn: json['expires_in'] as int,
      // id_user: (json['id_user'] ?? 0) as int,
      id_user: json['id_user'] as int,
      role: json['role'] as String,
    );
  }
}
