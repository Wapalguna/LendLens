// ignore_for_file: non_constant_identifier_names

class Register {
  final String accessToken;
  final int id_user;

  Register({required this.accessToken, required this.id_user});

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      accessToken: json['accessToken'],
      id_user: json['id_user'],
    );
  }
}
