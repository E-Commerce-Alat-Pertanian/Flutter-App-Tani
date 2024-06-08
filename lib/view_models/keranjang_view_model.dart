import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/keranjang_model.dart';
import '../constants.dart';

class KeranjangViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/keranjang";

  List<KeranjangModel> _listKeranjang = [];

  List<KeranjangModel> get listKeranjang => _listKeranjang;

  Future<void> getKeranjang() async {
    final token = AppConstants.token!;
    try {
      final response = await http.get(
        Uri.parse(_endpoint),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        _listKeranjang = data.map((e) => KeranjangModel.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future updateKeranjang({KeranjangModel? keranjang}) async {
    List mapKeranjang = _listKeranjang.map((e) => e.toMap()).toList();
    if (keranjang != null) mapKeranjang = [keranjang.toMap()];
    final token = AppConstants.token!;

    try {
      final response = await http.put(
        Uri.parse(_endpoint),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(mapKeranjang),
      );
      log("Update keranjang:\n${response.body}");
      if (response.statusCode != 200) {
        final message = jsonDecode(response.body)["message"];
        log(message);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> deleteKeranjang({required int idCart}) async {
    final token = AppConstants.token!;
    try {
      final response = await http.delete(
        Uri.parse("$_endpoint/$idCart"),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        _listKeranjang.removeWhere((keranjang) => keranjang.id == idCart);
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

  void removeKeranjangFromList(KeranjangModel keranjang) {
    _listKeranjang.remove(keranjang);
    notifyListeners();
  }
}
