class ProvinsiModel {
  final String id;
  final String nama;

  ProvinsiModel({
    required this.id,
    required this.nama,
  });

  factory ProvinsiModel.fromJson(Map<String, dynamic> json) {
    return ProvinsiModel(
      id: json["province_id"],
      nama: json["province"],
    );
  }
}
