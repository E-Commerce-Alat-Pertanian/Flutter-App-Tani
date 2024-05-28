import 'dart:convert';
import 'dart:developer';

import 'package:app_tani_sejahtera/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/kecamatan_model.dart';
import '../models/provinsi_model.dart';
import '../models/user_model.dart';

class UserViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/user";
  UserModel? _currentUser;
  String? _token;

  UserModel? get currentUser => _currentUser;
  String? get token => _token;

  set token(String? newToken) => _setToken(newToken);

  Future<String> register(UserModel user) async {
    String error = "Terjadi kesalahan, silahkan coba lagi";

    try {
      final response = await http.post(
        Uri.parse("$_endpoint/register"),
        headers: {
          "Content-Type": "application/json",
        },
        body: user.toJson(),
      );
      log("Register user response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"];
        _currentUser = UserModel.fromJson(data["user"]);
        token = data["token"];
        error = "";
        notifyListeners();
      } else {
        error = jsonDecode(response.body)["msg"];
      }
    } catch (e) {
      log("Error during register: $e");
      error = "Terjadi kesalahan, silahkan coba lagi";
    }

    return error;
  }

  Future<String> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$_endpoint/login-customer"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
      log("Login user:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = data["data"]["user"];
        final accessToken = data["data"]["accessToken"];

        _currentUser = UserModel.fromJson(user);
        await _setToken(accessToken);

        // Panggil getProfile setelah token diperbarui
        await getProfile();

        notifyListeners();

        return "";
      } else {
        return jsonDecode(response.body)["message"];
      }
    } catch (e) {
      log("Error during login: $e");
      return "Terjadi kesalahan, silakan coba lagi";
    }
  }

  Future<void> getProfile() async {
    try {
      final response = await http.get(
        Uri.parse("$_endpoint/profile"),
        headers: {
          "Authorization": "Bearer $_token",
        },
      );
      log("Get profil:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"];
        _currentUser = UserModel.fromJson(data);
        notifyListeners();
      } else {
        final errorMessage = jsonDecode(response.body)["message"];
        log("Error while getting profile: $errorMessage");
      }
    } catch (e) {
      log("Error during profile retrieval: $e");
    }
  }

  Future<String> updateUsername(String username, email) async {
    String error = "Terjadi kesalahan, silahkan coba lagi";

    try {
      final response = await http.put(
        Uri.parse("$_endpoint/update-profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token",
        },
        body: jsonEncode({"username": username, "email": email}),
      );
      log("Update username response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"];
        _currentUser = UserModel.fromJson(data);
        notifyListeners();
        return "";
      } else {
        error = jsonDecode(response.body)["message"];
      }
    } catch (e) {
      log("Error during update: $e");
    }

    return error;
  }

  Future<String> updateAddress(
      String noHp, String alamat, String idKecamatan) async {
    String error = "Terjadi kesalahan, silahkan coba lagi";

    try {
      final response = await http.put(
        Uri.parse("$_endpoint/update-addres"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token",
        },
        body: jsonEncode({
          "noHp": noHp,
          "alamat":
              alamat, // Pastikan alamat yang dikirim adalah alamat yang diperbarui
          "idKecamatan": idKecamatan,
        }),
      );
      log("Update address response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"];
        _currentUser =
            UserModel.fromJson(data); // Perbarui data pengguna dengan yang baru
        notifyListeners();
        return "";
      } else {
        error = jsonDecode(response.body)["message"];
      }
    } catch (e) {
      log("Error during update: $e");
    }

    return error;
  }

  Future<void> _setToken(String? token) async {
    AppConstants.token = token;
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    if (token == null) {
      prefs.remove("TOKEN");
    } else {
      prefs.setString("TOKEN", token);
      log("Token disimpan: $token");
    }
    notifyListeners();
  }

  Future<bool> logout() async {
    try {
      final response = await http.get(
        Uri.parse("$_endpoint/logout-customer"),
        headers: {
          "Authorization": "Bearer $_token",
        },
      );
      log("Logout user response: ${response.body}");
      token = null;
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    token = null;
    return false;
  }

  // void _setToken(String? token) async {
  //   AppConstants.token = token;
  //   _token = token; // Tambahkan baris ini
  //   final prefs = await SharedPreferences.getInstance();
  //   if (token == null) {
  //     prefs.remove("TOKEN");
  //   } else {
  //     prefs.setString("TOKEN", token);
  //     log("Token disimpan: $token");
  //   }

  //   notifyListeners();
  // }
}
