import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lens_lend/dto/barang.dart';
import 'dart:convert';

import 'package:lens_lend/endpoints/endpoints_lens.dart';
import 'package:lens_lend/screens/detailBarang.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({ super.key});
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Barang> _searchResults = [];
  bool _isLoading = false;

  Future<void> _search(String keyword) async {
    setState(() {
      _isLoading = true;
    });

    String url =
        '${LensEndpoints.barang}/search?keyword=$keyword'; // Ganti dengan URL API Anda
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _searchResults = (data['datas'] as List)
            .map((json) =>Barang.fromJson(json))
            .toList();
      });
    } else {
      // Handle error response
      debugPrint('Error searching: ${response.statusCode}');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final imageurl = '${Endpoints.baseUrl}/static/${widget.wisata.gambar}';
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search......',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    setState(() {
                      _searchResults = [];
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.teal),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: (value) {
                _search(value);
              },
            ),
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: _searchResults.isEmpty
                      ? const Center(
                          child: Text(
                            'No results found',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            var barang = _searchResults[index];
                            return Card(
                              margin: const EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    barang.gambar,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                title: Text(
                                  barang.nama_barang,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                subtitle: Text(
                                  barang.deskripsi,
                                  maxLines: 2, // Batasi deskripsi hingga dua baris
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                           BarangDetailScreen(barang: barang),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
        ],
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}