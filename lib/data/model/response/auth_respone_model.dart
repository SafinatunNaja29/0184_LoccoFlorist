import 'dart:convert';

class AuthResponseModel {
  final String? message;
  final User? user;

  AuthResponseModel({
    this.message,
    this.user,
  });

  factory AuthResponseModel.fromJson(String str) =>
      AuthResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthResponseModel(
        message: json["message"],
        user: json["data"] == null ? null : User.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": user?.toMap(),
      };
}

class User {
  final int? idUser;
  final String? namaUser;
  final String? email;
  final String? role;
  final String? token;

  User({
    this.idUser,
    this.namaUser,
    this.email,
    this.role,
    this.token,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        idUser: json["id_user"],
        namaUser: json["nama_user"],
        email: json["email"],
        role: json["role"],
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "id_user": idUser,
        "nama_user": namaUser,
        "email": email,
        "role": role,
        "token": token,
      };
}
