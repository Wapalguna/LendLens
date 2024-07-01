// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lens_lend/Component/bottom_up_transition.dart';
import 'package:lens_lend/cubit/cubit/auth_cubit.dart';
import 'package:lens_lend/dto/barang.dart';
import 'package:lens_lend/screens/updateBarang.dart';
import 'package:lens_lend/services/data_services.dart';

class BarangDetailScreen extends StatefulWidget {
  final Barang barang;

  const BarangDetailScreen({super.key, required this.barang});

  @override
  _BarangDetailScreenState createState() => _BarangDetailScreenState();
}

class _BarangDetailScreenState extends State<BarangDetailScreen> {
  late Future<List<Barang>> BarangFuture;

  @override
  void initState() {
    super.initState();
    // curentBarang = LatLng(widget.Barang.latitude, widget.Barang.longtitude);
  }

  void refresh() {
    setState(() {
      BarangFuture =
          DataService.fetchBarangByCategory(widget.barang.id_kategori, 1);
    });
  }
  void _toggleFavorite() async {
    final authState = context.read<AuthCubit>().state;
    final userId = authState.idPengguna; 

    try {

      if (authState.isCrt
          .contains(widget.barang.id_barang.toString())) {
        await DataService.removeFavorite(userId, widget.barang.id_barang);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red, 
            content: Text('Barang dihapus dari cart!!!!!!!!!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        await DataService.addFavorite(userId, widget.barang.id_barang);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green, 
            content: Text('Barang dtambahkan ke daam cart!!!!!!!!!'),
            duration: Duration(seconds: 2),
          ),
        );
      }

      
      context
          .read<AuthCubit>()
          .toggleCrt(widget.barang.id_barang.toString());
    } catch (error) {
      debugPrint('Gagal mengubah status favorit: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Operasi gagal, coba lagi nanti.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _deleteBarang(int idBarang) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Apakah Anda yakin ingin menghapus postingan ini?"),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                await DataService.deleteBarang(idBarang);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Data berhasil dihapus!'),
                    duration: Duration(seconds: 2),
                  ),
                );
                refresh();
              } catch (error) {
                debugPrint('Gagal menghapus data: $error');
              }
            },
            child: const Text('Ya'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Tidak'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.barang.nama_barang,
          style: GoogleFonts.roboto(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 135, 185, 210),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), 
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.barang.gambar,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 100),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black87],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    widget.barang.nama_barang,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(widget.barang.jumlah.toString()),
                const Spacer(),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final role = state.role;
                    if (role == 'admin') {
                      return Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.push(
                                context,
                                BottomUpRoute(
                                  page: updateBarang(barang: widget.barang),
                                ),
                              ).then((_) => refresh());
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _deleteBarang(widget.barang.id_barang),
                          ),
                        ],
                      );
                    } else {
                      final isFavorite = state.isCrt
                          // ignore: collection_methods_unrelated_type
                          .contains(widget.barang.id_barang);
                      return IconButton(
                        icon: Icon(
                          isFavorite ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                          color: isFavorite ? Colors.blue : Colors.grey,
                          size: 40,
                        ),
                        onPressed: _toggleFavorite,
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Deskripsi:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.barang.deskripsi,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lens_lend/Component/bottom_up_transition.dart';
// import 'package:lens_lend/cubit/cubit/auth_cubit.dart';
// import 'package:lens_lend/dto/barang.dart';
// import 'package:lens_lend/endpoints/endpoints_lens.dart';
// import 'package:lens_lend/screens/create_screen.dart';
// import 'package:lens_lend/screens/updateBarang.dart';
// import 'package:lens_lend/services/data_services.dart';

// class BarangListScreen extends StatefulWidget {
//   final int id_kategori;
//   final String nama_kategori;
//   final Barang? barang;

//   const BarangListScreen({
//     required this.id_kategori,
//     required this.nama_kategori,
//     this.barang,
//   });

//   @override
//   _BarangListScreenState createState() => _BarangListScreenState();
// }

// class _BarangListScreenState extends State<BarangListScreen> {
//   late Future<List<Barang>> _LendLens;

//   @override
//   void initState() {
//     super.initState();
//     _LendLens = DataService.fetchBarangByCategory(widget.id_kategori);
//   }

//   void refresh() {
//     setState(() {
//       _LendLens = DataService.fetchBarangByCategory(widget.id_kategori);
//     });
//   }

//   void _deleteBarang(int idBarang) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Konfirmasi"),
//         content: const Text("Apakah Anda yakin ingin menghapus postingan ini?"),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               try {
//                 await DataService.deleteBarang(idBarang);
//                 Navigator.pop(context);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     backgroundColor: Colors.red,
//                     content: Text('Data berhasil dihapus!'),
//                     duration: Duration(seconds: 2),
//                   ),
//                 );
//                 refresh();
//               } catch (error) {
//                 debugPrint('Gagal menghapus data: $error');
//               }
//             },
//             child: const Text('Ya'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('Tidak'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.nama_kategori,
//           style: GoogleFonts.poppins(
//             color: Colors.white,
//             fontSize: 30,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 30, 129, 209),
//         iconTheme: const IconThemeData(color: Colors.white),
//         actions: [
//           BlocBuilder<AuthCubit, AuthState>(
//             builder: (context, state) {
//               if (state.role == 'admin') {
//                 return IconButton(
//                   icon: const Icon(Icons.add),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       BottomUpRoute(
//                         page:
//                             AddContainer(idInsideKategori: widget.id_kategori),
//                       ),
//                     );
//                   },
//                 );
//               } else {
//                 return Container();
//               }
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<Barang>>(
//         future: _LendLens,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No available.'));
//           } else {
//             final data = snapshot.data!;

//             return ListView.builder(
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 final item = data[index];

//                 return Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16.0, vertical: 8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       item.gambar != null
//                           ? Container(
//                               height: 200,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                     color: Colors.black26,
//                                     blurRadius: 10.0,
//                                     offset: Offset(0, 5),
//                                   ),
//                                 ],
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 child: Image.network(
//                                   '${LensEndpoints.baseUAS}/static/img/${item.gambar}',
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     print('Error loading image: $error');
//                                     return const Icon(Icons.error, size: 50);
//                                   },
//                                 ),
//                               ),
//                             )
//                           : Container(
//                               height: 200,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                     color: Colors.black26,
//                                     blurRadius: 10.0,
//                                     offset: Offset(0, 5),
//                                   ),
//                                 ],
//                               ),
//                               child: const Center(
//                                 child: Icon(Icons.image,
//                                     size: 50, color: Colors.white),
//                               ),
//                             ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15.0),
//                           ),
//                           elevation: 5.0,
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Expanded(
//                                       child: Text(
//                                         item.nama_barang,
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 24,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                     BlocBuilder<AuthCubit, AuthState>(
//                                         builder: (context, state) {
//                                       final role = state.role;
//                                       debugPrint(role);
//                                       if (role == 'admin') {
//                                         return Row(
//                                           children: [
//                                             IconButton(
//                                               icon: const Icon(Icons.edit,
//                                                   color: Colors.blue),
//                                               onPressed: () {
//                                                 Navigator.push(
//                                                   context,
//                                                   BottomUpRoute(
//                                                     page: updateBarang(
//                                                         barang: item),
//                                                   ),
//                                                 ).then((_) => refresh());
//                                               },
//                                             ),
//                                             IconButton(
//                                               icon: const Icon(Icons.delete,
//                                                   color: Colors.red),
//                                               onPressed: () {
//                                                 _deleteBarang(item.id_barang);
//                                               },
//                                             ),
//                                           ],
//                                         );
//                                       } else {
//                                         return Container();
//                                       }
//                                     })
//                                   ],
//                                 ),
//                                 const SizedBox(height: 8.0),
//                                 Text(
//                                   item.jumlah.toString(),
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 16,
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                                 Text(
//                                   item.deskripsi,
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 16,
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
