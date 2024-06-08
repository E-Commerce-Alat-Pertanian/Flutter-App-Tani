import 'dart:convert';
import 'dart:developer';

import 'package:app_tani_sejahtera/models/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

enum ServerStatus { normal, loading, error }

class FavoriteViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/favorite";
  List<FavoriteModel> _listFavorite = [];
  ServerStatus _status = ServerStatus.normal;

  List<FavoriteModel> get listFavorite => _listFavorite;
  ServerStatus get status => _status;

  Future<void> getFavorite() async {
    _status = ServerStatus.loading;
    notifyListeners();

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
        _status = ServerStatus.normal;
      } else {
        _status = ServerStatus.error;
      }
    } catch (e) {
      log(e.toString());
      _status = ServerStatus.error;
    }
    notifyListeners();
  }

  Future<int> createFavorite(String idProduct) async {
    final token = AppConstants.token!;
    try {
      log("Creating favorite for product ID: $idProduct");
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
        await getFavorite();
        return 201;
      } else if (response.statusCode == 400) {
        return 400;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      log(e.toString());
      return 500; // Return 500 for internal server error
    }
  }

  Future<bool> deleteFavorite({required int idFavorite}) async {
    final token = AppConstants.token!;
    try {
      final response = await http.delete(
        Uri.parse("$_endpoint/$idFavorite"),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        _listFavorite.removeWhere((favorite) => favorite.id == idFavorite);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  void removeFavoriteFromList(FavoriteModel favorite) {
    _listFavorite.remove(favorite);
    notifyListeners();
  }
}
