import 'package:flutter/material.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda Customer'),
      ),
      body: const Center(
        child: Text('Selamat datang, Customer!'),
      ),
    );
  }
}
