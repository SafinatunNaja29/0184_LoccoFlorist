import 'dart:convert';
import 'package:loccoproject/data/model/produk_model.dart'; // pastikan path sesuai struktur project kamu

class ProdukResponseModel {
  final int? idProduk;
  final String? namaProduk;
  final String? deskripsiProduk;
  final int? hargaProduk;
  final int? stokProduk;
  final String? gambarProduk;
  final int? idKategori;
  final DateTime? produkCreatedAt;
  final DateTime? produkUpdatedAt;

  ProdukResponseModel({
    this.idProduk,
    this.namaProduk,
    this.deskripsiProduk,
    this.hargaProduk,
    this.stokProduk,
    this.gambarProduk,
    this.idKategori,
    this.produkCreatedAt,
    this.produkUpdatedAt,
  });

  factory ProdukResponseModel.fromJson(String str) =>
      ProdukResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProdukResponseModel.fromMap(Map<String, dynamic> json) =>
      ProdukResponseModel(
        idProduk: json["id_produk"],
        namaProduk: json["nama_produk"],
        deskripsiProduk: json["deskripsi_produk"],
        hargaProduk: json["harga_produk"],
        stokProduk: json["stok_produk"],
        gambarProduk: json["gambar_produk"],
        idKategori: json["id_kategori"],
        produkCreatedAt: json["produk_created_at"] != null
            ? DateTime.tryParse(json["produk_created_at"])
            : null,
        produkUpdatedAt: json["produk_updated_at"] != null
            ? DateTime.tryParse(json["produk_updated_at"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id_produk": idProduk,
        "nama_produk": namaProduk,
        "deskripsi_produk": deskripsiProduk,
        "harga_produk": hargaProduk,
        "stok_produk": stokProduk,
        "gambar_produk": gambarProduk,
        "id_kategori": idKategori,
        "produk_created_at": produkCreatedAt?.toIso8601String(),
        "produk_updated_at": produkUpdatedAt?.toIso8601String(),
      };

  factory ProdukResponseModel.fromProduk(Produk produk) {
    return ProdukResponseModel(
      idProduk: produk.idProduk,
      namaProduk: produk.namaProduk,
      deskripsiProduk: produk.deskripsiProduk,
      hargaProduk: produk.hargaProduk,
      stokProduk: produk.stokProduk,
      gambarProduk: produk.gambarProduk,
      idKategori: produk.idKategori,
      produkCreatedAt: produk.produkCreatedAt,
      produkUpdatedAt: produk.produkUpdatedAt,
    );
  }
}
