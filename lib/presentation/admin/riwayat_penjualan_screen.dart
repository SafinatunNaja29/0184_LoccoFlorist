import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loccoproject/presentation/auth/bloc/pemesanan/pemesanan_bloc.dart';

class RiwayatPenjualanScreen extends StatelessWidget {
  const RiwayatPenjualanScreen({super.key});

  String formatTanggal(DateTime? tanggal) {
    if (tanggal == null) return "-";
    return DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(tanggal);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PemesananBloc, PemesananState>(
      builder: (context, state) {
        if (state is PemesananLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PemesananLoaded) {

          final riwayatList = state.data
              .where((e) => e.statusPemesanan == "selesai")
              .toList();

          // Hitung total keuntungan
          final totalKeuntungan = riwayatList.fold<int>(
            0,
            (sum, item) => sum + (item.totalHarga ?? 0),
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total Keuntungan: Rp $totalKeuntungan',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: riwayatList.length,
                  itemBuilder: (context, index) {
                    final item = riwayatList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text("ID Pemesanan: ${item.idPemesanan}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nama Customer: ${item.user?.nama ?? '-'}"),
                            Text("Kategori Produk: ${item.produk?.idKategori ?? '-'}"),
                            Text("Jumlah Produk: ${item.jumlahProduk ?? '-'}"),
                            Text("Lokasi: ${item.lokasiPengantaran ?? '-'}"),
                            Text("Total Harga: Rp ${item.totalHarga ?? 0}"),
                            Text("Tanggal: ${formatTanggal(item.pemesananCreatedAt)}"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is PemesananError) {
          return Center(child: Text(state.error));
        } else {
          return const Center(child: Text("Tidak ada data riwayat."));
        }
      },
    );
  }
}
