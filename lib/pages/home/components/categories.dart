import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/kategori_view_model.dart';

class Categories extends StatelessWidget {
  final int? activeKategori;
  final Function(int kategori) onTap;

  const Categories({
    Key? key,
    required this.activeKategori,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"image": "assets/images/pupuk.png", "id": "1"},
      {"image": "assets/images/pesticida.png", "id": "2"},
      {"image": "assets/images/bibit.png", "id": "3"},
      {"image": "assets/images/alat.png", "id": "4"},
    ];
    final listKategori = context.watch<KategoriViewModel>().listKategori;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Categories",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: listKategori.map((kategori) {
              final active = kategori.id == activeKategori;
              final image = categories.firstWhere((element) =>
                  element["id"] == kategori.id.toString())["image"];

              return CategoryCard(
                text: kategori.nama,
                active: active,
                image: image,
                onTap: () => onTap(kategori.id),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.text,
    required this.image, // Terima gambar dari Categories
    this.onTap,
    this.active = false,
  }) : super(key: key);

  final String text;
  final String image; // Gambar untuk kategori
  final Function()? onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.symmetric(horizontal: 9),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: active ? Colors.grey : Color.fromARGB(255, 181, 209, 255),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(text, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
