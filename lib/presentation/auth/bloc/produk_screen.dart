import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loccoproject/presentation/auth/bloc/produk/produk_bloc.dart';
import 'package:loccoproject/presentation/produk/produk_create_screen.dart';
import 'package:loccoproject/presentation/produk/produk_detail_screen.dart';
import 'package:loccoproject/presentation/produk/produk_edit_screen.dart';

class ProdukScreen extends StatefulWidget {
  const ProdukScreen({super.key});

  @override
  _ProdukScreenState createState() => _ProdukScreenState();
}

class _ProdukScreenState extends State<ProdukScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProdukBloc>().add(GetAllProduk());
  }

  Future<void> _refreshProdukList() async {
    context.read<ProdukBloc>().add(GetAllProduk());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manajemen Produk"),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: "Kelola Kategori",
            onPressed: () {
              Navigator.pushNamed(context, "/kategori");
            },
          ),
        ],
      ),
      body: BlocBuilder<ProdukBloc, ProdukState>(
        builder: (context, state) {
          if (state is ProdukLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProdukLoaded) {
            if (state.products.isEmpty) {
              return const Center(child: Text("Tidak ada produk tersedia."));
            }
            return RefreshIndicator(
              onRefresh: _refreshProdukList,
              child: ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final produk = state.products[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(produk.namaProduk ?? '-'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Harga: Rp ${produk.hargaProduk}"),
                          Text("Stok: ${produk.stokProduk}"),
                          Text("Kategori ID: ${produk.idKategori}"),
                        ],
                      ),
                      isThreeLine: true,
                      trailing: Wrap(
                        spacing: 8,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProdukEditScreen(produk: produk),
                                ),
                              );
                              _refreshProdukList();
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              context.read<ProdukBloc>().add(DeleteProduk(id: produk.idProduk!));
                            },
                          ),
                        ],
                      ),
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
              ),
            );
          } else if (state is ProdukFailure) {
            return Center(child: Text("Gagal memuat produk: ${state.error}"));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProdukCreateScreen()),
          );
          if (result == true) {
            _refreshProdukList();
          }
        },
        child: const Icon(Icons.add),
        tooltip: 'Tambah Produk',
      ),
    );
  }
}
