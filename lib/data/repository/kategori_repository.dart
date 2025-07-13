import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:loccoproject/data/model/kategori_model.dart';
import 'package:loccoproject/service/service_http_client.dart';

class KategoriRepository {
  final ServiceHttpClient _client;

  KategoriRepository(this._client);

  Future<Either<String, List<Kategori>>> getAllKategori() async {
    try {
      final response = await _client.get("api/kategori");
      final jsonResponse = json.decode(response.body);
      final kategoriList = (jsonResponse['data'] as List)
          .map((e) => Kategori.fromMap(e))
          .toList();
      return Right(kategoriList);
    } catch (e) {
      log("Error getAllKategori: $e");
      return Left("Gagal mengambil data kategori");
    }
  }

  Future<Either<String, String>> createKategori(String nama) async {
    try {
      final response = await _client.postWithToken("api/kategori", {
        "nama_kategori": nama,
      });
      final jsonResponse = json.decode(response.body);
      return Right(jsonResponse['message']);
    } catch (e) {
      log("Error createKategori: $e");
      return Left("Gagal menambah kategori");
    }
  }

  Future<Either<String, String>> deleteKategori(int id) async {
    try {
      final response = await _client.delete("api/kategori/$id");
      final jsonResponse = json.decode(response.body);
      return Right(jsonResponse['message']);
    } catch (e) {
      log("Error deleteKategori: $e");
      return Left("Gagal menghapus kategori");
    }
  }
}
