import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loccoproject/data/model/request/produk_request_model.dart';
import 'package:loccoproject/data/model/response/produk_response_model.dart';
import 'package:loccoproject/presentation/auth/bloc/produk/produk_bloc.dart';

class ProdukEditScreen extends StatefulWidget {
  final ProdukResponseModel produk;

  const ProdukEditScreen({super.key, required this.produk});

  @override
  State<ProdukEditScreen> createState() => _ProdukEditScreenState();
}

class _ProdukEditScreenState extends State<ProdukEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController namaController;
  late final TextEditingController deskripsiController;
  late final TextEditingController hargaController;
  late final TextEditingController stokController;
  late final TextEditingController gambarController;
  late final TextEditingController kategoriController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.produk.namaProduk);
    deskripsiController = TextEditingController(text: widget.produk.deskripsiProduk);
    hargaController = TextEditingController(text: widget.produk.hargaProduk?.toString());
    stokController = TextEditingController(text: widget.produk.stokProduk?.toString());
    gambarController = TextEditingController(text: widget.produk.gambarProduk);
    kategoriController = TextEditingController(text: widget.produk.idKategori?.toString());
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

  void _submitUpdate() {
    if (_formKey.currentState!.validate()) {
      final requestModel = ProdukRequestModel(
        namaProduk: namaController.text,
        deskripsiProduk: deskripsiController.text,
        hargaProduk: int.tryParse(hargaController.text),
        stokProduk: int.tryParse(stokController.text),
        gambarProduk: gambarController.text,
        idKategori: int.tryParse(kategoriController.text),
      );

      context.read<ProdukBloc>().add(UpdateProduk(
        id: widget.produk.idProduk!,
         produk: requestModel,
      ));

      Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Produk")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
                validator: (value) => value!.isEmpty ? 'Nama tidak boleh kosong' : null,
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
                decoration: const InputDecoration(labelText: 'URL Gambar'),
              ),
              TextFormField(
                controller: kategoriController,
                decoration: const InputDecoration(labelText: 'ID Kategori'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitUpdate,
                child: const Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}