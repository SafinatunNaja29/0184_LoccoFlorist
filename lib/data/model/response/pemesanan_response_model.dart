import 'dart:convert';

class PemesananResponseModel {
  final int? idPemesanan;
  final int? idProduk;
  final int? idUser;
  final String? statusPemesanan;
  final int? totalHarga;
  final String? lokasiPengantaran;
  final String? buktiFoto;
  final DateTime? pemesananCreatedAt;
  final DateTime? pemesananUpdatedAt;
  final int? jumlahProduk;
  final Produk? produk;
  final User? user;

  PemesananResponseModel({
    this.idPemesanan,
    this.idProduk,
    this.idUser,
    this.statusPemesanan,
    this.totalHarga,
    this.lokasiPengantaran,
    this.buktiFoto,
    this.pemesananCreatedAt,
    this.pemesananUpdatedAt,
    this.jumlahProduk,
    this.produk,
    this.user,
  });

  factory PemesananResponseModel.fromJson(String str) =>
      PemesananResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PemesananResponseModel.fromMap(Map<String, dynamic> json) {
    return PemesananResponseModel(
      idPemesanan: json['id_pemesanan'],
      idProduk: json['id_produk'],
      idUser: json['id_user'],
      statusPemesanan: json['status_pemesanan'],
      totalHarga: json['total_harga'],
      lokasiPengantaran: json['lokasi_pengantaran'],
      buktiFoto: json['bukti_foto'],
      pemesananCreatedAt: json['pemesanan_created_at'] != null
          ? DateTime.tryParse(json['pemesanan_created_at'])
          : null,
      pemesananUpdatedAt: json['pemesanan_updated_at'] != null
          ? DateTime.tryParse(json['pemesanan_updated_at'])
          : null,
      jumlahProduk: json['jumlah_produk'],
      produk: json['produk'] != null ? Produk.fromMap(json['produk']) : null,
      user: json['user'] != null ? User.fromMap(json['user']) : null,
    );
  }

  Map<String, dynamic> toMap() => {
        "id_pemesanan": idPemesanan,
        "id_produk": idProduk,
        "id_user": idUser,
        "status_pemesanan": statusPemesanan,
        "total_harga": totalHarga,
        "lokasi_pengantaran": lokasiPengantaran,
        "bukti_foto": buktiFoto,
        "pemesanan_created_at": pemesananCreatedAt?.toIso8601String(),
        "pemesanan_updated_at": pemesananUpdatedAt?.toIso8601String(),
        "jumlah_produk": jumlahProduk,
        "produk": produk?.toMap(),
        "user": user?.toMap(),
      };
}

class Produk {
  final int? idProduk;
  final String? namaProduk;
  final String? deskripsiProduk;
  final int? hargaProduk;
  final int? stokProduk;
  final String? gambarProduk;
  final int? idKategori;

  Produk({
    this.idProduk,
    this.namaProduk,
    this.deskripsiProduk,
    this.hargaProduk,
    this.stokProduk,
    this.gambarProduk,
    this.idKategori,
  });

  factory Produk.fromMap(Map<String, dynamic> json) => Produk(
        idProduk: json['id_produk'],
        namaProduk: json['nama_produk'],
        deskripsiProduk: json['deskripsi_produk'],
        hargaProduk: json['harga_produk'],
        stokProduk: json['stok_produk'],
        gambarProduk: json['gambar_produk'],
        idKategori: json['id_kategori'],
      );

  Map<String, dynamic> toMap() => {
        "id_produk": idProduk,
        "nama_produk": namaProduk,
        "deskripsi_produk": deskripsiProduk,
        "harga_produk": hargaProduk,
        "stok_produk": stokProduk,
        "gambar_produk": gambarProduk,
        "id_kategori": idKategori,
      };
}

class User {
  final int? idUser;
  final String? nama;
  final String? email;

  User({
    this.idUser,
    this.nama,
    this.email,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        idUser: json['id_user'],
        nama: json['nama'],
        email: json['email'],
      );

  Map<String, dynamic> toMap() => {
        "id_user": idUser,
        "nama": nama,
        "email": email,
      };
}
