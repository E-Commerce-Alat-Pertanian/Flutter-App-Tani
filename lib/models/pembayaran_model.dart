class PembayaranModel {
  final String gambar;
  final String text;

  PembayaranModel({
    required this.gambar,
    required this.text,
  });

  factory PembayaranModel.fromJson(Map<String, dynamic> map) {
    return PembayaranModel(
      gambar: map['gambar'] ?? '',
      text: map['text'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "gambar": gambar,
      "text": text,
    };
  }
}
