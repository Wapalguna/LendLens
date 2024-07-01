// ignore_for_file: non_constant_identifier_names

class Kategori {
  final int id_kategori;
  final String nama_kategori;
  final String deskripsi;
  final String gambar_kategori;


  Kategori ({
    required this.id_kategori,
    required this.nama_kategori,
    required this.deskripsi,
    required this.gambar_kategori,
  });

  factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
        id_kategori: json["id_kategori"] as int,
        nama_kategori: json['nama_kategori'] as String,
        deskripsi: json['deskripsi'] as String,
        gambar_kategori: json['gambar_kategori'] as String
      );
}
