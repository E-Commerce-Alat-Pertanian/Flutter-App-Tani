import 'dart:convert';

class UserModel {
  final int? id;
  final String username;
  final String email;
  final String noHp;
  final String alamat;
  final String idKecamatan; // Ubah dari String? menjadi String
  final String? password;

  UserModel({
    this.id,
    required this.username,
    required this.email,
    required this.noHp,
    required this.alamat,
    required this.idKecamatan,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      noHp: json["noHp"],
      alamat: json["alamat"],
      idKecamatan: json["idKecamatan"],
      password: json["password"],
    );
  }

  String toJson() {
    return jsonEncode({
      "username": username,
      "email": email,
      "noHp": noHp,
      "alamat": alamat,
      "idKecamatan": idKecamatan,
      "password": password,
    });
  }
}
