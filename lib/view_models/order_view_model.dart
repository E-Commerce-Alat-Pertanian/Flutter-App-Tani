import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:async/async.dart';

import '../constants.dart';
import '../models/keranjang_model.dart';
import '../models/order_model.dart';

class OrderViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/order";
  List<OrderModel> _listOrder = [];
  ServerStatus _status = ServerStatus.normal;

  List<OrderModel> get listOrder => _listOrder;
  ServerStatus get status => _status;

  Future<bool> createOrder(
      OrderModel order, List<KeranjangModel> listKeranjang) async {
    final mapKeranjang = listKeranjang.map((e) => e.toMap()).toList();
    final token = AppConstants.token;

    try {
      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "order": order.toMap(),
          "keranjang": mapKeranjang,
        }),
      );
      log("Create order:\n${response.body}");

      if (response.statusCode == 201) {
        // Fetch orders again to update the list
        await getOrder();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<void> getOrder() async {
    _status = ServerStatus.loading;
    notifyListeners();

    final token = AppConstants.token;

    try {
      final response = await http.get(
        Uri.parse(_endpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      log("Get order:\n${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final data = responseBody['data'] as List;
        _listOrder = data
            .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
            .toList();
        _status = ServerStatus.normal;
      } else {
        log("Failed to fetch orders: ${response.statusCode}");
        _listOrder = [];
        _status = ServerStatus.error;
      }
    } catch (e) {
      log(e.toString());
      _listOrder = [];
      _status = ServerStatus.error;
    }
    notifyListeners();
  }

  Future<bool> uploadImagePembayaran(File image, int idOrder) async {
    final token = AppConstants.token;
    final uri = Uri.parse("$_endpoint/$idOrder");

    try {
      var request = http.MultipartRequest('PATCH', uri)
        ..headers.addAll({
          "Authorization": "Bearer $token",
        })
        ..files.add(await http.MultipartFile.fromPath('file', image.path));

      var response = await request.send();

      if (response.statusCode == 201) {
        return true;
      } else {
        log("Failed to upload image: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
