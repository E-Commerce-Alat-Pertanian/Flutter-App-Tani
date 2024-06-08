import 'package:app_tani_sejahtera/models/produk_model.dart';
import 'package:app_tani_sejahtera/models/stok_model.dart';

class KeranjangModel {
  final int? id;
  final ProdukModel produk;
  final StokModel stok;
  int quantity;

  KeranjangModel({
    this.id,
    required this.produk,
    required this.stok,
    this.quantity = 1,
  });

  factory KeranjangModel.fromJson(Map<String, dynamic> json) {
    return KeranjangModel(
      id: json["idCart"] ?? 0,
      produk: ProdukModel.fromJson(json["product"]),
      stok: StokModel.fromJson(json["stok"]),
      quantity: json["quantity"] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idProduct": produk.id,
      "idStok": stok.id,
      "quantity": quantity,
    };
  }
}
