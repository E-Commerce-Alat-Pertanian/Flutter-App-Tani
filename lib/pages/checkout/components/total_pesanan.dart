import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class TotalPesananSection extends StatelessWidget {
  final int totalProduk;
  final int totalHarga;

  const TotalPesananSection({
    super.key,
    required this.totalProduk,
    required this.totalHarga,
  });

  @override
  Widget build(BuildContext context) {
    final hargaString = NumberFormat("###,###,###").format(totalHarga);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Total Pesanan ($totalProduk Produk):"),
          Text(
            "Rp $hargaString",
            style: const TextStyle(color: AppConstants.primary),
          ),
        ],
      ),
    );
  }
}
