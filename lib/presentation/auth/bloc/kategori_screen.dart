import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loccoproject/presentation/auth/bloc/kategori/kategori_bloc.dart';
import 'package:loccoproject/data/model/kategori_model.dart';

class KategoriScreen extends StatelessWidget {
  const KategoriScreen({super.key});

  void _showKategoriDialog(BuildContext context, {Kategori? kategori}) {
    final controller = TextEditingController(
      text: kategori != null ? kategori.namaKategori : '',
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(kategori == null ? 'Tambah Kategori' : 'Edit Kategori'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Nama kategori'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final nama = controller.text.trim();
              if (nama.isEmpty) return;

              if (kategori == null) {
                context.read<KategoriBloc>().add(CreateKategoriEvent(namaKategori: nama));
              } else {
                context.read<KategoriBloc>().add(UpdateKategoriEvent(
                      id: kategori.idKategori,
                      namaKategori: nama,
                    ));
              }
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, Kategori kategori) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: Text("Yakin ingin menghapus kategori '${kategori.namaKategori}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<KategoriBloc>().add(DeleteKategoriEvent(id: kategori.idKategori));
              Navigator.pop(context);
            },
            child: const Text("Hapus"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Produk'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showKategoriDialog(context),
            tooltip: 'Tambah Kategori',
          )
        ],
      ),
      body: BlocBuilder<KategoriBloc, KategoriState>(
        builder: (context, state) {
          if (state is KategoriLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is KategoriFailure) {
            return Center(child: Text("Gagal memuat: ${state.error}"));
          }

          if (state is KategoriLoaded) {
            if (state.listKategori.isEmpty) {
              return const Center(child: Text("Belum ada kategori."));
            }

            return ListView.builder(
              itemCount: state.listKategori.length,
              itemBuilder: (context, index) {
                final kategori = state.listKategori[index];
                return ListTile(
                  title: Text(kategori.namaKategori),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _showKategoriDialog(context, kategori: kategori);
                      } else if (value == 'delete') {
                        _confirmDelete(context, kategori);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Hapus'),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
