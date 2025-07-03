import 'dart:convert';

class RegisterRequestModel {
  final String? namaUser;
  final String? email;
  final String? password;
  final int? idRole;

  RegisterRequestModel({
    this.namaUser,
    this.email,
    this.password,
    this.idRole,
  });

  factory RegisterRequestModel.fromJson(String str) =>
      RegisterRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromMap(Map<String, dynamic> json) =>
      RegisterRequestModel(
        namaUser: json["nama_user"],
        email: json["email"],
        password: json["password"],
        idRole: json["id_role"],
      );

  Map<String, dynamic> toMap() => {
        "nama_user": namaUser,
        "email": email,
        "password": password,
        "id_role": idRole,
      };
}
