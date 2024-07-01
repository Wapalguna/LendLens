// ignore_for_file: file_names

class LoginLens {
  final int idUser;
  final String accessToken;
  final String tokenType;
  final int expiresIn;

  LoginLens ({
    required this.idUser,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory LoginLens.fromJson(Map<String, dynamic> json) => LoginLens(
        idUser: json["id_user"] as int,
        accessToken: json["access_token"] as String,
        tokenType: json["type"] as String,
        expiresIn: json["expires_in"] as int,
      );
}
