import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loccoproject/presentation/auth/bloc/produk_screen.dart';

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
    Center(child: Text("Riwayat")), 
    Center(child: Text("Profil")), 
  ];

  @override
  void initState() {
    super.initState();
    _loadUserName();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeDialog(); 
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
    return const Center(
      child: Text(
        'Dashboard Admin Utama',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
