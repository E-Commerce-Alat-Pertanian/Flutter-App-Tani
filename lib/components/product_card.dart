import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/favorite_model.dart';
import '../models/produk_model.dart';
import '../view_models/favorite_view_model.dart';

class ProductCard extends StatelessWidget {
  final ProdukModel model;
  final FavoriteModel? favorite;
  final FavoriteViewModel? favoriteViewModel;
  final bool showDeleteIcon;

  const ProductCard({
    Key? key,
    required this.model,
    this.favorite,
    this.favoriteViewModel,
    this.showDeleteIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###,000");
    final harga = formatter.format(model.price);

    return SizedBox(
      child: Opacity(
        opacity: model.stok == 0 ? 0.5 : 1.0, // Set opacity based on stock
        child: GestureDetector(
          onTap: model.stok != 0
              ? () {
                  Navigator.pushNamed(
                    context,
                    "/DetailProduk",
                    arguments: model,
                  );
                }
              : null, // Disable onTap if stock is 0
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(model.gambar, fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    model.nama,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rp $harga", // Tetap menampilkan harga
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: model.stok != 0 ? kPrimaryColor : Colors.red,
                        ),
                      ),
                      if (showDeleteIcon)
                        IconButton(
                          onPressed: () {
                            _showDeleteConfirmationDialog(context);
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                    ],
                  ),
                ),
                if (model.stok == 0) // Tampilkan label "Habis" jika stok habis
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Habis",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi"),
          content: const Text(
              "Apakah Anda yakin ingin menghapus item ini dari favorit?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                _deleteFavorite(
                    context); // Panggil fungsi _deleteFavorite dengan meneruskan context
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  void _deleteFavorite(BuildContext context) async {
    if (favorite?.id != null) {
      favoriteViewModel
          ?.deleteFavorite(idFavorite: favorite!.id!)
          .then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Item berhasil dihapus dari keranjang"),
            ),
          );
          favoriteViewModel?.removeFavoriteFromList(favorite!);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Gagal menghapus item dari keranjang"),
            ),
          );
        }
        Navigator.of(context).pop();
      }).catchError((error) {
        print("Error deleting item from cart: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text("Terjadi kesalahan saat menghapus item dari keranjang"),
          ),
        );
        Navigator.of(context).pop(); // Tutup dialog konfirmasi
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Item tidak memiliki ID yang valid"),
        ),
      );
      Navigator.of(context).pop(); // Tutup dialog konfirmasi
    }
  }
}
