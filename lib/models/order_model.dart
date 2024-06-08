import 'package:app_tani_sejahtera/models/pembayaran_model.dart';
import 'keranjang_model.dart';

class OrderModel {
  final int? id;
  final String status;
  final PembayaranModel metodeBayar;
  final int ongkir;
  final int totalPembayaran;
  final List<KeranjangModel>? keranjang;

  OrderModel({
    this.id,
    required this.status,
    required this.metodeBayar,
    required this.ongkir,
    required this.totalPembayaran,
    this.keranjang,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    // Log JSON data to understand the issue
    print('OrderModel.fromJson - JSON data: $json');

    // Ensure that metodeBayar is correctly deserialized
    final metodeBayarData = json['metodeBayar'];
    PembayaranModel metodeBayar;

    if (metodeBayarData is String) {
      metodeBayar = PembayaranModel(
        gambar: '',
        text: metodeBayarData,
      );
    } else if (metodeBayarData is Map<String, dynamic>) {
      metodeBayar = PembayaranModel.fromJson(metodeBayarData);
    } else {
      throw Exception("Format metodeBayar tidak valid");
    }

    // Deserialize the keranjang list
    final List<KeranjangModel> keranjang = [];
    if (json.containsKey('keranjangs') && json['keranjangs'] is List) {
      keranjang.addAll((json['keranjangs'] as List)
          .map((item) => KeranjangModel.fromJson(item as Map<String, dynamic>))
          .toList());
    }

    return OrderModel(
      id: json["idOrder"],
      status: json["status"],
      metodeBayar: metodeBayar,
      ongkir: json['ongkir'],
      totalPembayaran: json['totalPembayaran'],
      keranjang: keranjang.isNotEmpty ? keranjang : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "status": status,
      "metodeBayar": metodeBayar.text, // Ensure we get the text part for toMap
      "ongkir": ongkir,
      "totalPembayaran": totalPembayaran,
      "keranjang": keranjang?.map((item) => item.toMap()).toList() ?? [],
    };
  }
}
