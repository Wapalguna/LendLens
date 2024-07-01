import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lens_lend/dto/barang.dart';
import 'package:lens_lend/dto/barang_cart.dart';
import 'package:lens_lend/dto/kategori.dart';
import 'dart:convert';
import 'package:lens_lend/endpoints/endpoints_lens.dart';


class DataService {
  static Future<http.Response> sendSignUpData(
      String email, String password) async {
    final url = Uri.parse(LensEndpoints.register);
    final data = {'username': email, 'kata_sandi': password};
    final response = await http.post(
      url,
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(data),
    );
    return response;
  }

  static Future<List<BarangFavorite>> fetchWisataFavoritByUser(int idUser) async {
    final response = await http.get(Uri.parse('${LensEndpoints.barang}/user/$idUser'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return (jsonData['datas'] as List)
          .map((data) => BarangFavorite.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load favorite wisata by user');
   }
  }

  static Future<void> addFavorite(int idUser, int idBarang) async {
    final url = Uri.parse('${LensEndpoints.barang}/add'); // Sesuaikan dengan endpoint Anda
    final response = await http.post(
      url,
      body: jsonEncode({
        'id_user': idUser,
        'id_barang': idBarang,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      debugPrint('Wisata berhasil ditambahkan ke favorit');
    } else {
      throw Exception('Gagal menambahkan wisata ke favorit');
    }
  }

  static Future<void> removeFavorite(int idUser, int idBarang) async {
    final url = Uri.parse('${LensEndpoints.barang}/remove'); // Sesuaikan dengan endpoint Anda
    final response = await http.post(
      url,
      body: jsonEncode({
        'id_user': idUser,
        'id_barang': idBarang,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      debugPrint('Wisata berhasil dihapus dari favorit');
    } else {
      throw Exception('Gagal menghapus wisata dari favorit');
    }
  }

  // static Future<http.Response> sendSpendingData(int spending) async {
  //   final url = Uri.parse(Endpoints.spending);
  //   final data = {'spending': spending};

  //   final response = await http.post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode(data),
  //   );

  //   return response;
  // }

  static Future<http.Response> sendLoginData(
      String email, String password) async {
    final url = Uri.parse(LensEndpoints.login1);
    debugPrint("$email test");
    debugPrint("$password test");

    final data = {'username': email, 'password': password};

    final response = await http.post(
      url,
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(data),
    );
    return response;
  }

  // static Future<http.Response> logoutData() async {
  //   final url = Uri.parse(Endpoints.logout);
  //   final String? accessToken =
  //       await SecureStorageUtil.storage.read(key: tokenStoreName);
  //   debugPrint("logout with $accessToken");

  //   final response = await http.post(url, headers: {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $accessToken',
  //   });
  //   return response;
  // }

  static Future<List<Kategori>> fetchKategori() async {
    final response = await http.get(Uri.parse(LensEndpoints.kategoriRead));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Kategori.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data ${response.statusCode}');
    }
  }

  static Future<http.Response> sendRegisterData(
      String email, String password) async {
    final url = Uri.parse(LensEndpoints.register);

    final data = {'username': email, 'password': password};

    final response = await http.post(
      url,
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(data),
    );
    return response;
  }

  static Future<List<Barang>> fetchbarang() async {
    final response = await http.get(Uri.parse(LensEndpoints.barangRead));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Barang.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data ${response.statusCode}');
    }
  }

  static Future<void> deleteBarang(int idBarang) async {
    await http.delete(Uri.parse('${LensEndpoints.delete}/$idBarang'),
        headers: {'Content-type': 'application/json'});
  }

  static Future<List<Barang>> fetchBarangByCategory(int idKategori, int page) async {
    try {
      final response =
          await http.get(Uri.parse('${LensEndpoints.barangRead}/$idKategori').replace(queryParameters: {'page': page.toString()}));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);

        debugPrint('Response data: $decodedResponse');

        if (decodedResponse is List) {
          if (decodedResponse.isEmpty) {
            debugPrint('No data available: empty list');
            return [];
          } else {
            return decodedResponse
                .whereType<Map<String, dynamic>>()
                .map((item) => Barang.fromJson(item))
                .toList();
          }
        } else if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('datas')) {
          final datas = decodedResponse['datas'];
          if (datas is List) {
            if (datas.isEmpty) {
              debugPrint('No data available: empty "datas" list');
              return [];
            } else {
              return datas
                  .whereType<Map<String, dynamic>>()
                  .map((item) => Barang.fromJson(item))
                  .toList();
            }
          } else {
            debugPrint('Unexpected "datas" type: ${datas.runtimeType}');
            throw Exception('Unexpected "datas" type');
          }
        } else {
          debugPrint('Unexpected JSON format: $decodedResponse');
          throw Exception('Unexpected JSON format');
        }
      } else {
        debugPrint(
            'Failed to load Barang. Status code: ${response.statusCode}');
        throw Exception('Failed to load');
      }
    } catch (error) {
      debugPrint('Error fetching Barang by category: $error');
      throw Exception('Failed to load barang');
    }
  }

  // static Future<List<Barang>> fetchBarangByCategory(int id_kategori,
  //     {int page = 1, int perPage = 6}) async {
  //   try {
  //     final url =
  //         '${LensEndpoints.barangRead}/$id_kategori?page=$page&per_page=$perPage';
  //     debugPrint('Fetching data from URL: $url');

  //     final response = await http.get(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       final decodedResponse = jsonDecode(response.body);
  //       debugPrint('Response data: $decodedResponse');

  //       if (decodedResponse is Map<String, dynamic> &&
  //           decodedResponse.containsKey('datas')) {
  //         final datas = decodedResponse['datas'];
  //         if (datas is List) {
  //           if (datas.isEmpty) {
  //             debugPrint('No data available: empty "datas" list');
  //             return [];
  //           } else {
  //             return datas
  //                 .where((item) => item is Map<String, dynamic>)
  //                 .map((item) => Barang.fromJson(item as Map<String, dynamic>))
  //                 .toList();
  //           }
  //         } else {
  //           debugPrint('Unexpected "datas" type: ${datas.runtimeType}');
  //           throw Exception('Unexpected "datas" type');
  //         }
  //       } else {
  //         debugPrint('Unexpected JSON format: $decodedResponse');
  //         throw Exception('Unexpected JSON format');
  //       }
  //     } else {
  //       debugPrint(
  //           'Failed to load Barang. Status code: ${response.statusCode}');
  //       debugPrint('Response body: ${response.body}');
  //       throw Exception('Failed to load');
  //     }
  //   } catch (error) {
  //     debugPrint('Error fetching Barang by category: $error');
  //     throw Exception('Failed to load Barang');
  //   }
  // }
}
