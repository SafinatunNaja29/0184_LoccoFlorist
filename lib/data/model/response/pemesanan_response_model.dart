class PemesananResponseModel {
  final int? idPemesanan;
  final int? idProduk;
  final int? idUser;
  final String? statusPemesanan;
  final int? totalHarga;
  final String? lokasiPengantaran;
  final String? buktiFoto;
  final String? pemesananCreatedAt;
  final String? pemesananUpdatedAt;
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
    this.produk,
    this.user,
  });

  factory PemesananResponseModel.fromJson(Map<String, dynamic> json) {
    return PemesananResponseModel(
      idPemesanan: json['id_pemesanan'],
      idProduk: json['id_produk'],
      idUser: json['id_user'],
      statusPemesanan: json['status_pemesanan'],
      totalHarga: json['total_harga'],
      lokasiPengantaran: json['lokasi_pengantaran'],
      buktiFoto: json['bukti_foto'],
      pemesananCreatedAt: json['pemesanan_created_at'],
      pemesananUpdatedAt: json['pemesanan_updated_at'],
      produk: json['produk'] != null ? Produk.fromJson(json['produk']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
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

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      idProduk: json['id_produk'],
      namaProduk: json['nama_produk'],
      deskripsiProduk: json['deskripsi_produk'],
      hargaProduk: json['harga_produk'],
      stokProduk: json['stok_produk'],
      gambarProduk: json['gambar_produk'],
      idKategori: json['id_kategori'],
    );
  }
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['id_user'],
      nama: json['nama'],
      email: json['email'],
    );
  }
}
