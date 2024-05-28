import 'package:app_tani_sejahtera/pages/details/components/product_description.dart';
import 'package:app_tani_sejahtera/pages/details/components/top_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/produk_model.dart';
import '../../view_models/favorite_view_modell.dart'; // Fixed typo in import

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProdukModel produk =
        ModalRoute.of(context)!.settings.arguments as ProdukModel;
    // final idProduct = ModalRoute.of(context)!.settings.arguments as String;
    return ChangeNotifierProvider(
      create: (context) => FavoriteViewModel(),
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFFF5F6F9),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 250,
          leading: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    backgroundColor: Colors.white,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  "Detail Produk",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              width: 238,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(produk.gambar),
              ),
            ),
            TopRoundedContainer(
              color: Colors.white,
              child: Column(
                children: [
                  ProductDescription(
                    produk: produk,
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: TopRoundedContainer(
          color: Colors.white,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          "/keranjang",
                          arguments: produk,
                        );
                      },
                      child: const Text("Add To Cart"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Consumer<FavoriteViewModel>(
                    builder: (context, favoriteViewModel, child) {
                      return Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            favoriteViewModel.createFavorite(produk.id
                                .toString()); // Menggunakan id dari model produk
                          },
                          child: const Text("Add To Favorite"),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
