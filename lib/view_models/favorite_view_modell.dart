import 'dart:convert';
import 'dart:developer';

import 'package:app_tani_sejahtera/models/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class FavoriteViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/favorite";
  List<FavoriteModel> _listFavorite = [];

  List<FavoriteModel> get listFavorite => _listFavorite;

  Future getFavorite() async {
    final token = AppConstants.token!;
    try {
      final response = await http.get(
        Uri.parse(_endpoint),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      log("Get favorite:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        _listFavorite = data.map((e) => FavoriteModel.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future createFavorite(String idProduct) async {
    final token = AppConstants.token!;
    try {
      log("Creating favorite for product ID: $idProduct"); // Tambahkan logging ini
      final response = await http.post(
        Uri.parse("$_endpoint/create-favorite"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"idProduct": idProduct}),
      );
      log("Create favorite:\n${response.body}");
      if (response.statusCode == 201) {
        // Check for 201 Created
        getFavorite();
        notifyListeners();
      } else {
        log("Failed to create favorite: ${response.body}");
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
