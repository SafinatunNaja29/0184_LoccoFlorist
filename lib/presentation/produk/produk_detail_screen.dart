import 'package:flutter/material.dart';
import 'package:loccoproject/data/model/response/produk_response_model.dart';

class ProdukDetailScreen extends StatelessWidget {
  final ProdukResponseModel produk;
  final bool isAdmin;

  const ProdukDetailScreen({
    super.key,
    required this.produk,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Produk")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (produk.gambarProduk != null && produk.gambarProduk!.isNotEmpty)
              Image.network(
                produk.gambarProduk!,
                height: 200,
                fit: BoxFit.cover,
              )
            else
              Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(child: Text('Tidak ada gambar')),
              ),
            const SizedBox(height: 16),
            Text(
              "Nama: ${produk.namaProduk ?? '-'}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Deskripsi: ${produk.deskripsiProduk ?? '-'}"),
            const SizedBox(height: 8),
            Text("Harga: Rp ${produk.hargaProduk ?? 0}"),
            const SizedBox(height: 8),
            Text("Stok: ${produk.stokProduk ?? 0}"),
            const SizedBox(height: 8),
            Text("Kategori ID: ${produk.idKategori ?? '-'}"),

            if (isAdmin) ...[
              const SizedBox(height: 8),
              Text("Dibuat pada: ${produk.produkCreatedAt ?? '-'}"),
              const SizedBox(height: 8),
              Text("Diupdate pada: ${produk.produkUpdatedAt ?? '-'}"),
            ],
          ],
        ),
      ),
    );
  }
}
