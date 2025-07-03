import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dartz/dartz.dart';

import '../model/request/login_request_model.dart';
import '../model/request/register_request_model.dart';
import '../model/response/auth_response_model.dart';

class AuthRepository {
  final secureStorage = FlutterSecureStorage();
  final String _baseUrl = 'http://10.0.2.2:3000/api/auth'; // ganti jika real device

  Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel requestModel,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestModel.toJson(),
      );

      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final loginResponse = AuthResponseModel.fromMap(jsonResponse);

        // simpan token dan role
        await secureStorage.write(
          key: "authToken",
          value: loginResponse.user?.token,
        );
        await secureStorage.write(
          key: "userRole",
          value: loginResponse.user?.role,
        );

        log("Login sukses: ${loginResponse.message}");
        return Right(loginResponse);
      } else {
        log("Login gagal: ${jsonResponse['message']}");
        return Left(jsonResponse['message'] ?? "Login gagal");
      }
    } catch (e) {
      log("Error login: $e");
      return Left("Terjadi kesalahan saat login.");
    }
  }

  Future<Either<String, String>> register(
    RegisterRequestModel requestModel,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestModel.toJson(),
      );

      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 201) {
        final registerMessage = jsonResponse['message'] as String;
        log("Registrasi sukses: $registerMessage");
        return Right(registerMessage);
      } else {
        log("Registrasi gagal: ${jsonResponse['message']}");
        return Left(jsonResponse['message'] ?? "Registrasi gagal");
      }
    } catch (e) {
      log("Error register: $e");
      return Left("Terjadi kesalahan saat registrasi.");
    }
  }
}
