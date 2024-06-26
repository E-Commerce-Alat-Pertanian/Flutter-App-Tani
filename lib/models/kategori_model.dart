class KategoriModel {
  final int id;
  final String nama;

  KategoriModel({
    required this.id,
    required this.nama,
  });

  factory KategoriModel.fromJson(Map<String, dynamic> json) {
    return KategoriModel(
      id: json["idCategory"],
      nama: json["nama"],
    );
  }
}
