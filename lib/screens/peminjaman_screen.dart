// // ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

// import 'package:flutter/material.dart';

// class PeminjamanPage extends StatelessWidget {
//   final List<Map<String, String>> rentalItems = [
//     {
//       "title": "Kamera Mirrorless",
//       "description": "Kamera Mirrorless Cocok Untuk Berpegian Karena Mudah Untuk dibawa",
//       "price": "Rp. 100.000",
//       "image": "assets/images/cam.png", // Add the appropriate image path
//     },
//     {
//       "title": "Lensa Kamera",
//       "description": "Lensa Kamera Cocok Untuk Berbagai Kebutuhan Fotografi",
//       "price": "Rp. 50.000",
//       "image": "assets/images/lensa.png", // Add the appropriate image path
//     },
//     {
//       "title": "Gimbal Stabilizer",
//       "description": "Gimbal Stabilizer Cocok Untuk Pembuatan Video yang Stabil",
//       "price": "Rp. 150.000",
//       "image": "assets/images/gimbal.png", // Add the appropriate image path
//     },
//     {
//       "title": "Drone",
//       "description": "Drone Cocok Untuk Pengambilan Gambar dari Udara",
//       "price": "Rp. 200.000",
//       "image": "assets/images/drone.png", // Add the appropriate image path
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Peminjaman Page'),
//       ),
//       body: ListView.builder(
//         itemCount: rentalItems.length,
//         itemBuilder: (context, index) {
//           final item = rentalItems[index];
//           return Card(
//             margin: EdgeInsets.all(10),
//             child: ListTile(
//               leading: Image.asset(
//                 item['image']!,
//                 width: 50,
//                 height: 50,
//                 fit: BoxFit.cover,
//               ),
//               title: Text(item['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
//               subtitle: Text(item['description']!),
//               trailing: Text(item['price']!, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lens_lend/cubit/cubit/auth_cubit.dart';
import 'package:lens_lend/dto/barang_cart.dart';
import 'package:lens_lend/services/data_services.dart';

class PeminjamanScreen extends StatefulWidget {
  const PeminjamanScreen({super.key});

  @override
  State<PeminjamanScreen> createState() => _PeminjamanScreenState();
}

class _PeminjamanScreenState extends State<PeminjamanScreen> {
  late Future<List<BarangFavorite>> barangFavoritData;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthCubit>().state;
    barangFavoritData = DataService.fetchWisataFavoritByUser(authState.idPengguna);
  }

  Widget _buildGridView() {
    return FutureBuilder<List<BarangFavorite>>(
      future: barangFavoritData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Error: ${snapshot.error}"),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return InkWell(
                onTap: () {
                  // Uncomment and modify the following code if you have a detailed screen
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => BarangDetailScreen(barang: item),
                  //   ),
                  // );
                },
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          item.gambar_barang,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error, size: 40),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.nama_barang,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              item.DeskripsiBarang,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text("No data available"),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildGridView(),
      ),
    );
  }
}
