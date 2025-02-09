// ignore_for_file: non_constant_identifier_names

class Profile {
  final int idProfile;
  final int idUser;
  final String? profile_picture;
  final String? noHandphone;
  final String? alamat;
  final DateTime? tanggalLahir;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? nama; // Add the 'nama' field

  Profile({
    required this.idProfile,
    required this.idUser,
    required this.profile_picture,
    required this.noHandphone,
    required this.alamat,
    required this.tanggalLahir,
    required this.createdAt,
    required this.updatedAt,
    required this.nama,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        idProfile: json["id_profile"],
        idUser: json["id_user"],
        profile_picture: json["profile_picture"],
        noHandphone: json["no_handphone"],
        alamat: json["alamat"],
        tanggalLahir: json["tanggal_lahir"] != null
            ? DateTime.parse(json["tanggal_lahir"])
            : null,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        nama: json['nama'], // Parse the 'nama' field
      );
}
