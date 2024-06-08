import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/keranjang_model.dart';
import '../models/order_model.dart';

class OrderViewModel extends ChangeNotifier {
  final _endpoint = "${AppConstants.baseUrl}/order";
  List<OrderModel> _listOrder = [];
  ServerStatus _status = ServerStatus.normal;

  List<OrderModel> get listOrder => _listOrder;
  ServerStatus get status => _status;

  Future createOrder(
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
      return response.statusCode == 201;
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
}
