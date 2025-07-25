class Produk {
  final int idProduk;
  final String namaProduk;
  final String deskripsiProduk;
  final int hargaProduk;
  final int stokProduk;
  final String gambarProduk;
  final int idKategori;
  final String? namaKategori; 
  final DateTime produkCreatedAt;
  final DateTime produkUpdatedAt;

  Produk({
    required this.idProduk,
    required this.namaProduk,
    required this.deskripsiProduk,
    required this.hargaProduk,
    required this.stokProduk,
    required this.gambarProduk,
    required this.idKategori,
    this.namaKategori, 
    required this.produkCreatedAt,
    required this.produkUpdatedAt,
  });

  factory Produk.fromMap(Map<String, dynamic> map) {
    return Produk(
      idProduk: int.tryParse(map['id_produk'].toString()) ?? 0,
      namaProduk: map['nama_produk'],
      deskripsiProduk: map['deskripsi_produk'],
      hargaProduk: int.tryParse(map['harga_produk'].toString()) ?? 0,
      stokProduk: int.tryParse(map['stok_produk'].toString()) ?? 0,
      gambarProduk: map['gambar_produk'],
      idKategori: int.tryParse(map['id_kategori'].toString()) ?? 0,
      namaKategori: map['nama_kategori'], 
      produkCreatedAt: DateTime.parse(map['produk_created_at']),
      produkUpdatedAt: DateTime.parse(map['produk_updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_produk': idProduk,
      'nama_produk': namaProduk,
      'deskripsi_produk': deskripsiProduk,
      'harga_produk': hargaProduk,
      'stok_produk': stokProduk,
      'gambar_produk': gambarProduk,
      'id_kategori': idKategori,
      'nama_kategori': namaKategori, 
      'produk_created_at': produkCreatedAt.toIso8601String(),
      'produk_updated_at': produkUpdatedAt.toIso8601String(),
    };
  }
}
