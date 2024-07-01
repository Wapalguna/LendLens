import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lens_lend/components/buildList.dart';
import 'package:lens_lend/dto/kategori.dart';
import 'package:lens_lend/endpoints/endpoints_lens.dart';
import 'package:lens_lend/screens/about_us_screen.dart';
import 'package:lens_lend/screens/google_map.dart';
import 'package:lens_lend/screens/help_screen.dart';
import 'package:lens_lend/screens/kategori.dart';
import 'package:lens_lend/screens/peminjaman_screen.dart';
import 'package:lens_lend/screens/profile_screen.dart';
import 'package:lens_lend/screens/search.dart';
import 'package:lens_lend/screens/secure_storage_util.dart';
import 'package:lens_lend/services/data_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  bool isMenuOpen = false;
  Future<List<Kategori>>? _kategori;

  @override
  void initState() {
    super.initState();
    _kategori = DataService.fetchKategori();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LensLend'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Kategori>>(
        future: _kategori,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                final imageUrl =
                    '${LensEndpoints.baseUAS}/static/img/${item.gambar_kategori}';
                return ListItem(
                  title: item.nama_kategori,
                  subtitle: item.deskripsi,
                  icon: Icons.category,
                  imagePath: imageUrl.toString(),
                  page: BarangScreen(
                    id_kategori: item.id_kategori,
                    namaKategori: item.nama_kategori,
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/fotowahyu.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Wahyu Palguna',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ExpansionTile(
              leading: const Icon(Icons.home),
              title: const Text('Lend Lens'),
              children: [
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About Us'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutUsScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('Help'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpScreen()),
                    );
                  },
                ),
              ],
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                logoutData();
                Navigator.pop(context);
                Navigator.pushNamed(context, '/intro-screen');
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Google Map'),
              onTap: () {
                logoutData();
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const GoogleMapScreen(),));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavBarItem(Icons.home, "Home", const HomeScreen()),
              buildNavBarItem(
                  Icons.shopping_cart, "Peminjaman", const PeminjamanScreen()),
              buildNavBarItem(Icons.person, "Profile", const ProfileScreen()),
            ],
          ),
        ),
      ),
    );
  }

  static Future<http.Response> logoutData() async {
    final url = Uri.parse('https://api.example.com/logout');
    final String? accessToken =
        await SecureStorageUtil.storage.read(key: 'token');
    debugPrint("Logout with $accessToken");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return response;
  }

  Widget buildNavBarItem(IconData icon, String label, Widget page) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      tooltip: label,
      color: Colors.blue,
    );
  }
}
