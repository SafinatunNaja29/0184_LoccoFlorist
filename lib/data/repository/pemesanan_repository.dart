import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loccoproject/data/model/response/pemesanan_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PemesananRepository {
  final String baseUrl;
  final storage = const FlutterSecureStorage();

  PemesananRepository({required this.baseUrl});

  Future<String?> _getToken() async {
    return await storage.read(key: "authToken");
  }

  Future<List<PemesananResponseModel>> fetchAllPemesanan() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('${baseUrl}pemesanan'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => PemesananResponseModel.fromMap(json)).toList();
    } else {
      throw Exception("Gagal mengambil data pemesanan: ${response.body}");
    }
  }

  Future<List<PemesananResponseModel>> fetchRiwayatPemesananSelesai() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('${baseUrl}pemesanan/report'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      final List data = jsonMap['data'];
      return data.map((json) => PemesananResponseModel.fromMap(json)).toList();
    } else {
      throw Exception("Gagal mengambil data riwayat: ${response.body}");
    }
  }

  Future<void> updateStatus({
    required int idPemesanan,
    required String status,
    String? buktiFoto,
  }) async {
    final token = await _getToken();

    final response = await http.put(
      Uri.parse('${baseUrl}pemesanan/$idPemesanan'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        "status_pemesanan": status,
        if (buktiFoto != null) "bukti_foto": buktiFoto,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Gagal mengubah status pemesanan: ${response.body}");
    }
  }
}
