import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';

class RincianSection extends StatelessWidget {
  final int totalHarga;
  final int? ongkir;

  const RincianSection({
    super.key,
    required this.totalHarga,
    required this.ongkir,
  });

  @override
  Widget build(BuildContext context) {
    final hargaString = NumberFormat("###,###,###").format(totalHarga);

    String? ongkirString;
    String? totalString;
    if (ongkir != null) {
      ongkirString = NumberFormat("###,###,###").format(ongkir);
      totalString = NumberFormat("###,###,###").format(ongkir! + totalHarga);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // SvgPicture.asset("assets/icons/ic_rincian.svg"),
              const SizedBox(width: 10),
              const Text(
                "Rincian Pembayaran",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Subtotal untuk Produk",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                "Rp $hargaString",
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Subtotal Pengiriman",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                "Rp ${ongkirString ?? ""}",
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Pembayaran",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                "Rp ${totalString ?? ""}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
