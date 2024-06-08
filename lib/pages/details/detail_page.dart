import 'package:app_tani_sejahtera/pages/details/components/product_description.dart';
import 'package:app_tani_sejahtera/pages/details/components/top_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/produk_model.dart';
import '../../view_models/favorite_view_model.dart';
import 'components/popup_keranjang.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  Future<void> _showDialog(BuildContext context, String title, String message,
      {Function()? onOkPressed}) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (onOkPressed != null) {
                  onOkPressed();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ProdukModel produk =
        ModalRoute.of(context)!.settings.arguments as ProdukModel;
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
                    child: Container(
                      height: 60,
                      color: AppConstants.secondary.withOpacity(.6),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return PopupKeranjang(
                                produk: produk,
                              );
                            },
                          );
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              "Add to Cart",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Consumer<FavoriteViewModel>(
                    builder: (context, favoriteViewModel, child) {
                      return Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final response = await favoriteViewModel
                                .createFavorite(produk.id.toString());

                            if (response == 201) {
                              // Show success dialog and navigate to favorite page
                              await _showDialog(
                                context,
                                'Success',
                                'Product added to favorites!',
                                onOkPressed: () {
                                  Navigator.pushNamed(context, '/favorite');
                                },
                              );
                            } else if (response == 400) {
                              // Show warning dialog
                              await _showDialog(
                                context,
                                'Warning',
                                'Product is already in your favorites!',
                              );
                            } else {
                              // Show generic error dialog
                              await _showDialog(
                                context,
                                'Error',
                                'Failed to add product to favorites. Please try again later.',
                              );
                            }
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
