import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loccoproject/presentation/auth/bloc/pemesanan/pemesanan_bloc.dart';
import 'package:loccoproject/presentation/auth/bloc/produk_screen.dart';
import 'package:loccoproject/presentation/admin/riwayat_penjualan_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final storage = const FlutterSecureStorage();
  String namaUser = '';
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeDashboard(),
    ProdukScreen(),
    RiwayatPenjualanScreen(),
    Center(child: Text("Profil")),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserName();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeDialog();
      context.read<PemesananBloc>().add(GetAllPemesanan());
    });
  }

  Future<void> _loadUserName() async {
    final name = await storage.read(key: "userName");
    setState(() {
      namaUser = name ?? "Admin";
    });
  }

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Selamat Datang!'),
        content: Text('Halo, $namaUser!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
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
            icon: Icon(Icons.shopping_cart),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PemesananBloc, PemesananState>(
      builder: (context, state) {
        if (state is PemesananLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PemesananLoaded) {
          final dataMasuk = state.data
              .where((e) => e.statusPemesanan != "selesai")
              .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Selamat datang!\nTotal Pesanan Masuk: ${dataMasuk.length}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: dataMasuk.length,
                  itemBuilder: (context, index) {
                    final item = dataMasuk[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text("Customer: ${item.user?.nama ?? '-'}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Produk: ${item.produk?.namaProduk ?? '-'}"),
                            Text("Total: Rp ${item.totalHarga}"),
                            Text("Status: ${item.statusPemesanan}"),
                            Text("Lokasi: ${item.lokasiPengantaran}"),
                          ],
                        ),
                        trailing: DropdownButton<String>(
                          value: item.statusPemesanan,
                          items: const [
                            DropdownMenuItem(value: "booked", child: Text("Booked")),
                            DropdownMenuItem(value: "diterima", child: Text("Diterima")),
                            DropdownMenuItem(value: "selesai", child: Text("Selesai")),
                            DropdownMenuItem(value: "ditolak", child: Text("Ditolak")),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              if (value == "selesai" && item.buktiFoto == null) {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text("Konfirmasi"),
                                    content: const Text("Customer belum mengunggah foto bukti."),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("OK"),
                                      )
                                    ],
                                  ),
                                );
                                return;
                              }
                              context.read<PemesananBloc>().add(UpdateStatusPemesanan(
                                    id: item.idPemesanan!,
                                    status: value,
                                    buktiFoto: item.buktiFoto,
                                  ));
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is PemesananError) {
          return Center(child: Text("Gagal memuat pesanan: ${state.error}"));
        } else {
          return const Center(child: Text("Tidak ada data."));
        }
      },
    );
  }
}
