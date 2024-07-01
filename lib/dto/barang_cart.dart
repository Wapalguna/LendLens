// ignore_for_file: non_constant_identifier_names

import 'package:lens_lend/endpoints/endpoints_lens.dart';

class BarangFavorite{
  final int idCrt;
  final String DeskripsiBarang;
  final String gambar_barang;
  final int id_barang;
  final int id_kategori;
  final int jumlah_barang;
  final String nama_barang;
  final int idBarang;
  final int idUser;

  BarangFavorite({
    required this.idCrt,
    required this.DeskripsiBarang,
    required this.gambar_barang,
    required this.id_barang,
    required this.id_kategori,
    required this.jumlah_barang,
    required this.nama_barang,
    required this.idBarang,
    required this.idUser
  });

  factory BarangFavorite.fromJson(Map<String, dynamic> json){
    return BarangFavorite(
      idCrt: json['id_cart'] ?? 0,
      idBarang: json['id_barang'] ?? 0,
      idUser: json['id_user'] ?? 0,
      DeskripsiBarang: json['deskripsi_barang'] as String, 
      gambar_barang: json['gambar_barang'] != null
      ? '${LensEndpoints.baseUAS}/static/img/${json['gambar_barang']}'
      : 'https://via.placeholder.com/150', 
      id_barang: json['id_barang'] as int, 
      id_kategori: json['id_kategori'] as int, 
      jumlah_barang: json['jumlah_barang'] as int, 
      nama_barang: json['nama_barang'] as String,
      );
  }

}