import 'package:app_tani_sejahtera/models/pembayaran_model.dart';
import '../constants.dart'; // Import AppConstants
import 'keranjang_model.dart';

class OrderModel {
  final int? id;
  final String status;
  final PembayaranModel metodeBayar;
  final int ongkir;
  final int totalPembayaran;
  final String? kodeUnik;
  final String? imageKurir;
  final String? imagePembayaran;
  final List<KeranjangModel>? keranjang;

  OrderModel({
    this.id,
    required this.status,
    required this.metodeBayar,
    required this.ongkir,
    required this.totalPembayaran,
    this.kodeUnik,
    this.imageKurir,
    this.imagePembayaran,
    this.keranjang,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    print('OrderModel.fromJson - JSON data: $json');

    // Deserialize metodeBayar
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

    // Deserialize keranjang
    final List<KeranjangModel> keranjang = [];
    if (json.containsKey('keranjangs') && json['keranjangs'] is List) {
      keranjang.addAll((json['keranjangs'] as List)
          .map((item) => KeranjangModel.fromJson(item as Map<String, dynamic>))
          .toList());
    }

    // Create full URLs for images
    final imageKurir = json['imageKurir'];
    final imagePembayaran = json['imagePembayaran'];

    return OrderModel(
      id: json["idOrder"],
      status: json["status"],
      metodeBayar: metodeBayar,
      ongkir: json['ongkir'],
      totalPembayaran: json['totalPembayaran'],
      kodeUnik: json['kodeUnik'],
      imageKurir: imageKurir != null && imageKurir.isNotEmpty
          ? "${AppConstants.baseUrl}/images/$imageKurir"
          : null,
      imagePembayaran: imagePembayaran != null && imagePembayaran.isNotEmpty
          ? "${AppConstants.baseUrl}/images/$imagePembayaran"
          : null,
      keranjang: keranjang.isNotEmpty ? keranjang : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "status": status,
      "metodeBayar": metodeBayar.text,
      "ongkir": ongkir,
      "totalPembayaran": totalPembayaran,
      "kodeUnik": kodeUnik,
      "imageKurir": imageKurir,
      "imagePembayaran": imagePembayaran,
      "keranjang": keranjang?.map((item) => item.toMap()).toList() ?? [],
    };
  }
}
