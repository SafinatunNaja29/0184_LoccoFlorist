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

  
}
