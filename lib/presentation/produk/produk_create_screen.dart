import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loccoproject/data/model/request/produk_request_model.dart';
import 'package:loccoproject/presentation/auth/bloc/produk/produk_bloc.dart';

class ProdukCreateScreen extends StatefulWidget {
  const ProdukCreateScreen({super.key});

  @override
  State<ProdukCreateScreen> createState() => _ProdukCreateScreenState();
}

class _ProdukCreateScreenState extends State<ProdukCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController stokController = TextEditingController();
  final TextEditingController gambarController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();

  void _submitProduk() {
    if (_formKey.currentState!.validate()) {
      final produkRequest = ProdukRequestModel(
        namaProduk: namaController.text,
        deskripsiProduk: deskripsiController.text,
        hargaProduk: int.tryParse(hargaController.text),
        stokProduk: int.tryParse(stokController.text),
        gambarProduk: gambarController.text.isEmpty
            ? "noimage.png"
            : gambarController.text,
        idKategori: int.tryParse(kategoriController.text),
      );

      context.read<ProdukBloc>().add(CreateProduk(produk: produkRequest));

      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    deskripsiController.dispose();
    hargaController.dispose();
    stokController.dispose();
    gambarController.dispose();
    kategoriController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Produk")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
                validator: (value) =>
                    value!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: deskripsiController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
              TextFormField(
                controller: hargaController,
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: stokController,
                decoration: const InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: gambarController,
                decoration:
                    const InputDecoration(labelText: 'URL Gambar (opsional)'),
              ),
              TextFormField(
                controller: kategoriController,
                decoration: const InputDecoration(labelText: 'ID Kategori'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitProduk,
                child: const Text('Simpan Produk'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
