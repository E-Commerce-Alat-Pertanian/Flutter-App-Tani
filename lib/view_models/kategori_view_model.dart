import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/kategori_model.dart';

class KategoriViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/kategori";

  List<KategoriModel> _listKategori = [];
  List<KategoriModel> get listKategori => _listKategori;

  Future getKategori() async {
    try {
      final response = await http.get(Uri.parse(_endpoint));
      log("Get kategori:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        _listKategori = data.map((e) => KategoriModel.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
