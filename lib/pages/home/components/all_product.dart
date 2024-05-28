import 'package:app_tani_sejahtera/components/product_card.dart';

import 'package:app_tani_sejahtera/pages/details/detail_page.dart';
import 'package:app_tani_sejahtera/pages/home/components/section_more.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../view_models/produk_view_model.dart';

class AllProduct extends StatelessWidget {
  final int? activeKategori;
  final String searchText;

  const AllProduct({
    Key? key,
    required this.searchText,
    required this.activeKategori,
  });

  @override
  Widget build(BuildContext context) {
    final listProduk = context.watch<ProdukViewModel>().listProduk;
    final status = context.watch<ProdukViewModel>().status;

    final searchList = listProduk.where((produk) {
      final searchLower = searchText.toLowerCase();
      final namaLower = produk.nama.toLowerCase();
      return namaLower.contains(searchLower);
    }).toList();
    final kategoriList = searchList.where((produk) {
      return produk.idKategori == activeKategori || activeKategori == null;
    }).toList();

    if (status == ServerStatus.loading) {
      return const CircularProgressIndicator();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 15, left: 20),
          child: Text(
            "Semua Produk",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: kategoriList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final model = kategoriList[index];
              return ProductCard(model: model);
            },
          ),
        ),
      ],
    );
  }
}
