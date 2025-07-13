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
    print('Pemesanan JSON: $json');
    print('Produk JSON: ${json['produk']}');
    print('User JSON: ${json['user']}');

    return PemesananResponseModel(
      idPemesanan: int.tryParse(json['id_pemesanan'].toString()),
      idProduk: int.tryParse(json['id_produk'].toString()),
      idUser: int.tryParse(json['id_user'].toString()),
      statusPemesanan: json['status_pemesanan'],
      totalHarga: int.tryParse(json['total_harga'].toString()),
      lokasiPengantaran: json['lokasi_pengantaran'],
      buktiFoto: json['bukti_foto'],
      pemesananCreatedAt: json['pemesanan_created_at'] != null
          ? DateTime.tryParse(json['pemesanan_created_at'])
          : null,
      pemesananUpdatedAt: json['pemesanan_updated_at'] != null
          ? DateTime.tryParse(json['pemesanan_updated_at'])
          : null,
      jumlahProduk: int.tryParse(json['jumlah_produk'].toString()),
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

  factory Produk.fromMap(Map<String, dynamic> json) {
    print('Produk JSON: $json');
    return Produk(
      idProduk: int.tryParse(json['id_produk'].toString()),
      namaProduk: json['nama_produk'],
      deskripsiProduk: json['deskripsi_produk'],
      hargaProduk: int.tryParse(json['harga_produk'].toString()),
      stokProduk: int.tryParse(json['stok_produk'].toString()),
      gambarProduk: json['gambar_produk'],
      idKategori: int.tryParse(json['id_kategori'].toString()),
    );
  }

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

  factory User.fromMap(Map<String, dynamic> json) {
    print('User JSON: $json');
    return User(
      idUser: int.tryParse(json['id_user'].toString()),
      nama: json['nama_user'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toMap() => {
        "id_user": idUser,
        "nama_user": nama,
        "email": email,
      };
}
