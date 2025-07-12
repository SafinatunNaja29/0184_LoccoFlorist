import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loccoproject/presentation/auth/bloc/produk/produk_bloc.dart';
import 'package:loccoproject/presentation/produk/produk_detail_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final storage = const FlutterSecureStorage();
  int _selectedIndex = 0;
  String namaUser = "";
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadUserName();
    context.read<ProdukBloc>().add(GetAllProduk());
  }

  Future<void> _loadUserName() async {
    final name = await storage.read(key: "userName");
    setState(() {
      namaUser = name ?? "Customer";
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Beranda")),
      body: _selectedIndex == 0 ? _buildDashboard() : _buildProfile(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Selamat datang, $namaUser!',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari produk...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase();
              });
            },
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: BlocBuilder<ProdukBloc, ProdukState>(
            builder: (context, state) {
              if (state is ProdukLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProdukLoaded) {
                final produkList = state.products.where((produk) {
                  return produk.namaProduk!.toLowerCase().contains(searchQuery);
                }).toList();

                if (produkList.isEmpty) {
                  return const Center(child: Text("Produk tidak ditemukan."));
                }

                return ListView.builder(
                  itemCount: produkList.length,
                  itemBuilder: (context, index) {
                    final produk = produkList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: produk.gambarProduk != null
                            ? Image.network(produk.gambarProduk!, width: 50, fit: BoxFit.cover)
                            : const Icon(Icons.image_not_supported),
                        title: Text(produk.namaProduk ?? '-'),
                        subtitle: Text('Rp ${produk.hargaProduk ?? 0}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProdukDetailScreen(produk: produk),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              } else if (state is ProdukFailure) {
                return Center(child: Text("Gagal memuat produk: ${state.error}"));
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProfile() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profil Customer',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text('Nama: $namaUser'),
          const SizedBox(height: 8),
          FutureBuilder(
            future: storage.read(key: 'userEmail'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return Text('Email: ${snapshot.data ?? "-"}');
            },
          ),
          const Spacer(),
          Center(
            child: ElevatedButton.icon(
              onPressed: () async {
                await storage.deleteAll();
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
