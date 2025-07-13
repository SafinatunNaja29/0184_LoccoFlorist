import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loccoproject/core/constants/colors.dart';
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

  void _showDeleteConfirmationDialog(int idProduk) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus produk ini?'),
        actions: [
          TextButton(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Ya, Hapus', style: TextStyle(color: Colors.red)),
            onPressed: () {
              context.read<ProdukBloc>().add(DeleteProduk(id: idProduk));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Builder(
          builder: (context) {
            final deviceWidth = MediaQuery.of(context).size.width;
            return Text(
              'Manajemen Produk',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: deviceWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: AppColors.tosca,
                letterSpacing: 1.2,
                fontFamily: 'Montserrat',
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.purple,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: state.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final produk = state.products[index];
                    final imageUrl = produk.gambarProduk != null &&
                            produk.gambarProduk!.isNotEmpty &&
                            produk.gambarProduk != "noimage.png"
                        ? 'http://localhost:5000/images/${produk.gambarProduk}'
                        : null;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProdukDetailScreen(produk: produk),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 2,
                              child: imageUrl != null
                                  ? Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      color: Colors.grey[300],
                                      child: const Center(
                                        child: Icon(Icons.image_not_supported, color: Colors.grey),
                                      ),
                                    ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      produk.namaProduk ?? '-',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text("Harga: Rp ${produk.hargaProduk}"),
                                    Text("Stok: ${produk.stokProduk}"),
                                    Text("Kategori: ${produk.namaKategori ?? '-'}"),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit, color: Colors.purple),
                                          onPressed: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    ProdukEditScreen(produk: produk),
                                              ),
                                            );
                                            _refreshProdukList();
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete, color: Colors.red),
                                          onPressed: () {
                                            _showDeleteConfirmationDialog(produk.idProduk!);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
