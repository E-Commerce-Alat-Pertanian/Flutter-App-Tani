import 'package:app_tani_sejahtera/components/product_card.dart';
import 'package:app_tani_sejahtera/pages/details/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/favorite_view_modell.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteViewModel()..getFavorite(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Favorites"),
        ),
        body: SafeArea(
          child: Consumer<FavoriteViewModel>(
            builder: (context, favoriteViewModel, child) {
              if (favoriteViewModel.listFavorite.isEmpty) {
                return Center(
                  child: Text(
                    "No favorites found",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                );
              }
              return Column(
                children: [
                  Text(
                    "Favorites",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridView.builder(
                        itemCount: favoriteViewModel.listFavorite.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          final favorite =
                              favoriteViewModel.listFavorite[index];
                          return ProductCard(
                            model: favorite.produk,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
