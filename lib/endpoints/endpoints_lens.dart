import 'package:lens_lend/screens/secure_storage_util.dart';
import 'package:lens_lend/utils/constants.dart';

class LensEndpoints {

  // static const String baseUAS = "http://192.168.1.16:5000";
  // // auth
  // static const String register = "$baseUAS/api/v1/auth/register";
  // static const String login1 = "$baseUAS/api/v1/auth/login";
  // // kategori
  // static const String kategoriRead = "$baseUAS/api/v1/kategori/read";
  // // barang
  // static const String barang = "$baseUAS/api/v1/barang";
  // static const String barangRead = "$baseUAS/api/v1/barang/read";
  // static const String delete = "$baseUAS/api/v1/barang/delete";
  // static const String search = "$baseUAS/api/v1/barang/search";

  static String baseUAS = '';

  static String login1 = '';
  static String kategoriRead = '';
  static String barang = '';
  static String register = '';
  static String barangRead = '';
  static String delete= '';
  static String search= '';

  static Future<void> initializeURLs() async {
    try {
      baseUAS = await SecureStorageUtil.storage.read(key: baseURL) ?? '';
      if (baseUAS.isNotEmpty) {
        if (!baseUAS.startsWith('http://') && !baseUAS.startsWith('https://')) {
          // Assuming default to http if scheme is missing
          baseUAS = 'http://$baseUAS';
        }
        login1 = "$baseUAS/api/v1/auth/login";
        kategoriRead = "$baseUAS/api/v1/kategori/read";
        barang = "$baseUAS/api/v1/barang";
        barangRead = "$baseUAS/api/v1/barang/read";
        register = "$baseUAS/api/v1/auth/register";
        delete = "$baseUAS/api/v1/barang/delete";
        search = "$baseUAS/api/v1/barang/search";
      } else {
        // Handle the case where the base URL is not set or invalid
        throw Exception('Base URL is empty');
      }
    } catch (e) {
      // Handle any errors that might occur during reading from storage
      // ignore: avoid_print
      print('Error initializing URLs: $e');
      rethrow; // Re-throwing to ensure calling code can handle this error if needed
    }
  }

  

}
