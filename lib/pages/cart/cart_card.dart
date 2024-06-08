import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../models/keranjang_model.dart';
import '../../../view_models/keranjang_view_model.dart';

class CartCard extends StatelessWidget {
  final KeranjangModel keranjang;
  final int index;
  final Function(int index, int quantity) updateKeranjang;
  final KeranjangViewModel keranjangViewModel;

  const CartCard({
    Key? key,
    required this.keranjang,
    required this.index,
    required this.updateKeranjang,
    required this.keranjangViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = keranjang.quantity * keranjang.produk.price;
    final hargaString = NumberFormat('###,###,###').format(total);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(keranjang.produk.gambar),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  keranjang.produk.nama,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    text: "Rp $hargaString",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                  ),
                ),
                Container(
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        child: InkWell(
                          onTap: () {
                            if (keranjang.quantity > 1) {
                              updateKeranjang(
                                index,
                                --keranjang.quantity,
                              );
                            }
                          },
                          child: const Icon(Icons.remove),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: double.infinity,
                        decoration: const BoxDecoration(
                          border: Border.symmetric(
                            vertical: BorderSide(color: Colors.black26),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            keranjang.quantity.toString(),
                            style: const TextStyle(color: AppConstants.danger),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        child: InkWell(
                          onTap: () {
                            updateKeranjang(
                              index,
                              ++keranjang.quantity,
                            );
                          },
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              _showDeleteConfirmationDialog(context);
            },
            child: SvgPicture.asset(
              "assets/icons/Trash.svg",
              color: kPrimaryColor,
            ),
          ),
        ],
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
              "Apakah Anda yakin ingin menghapus item ini dari keranjang?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                _deleteItemFromCart(context);
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  void _deleteItemFromCart(BuildContext context) {
    if (keranjang.id != null) {
      keranjangViewModel.deleteKeranjang(idCart: keranjang.id!).then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Item berhasil dihapus dari keranjang"),
            ),
          );
          keranjangViewModel.removeKeranjangFromList(keranjang);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Gagal menghapus item dari keranjang"),
            ),
          );
        }
        Navigator.of(context).pop(); // Tutup dialog konfirmasi
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
