import 'package:app_tani_sejahtera/models/produk_model.dart';

class FavoriteModel {
  final int? id;
  final ProdukModel produk;

  FavoriteModel({
    this.id,
    required this.produk,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json["idFavorite"],
      produk: ProdukModel.fromJson(json["product"]),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idProduk": produk.id,
    };
  }
}
