import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:loccoproject/data/model/request/produk_request_model.dart';
import 'package:loccoproject/data/model/response/produk_response_model.dart';
import 'package:loccoproject/service/service_http_client.dart';
import 'package:http/http.dart' as http;
import '../model/produk_model.dart';


class ProdukRepository {
  final ServiceHttpClient _serviceHttpClient;

  ProdukRepository(this._serviceHttpClient);

  Future<Either<String, List<Produk>>> getAllProduk() async {
    try {
      final response = await _serviceHttpClient.get("api/produk");

      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final produkList = (jsonResponse['data'] as List)
            .map((e) => Produk.fromMap(e))
            .toList();
        return Right(produkList);
      } else {
        return Left(jsonResponse['message'] ?? "Gagal mengambil data produk");
      }
    } catch (e) {
      log("Error getAllProduk: $e");
      return Left("Terjadi kesalahan saat mengambil data produk.");
    }
  }

  Future<Either<String, Produk>> getProdukById(int id) async {
    try {
      final response = await _serviceHttpClient.get("api/produk/$id");

      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final produk = Produk.fromMap(jsonResponse['data']);
        return Right(produk);
      } else {
        return Left(jsonResponse['message'] ?? "Gagal mengambil produk");
      }
    } catch (e) {
      log("Error getProdukById: $e");
      return Left("Terjadi kesalahan saat mengambil produk.");
    }
  }

  Future<Either<String, String>> createProduk(ProdukRequestModel request) async {
    try {
      final response =
          await _serviceHttpClient.postWithToken("api/produk", request.toMap());

      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        return Right(jsonResponse['message'] ?? "Produk berhasil ditambahkan");
      } else {
        return Left(jsonResponse['message'] ?? "Gagal menambahkan produk");
      }
    } catch (e) {
      log("Error createProduk: $e");
      return Left("Terjadi kesalahan saat menambahkan produk.");
    }
  }

  Future<Either<String, String>> updateProduk(
    int id,
    ProdukRequestModel request,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        "api/produk/$id",
        request.toMap(),
      );

      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return Right(jsonResponse['message'] ?? "Produk berhasil diupdate");
      } else {
        return Left(jsonResponse['message'] ?? "Gagal mengupdate produk");
      }
    } catch (e) {
      log("Error updateProduk: $e");
      return Left("Terjadi kesalahan saat mengupdate produk.");
    }
  }

  Future<Either<String, String>> deleteProduk(int id) async {
    try {
      final url = "api/produk/$id";
      final response = await _serviceHttpClient.delete(url);

      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return Right(jsonResponse['message'] ?? "Produk berhasil dihapus");
      } else {
        return Left(jsonResponse['message'] ?? "Gagal menghapus produk");
      }
    } catch (e) {
      log("Error deleteProduk: $e");
      return Left("Terjadi kesalahan saat menghapus produk.");
    }
  }
}
