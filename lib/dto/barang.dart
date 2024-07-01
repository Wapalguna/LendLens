// ignore_for_file: non_constant_identifier_names

import 'package:lens_lend/endpoints/endpoints_lens.dart';

class Barang {
  final int id_barang;
  final String nama_barang;
  final int jumlah;
  final String deskripsi;
  final int id_kategori;
  final String gambar;

  Barang({
    required this.id_barang,
    required this.nama_barang,
    required this.jumlah,
    required this.deskripsi,
    required this.id_kategori,
    required this.gambar
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
        id_barang: json["id_barang"] as int,
        nama_barang: json['nama_barang'] as String,
        jumlah: json['jumlah_barang'] as int,
        deskripsi: json['deskripsi_barang'] as String,
        id_kategori: json['id_kategori'] as int,
        gambar: json['gambar_barang'] != null
        ? '${LensEndpoints.baseUAS}/static/img/${json['gambar_barang']}'
        : 'https://via.placeholder.com/150',

      );
  } 
}
