import 'dart:convert';

class ProdukRequestModel {
  final String? namaProduk;
  final String? deskripsiProduk;
  final int? hargaProduk;
  final int? stokProduk;
  final String? gambarProduk;
  final int? idKategori;

  ProdukRequestModel({
    this.namaProduk,
    this.deskripsiProduk,
    this.hargaProduk,
    this.stokProduk,
    this.gambarProduk,
    this.idKategori,
  });

  factory ProdukRequestModel.fromJson(String str) =>
      ProdukRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProdukRequestModel.fromMap(Map<String, dynamic> json) =>
      ProdukRequestModel(
        namaProduk: json["nama_produk"],
        deskripsiProduk: json["deskripsi_produk"],
        hargaProduk: json["harga_produk"],
        stokProduk: json["stok_produk"],
        gambarProduk: json["gambar_produk"],
        idKategori: json["id_kategori"],
      );

  Map<String, dynamic> toMap() => {
        "nama_produk": namaProduk,
        "deskripsi_produk": deskripsiProduk,
        "harga_produk": hargaProduk,
        "stok_produk": stokProduk,
        "gambar_produk": gambarProduk,
        "id_kategori": idKategori,
      };
}
