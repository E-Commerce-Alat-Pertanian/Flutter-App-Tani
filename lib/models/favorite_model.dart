import 'package:app_tani_sejahtera/models/produk_model.dart';

class FavoriteModel {
  final int? id;
  final ProdukModel? produk;

  FavoriteModel({
    this.id,
    this.produk,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    ProdukModel? produk;
    if (json.containsKey('product')) {
      produk = ProdukModel.fromJson(json['product']);
      // Tambahkan atribut stok ke dalam ProdukModel jika tersedia dalam JSON
      if (json.containsKey('stok')) {
        produk.stok = json['stok'];
      }
    }
    return FavoriteModel(
      id: json["idFavorite"] ?? 0,
      produk: produk,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idProduk": produk?.id,
    };
  }
}
