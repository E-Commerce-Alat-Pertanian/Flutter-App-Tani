import '../constants.dart';

class ProdukModel {
  final int id; // Ubah tipe menjadi int
  final String gambar;
  final String nama;
  final double price; // Ubah tipe menjadi double
  final int stock; // Ubah tipe menjadi int
  final int idKategori;
  final String deskripsi;

  ProdukModel({
    required this.id,
    required this.gambar,
    required this.nama,
    required this.price,
    required this.stock,
    required this.idKategori,
    required this.deskripsi,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    final stok = json["stock"];
    final gambar = json["image"];

    return ProdukModel(
      id: json["id"] ?? 0, // Pastikan nilai numerik tidak null
      gambar: "${AppConstants.baseUrl}/images/$gambar",
      nama: json["nama"] ?? "",
      price: (json["price"] ?? 0.0)
          .toDouble(), // Pastikan nilai numerik tidak null
      idKategori: json["idCategory"] ?? 0, // Pastikan nilai numerik tidak null
      stock: stok ?? 0, // Pastikan nilai numerik tidak null
      deskripsi: json["description"] ?? "",
    );
  }
}
