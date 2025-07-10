import 'package:flutter/material.dart';
import 'package:loccoproject/data/model/response/produk_response_model.dart';

class ProdukDetailScreen extends StatelessWidget {
  final ProdukResponseModel produk;

  const ProdukDetailScreen({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Produk")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (produk.gambarProduk != null)
              Image.network(
                produk.gambarProduk!,
                height: 200,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),
            Text("Nama: ${produk.namaProduk ?? '-'}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Deskripsi: ${produk.deskripsiProduk ?? '-'}"),
            const SizedBox(height: 8),
            Text("Harga: Rp ${produk.hargaProduk ?? 0}"),
            const SizedBox(height: 8),
            Text("Stok: ${produk.stokProduk ?? 0}"),
            const SizedBox(height: 8),
            Text("Kategori ID: ${produk.idKategori ?? '-'}"),
            const SizedBox(height: 8),
            Text("Dibuat pada: ${produk.produkCreatedAt ?? '-'}"),
            const SizedBox(height: 8),
            Text("Diupdate pada: ${produk.produkUpdatedAt ?? '-'}"),
          ],
        ),
      ),
    );
  }
}
