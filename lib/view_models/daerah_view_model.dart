import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/kecamatan_model.dart';
import '../models/provinsi_model.dart';

class DaerahViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/daerah";

  int? _ongkir;
  int? get ongkir => _ongkir;

  Future<List<ProvinsiModel>> getProvinsi() async {
    try {
      final response = await http.get(Uri.parse("$_endpoint/provinsi"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        return data.map((e) => ProvinsiModel.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<ProvinsiModel> getProvinsiById(int idProvinsi) async {
    try {
      final response =
          await http.get(Uri.parse("$_endpoint/provinsi-by-id/$idProvinsi"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"];
        return ProvinsiModel.fromJson(data);
      }
    } catch (e) {
      print(e);
    }
    throw Exception("Provinsi not found");
  }

  Future<List<KecamatanModel>> getKecamatan(String idProvinsi) async {
    try {
      final response =
          await http.get(Uri.parse("$_endpoint/kecamatan/$idProvinsi"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        return data.map((e) => KecamatanModel.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<KecamatanModel> getKecamatanById(String idKecamatan) async {
    try {
      print("ID Kecamatan: $idKecamatan"); // Debugging line
      final response =
          await http.get(Uri.parse("$_endpoint/kecamatan-by-id/$idKecamatan"));
      print("Response: ${response.body}"); // Debugging line
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"];
        return KecamatanModel.fromJson(data);
      }
    } catch (e) {
      print(e); // Debugging line
    }
    throw Exception("Kecamatan not found");
  }

  Future getOngkir() async {
    final token = AppConstants.token!;
    try {
      final response = await http.get(
        Uri.parse("$_endpoint/ongkir/jne"),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      log("Get ongkir:\n${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"];
        _ongkir = data["ongkir"];
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
