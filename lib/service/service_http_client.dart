import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ServiceHttpClient {
  late final String baseUrl;

  final secureStorage = FlutterSecureStorage();

  ServiceHttpClient() {
    if (kIsWeb) {
      baseUrl = 'http://localhost:3000/';
      print('[DEBUG] Running on Web. baseUrl: $baseUrl');
    } else {
      baseUrl = 'http://10.0.2.2:3000/';
      print('[DEBUG] Running on Android. baseUrl: $baseUrl');
    }
  }

  Future<http.Response> post(String endPoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$endPoint");

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception("POST request failed: $e");
    }
  }

  /// GET dengan token
  Future<http.Response> get(String endPoint) async {
    final token = await secureStorage.read(key: "authToken");
    final url = Uri.parse("$baseUrl$endPoint");

    try {
      final response = await http.get(
        url,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      return response;
    } catch (e) {
      throw Exception("GET request failed: $e");
    }
  }

  /// POST dengan token
  Future<http.Response> postWithToken(
    String endPoint,
    Map<String, dynamic> body,
  ) async {
    final token = await secureStorage.read(key: "authToken");
    final url = Uri.parse("$baseUrl$endPoint");

    try {
      final response = await http.post(
        url,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      return response;
    } catch (e) {
      throw Exception("POST with token request failed: $e");
    }
  }
}
