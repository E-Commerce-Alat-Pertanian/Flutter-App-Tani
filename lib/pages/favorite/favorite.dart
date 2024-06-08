import 'package:app_tani_sejahtera/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/favorite_view_model.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteViewModel()..getFavorite(),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<FavoriteViewModel>(
            builder: (context, favoriteViewModel, child) {
              // Handle loading state
              if (favoriteViewModel.status == ServerStatus.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Handle empty or null favorite list
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
                  SizedBox(height: 20),
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
                            model: favorite.produk!,
                            favorite: favorite,
                            favoriteViewModel: favoriteViewModel,
                            showDeleteIcon: true,
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
