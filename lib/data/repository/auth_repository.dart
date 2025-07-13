import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:loccoproject/service/service_http_client.dart';

import '../model/request/login_request_model.dart';
import '../model/request/register_request_model.dart';
import '../model/response/auth_response_model.dart';

class AuthRepository {
  final ServiceHttpClient _serviceHttpClient;
  final secureStorage = FlutterSecureStorage();

  AuthRepository(this._serviceHttpClient);

  Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.post(
        "api/auth/login",
        requestModel.toMap(),
      );

      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final loginResponse = AuthResponseModel.fromMap(jsonResponse);

        // ✅ Simpan data login ke storage
        await secureStorage.write(
          key: "authToken",
          value: loginResponse.user?.token,
        );
        await secureStorage.write(
          key: "userRole",
          value: loginResponse.user?.role,
        );
        await secureStorage.write(
          key: "userName",
          value: loginResponse.user?.namaUser,
        );
        await secureStorage.write(
          key: "userEmail",
          value: loginResponse.user?.email,
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
      final response = await _serviceHttpClient.post(
        "api/auth/register",
        requestModel.toMap(),
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
