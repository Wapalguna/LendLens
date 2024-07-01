// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lens_lend/Component/bottom_up_transition.dart';
// import 'package:lens_lend/cubit/cubit/auth_cubit.dart';
// import 'package:lens_lend/dto/barang.dart';
// import 'package:lens_lend/screens/create_screen.dart';
// import 'package:lens_lend/screens/detailBarang.dart';
// import 'package:lens_lend/services/data_services.dart';

// class BarangScreen extends StatefulWidget {
//   final int id_kategori;
//   final String namaKategori;

//   const BarangScreen(
//       {super.key, required this.id_kategori, required this.namaKategori});

//   @override
//   _BarangScreenState createState() => _BarangScreenState();
// }

// class _BarangScreenState extends State<BarangScreen> {
//   List<Barang> _barangList = [];
//   int _currentPage = 1;
//   bool _hasMore = true;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchBarang();
//   }

//   Future<void> _fetchBarang() async {
//     if (_isLoading || !_hasMore) return;

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final newBarangList = await DataService.fetchBarangByCategory(widget.id_kategori, page: _currentPage);
//       setState(() {
//         _currentPage++;
//         _barangList.addAll(newBarangList);
//         _hasMore = newBarangList.length == 6; // Assuming 6 is the perPage value
//       });
//     } catch (e) {
//       debugPrint('Error fetching barang: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.namaKategori,
//           style: GoogleFonts.poppins(
//             color: Colors.white,
//             fontSize: 30,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 30, 129, 209),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Stack(
//         children: [
//           NotificationListener<ScrollNotification>(
//             onNotification: (ScrollNotification scrollInfo) {
//               if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && _hasMore) {
//                 _fetchBarang();
//               }
//               return false;
//             },
//             child: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10.0,
//                 mainAxisSpacing: 10.0,
//                 childAspectRatio: 0.7,
//               ),
//               itemCount: _barangList.length,
//               itemBuilder: (context, index) {
//                 final barang = _barangList[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => BarangDetailScreen(barang: barang),
//                       ),
//                     );
//                   },
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     elevation: 5,
//                     margin: const EdgeInsets.all(10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(15),
//                             topRight: Radius.circular(15),
//                           ),
//                           child: Image.network(
//                             barang.gambar,
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                             height: 120,
//                             errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 barang.nama_barang,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(height: 5),
//                               Container(
//                                 color: Colors.blue.withOpacity(0.1),
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 5,
//                                   horizontal: 8,
//                                 ),
//                                 child: Text(
//                                   barang.deskripsi,
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           if (_isLoading)
//             const Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           BlocBuilder<AuthCubit, AuthState>(
//             builder: (context, state) {
//               final role = state.role;
//               if (role == 'admin') {
//                 return Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Padding(
//                     padding: const EdgeInsets.only(bottom: 20.0),
//                     child: FloatingActionButton(
//                       backgroundColor: const Color.fromARGB(255, 54, 40, 176),
//                       tooltip: 'Add Item',
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           BottomUpRoute(
//                             page: AddContainer(id_kategori: widget.id_kategori),
//                           ),
//                         );
//                       },
//                       child: const Icon(Icons.add, color: Colors.white, size: 28),
//                     ),
//                   ),
//                 );
//               }
//               return Container(); // Return an empty container if the user is not an admin
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }


// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lens_lend/Component/bottom_up_transition.dart';
import 'package:lens_lend/cubit/cubit/auth_cubit.dart';
import 'package:lens_lend/dto/barang.dart';
import 'package:lens_lend/screens/create_screen.dart';
import 'package:lens_lend/screens/detailBarang.dart';
import 'package:lens_lend/services/data_services.dart';

class BarangScreen extends StatefulWidget {
  final int id_kategori;
  final String namaKategori;

  const BarangScreen({super.key, required this.id_kategori, required this.namaKategori});

  @override
  _BarangScreenState createState() => _BarangScreenState();
}

class _BarangScreenState extends State<BarangScreen> {
  late Future<List<Barang>> futureBarang;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    futureBarang = DataService.fetchBarangByCategory(widget.id_kategori, currentPage);
  }

  void _fetchPage(int page) {
    setState(() {
      currentPage = page;
      futureBarang = DataService.fetchBarangByCategory(widget.id_kategori, currentPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.namaKategori,
          style: GoogleFonts.roboto(
            color: Colors.black87,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 135, 185, 210),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: FutureBuilder<List<Barang>>(
        future: futureBarang,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final barangList = snapshot.data!;
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: barangList.length,
                    itemBuilder: (context, index) {
                      final barang = barangList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BarangDetailScreen(barang: barang),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  child: Image.network(
                                    barang.gambar,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      barang.nama_barang,
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      barang.deskripsi,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final role = state.role;
                    if (role == 'admin') {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 70.0),
                          child: FloatingActionButton(
                            backgroundColor: Colors.indigo,
                            tooltip: 'Tambah Barang',
                            onPressed: () {
                              Navigator.push(
                                context,
                                BottomUpRoute(
                                  page: AddContainer(id_kategori: widget.id_kategori),
                                ),
                              );
                            },
                            child: const Icon(Icons.add, color: Colors.white, size: 28),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: currentPage > 1 ? () => _fetchPage(currentPage - 1) : null,
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () => _fetchPage(currentPage + 1),
                            icon: const Icon(Icons.arrow_forward, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
