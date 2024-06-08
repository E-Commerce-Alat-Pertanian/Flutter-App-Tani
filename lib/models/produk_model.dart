import '../constants.dart';

class ProdukModel {
  final int id;
  final String gambar;
  final String nama;
  final double price;
  final int idKategori;
  final String deskripsi;
  final int? userId; // Nullable userId
  int stok;

  ProdukModel({
    required this.id,
    required this.gambar,
    required this.nama,
    required this.price,
    required this.idKategori,
    required this.deskripsi,
    this.userId, // Nullable userId
    required this.stok,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    final gambar = json["image"];
    final stokList = json["stok"] as List?;
    final stok = stokList != null && stokList.isNotEmpty
        ? stokList[0]["stok"]
        : 0; // Assuming that each product has one stock entry

    return ProdukModel(
      id: json["idProduct"] ?? 0,
      gambar: "${AppConstants.baseUrl}/images/$gambar",
      nama: json["nama"] ?? "",
      price: (json["price"] ?? 0.0).toDouble(),
      idKategori: json["idCategory"] ?? 0,
      deskripsi: json["description"] ?? "",
      userId: json["userId"], // Nullable userId
      stok: stok ?? 0, // Ensure stok is not null
    );
  }
}
