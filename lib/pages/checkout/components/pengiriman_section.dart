import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PengirimanSection extends StatelessWidget {
  final int? ongkir;
  const PengirimanSection({super.key, required this.ongkir});

  @override
  Widget build(BuildContext context) {
    String? ongkirString;
    if (ongkir != null) {
      ongkirString = NumberFormat("###,###,###").format(ongkir);
    }

    return Container(
      color: const Color(0xFFCCE7FF),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Opsi Pengiriman"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Reguler",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Rp ${ongkirString ?? ""}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
