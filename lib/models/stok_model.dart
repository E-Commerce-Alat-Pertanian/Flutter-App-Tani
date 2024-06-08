class StokModel {
  final int id;
  final int idProduct;
  final int stok;

  StokModel({
    required this.id,
    required this.idProduct,
    required this.stok,
  });

  factory StokModel.fromJson(Map<String, dynamic> json) {
    return StokModel(
      id: json['idStok'] ?? 0, // Use correct key from JSON
      idProduct: json['idProduct'] ?? 0,
      stok: json['stok'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idProduct': idProduct,
      'stok': stok,
    };
  }
}
