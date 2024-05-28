class KecamatanModel {
  final String id;
  final String nama;
  final String idProvinsi; // Add this property

  KecamatanModel({
    required this.id,
    required this.nama,
    required this.idProvinsi, // Add this parameter
  });

  factory KecamatanModel.fromJson(Map<String, dynamic> json) {
    return KecamatanModel(
      id: json["city_id"],
      nama: json["city_name"],
      idProvinsi: json["province_id"], // Parse this from JSON
    );
  }
}
