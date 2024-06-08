import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/keranjang_model.dart';

class KeranjangItem extends StatelessWidget {
  final KeranjangModel keranjang;
  const KeranjangItem({super.key, required this.keranjang});

  @override
  Widget build(BuildContext context) {
    final hargaString =
        NumberFormat("###,###,###").format(keranjang.produk.price);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Image.network(
            keranjang.produk.gambar,
            height: 80,
            width: 100,
          ),
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(keranjang.produk.nama),
                      Text("Rp $hargaString"),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 30,
                  child: Text(
                    "x${keranjang.quantity}",
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
