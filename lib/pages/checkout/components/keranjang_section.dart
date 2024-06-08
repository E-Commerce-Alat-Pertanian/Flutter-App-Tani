import 'package:app_tani_sejahtera/pages/checkout/components/keranjang_item.dart';
import 'package:flutter/material.dart';

import '../../../models/keranjang_model.dart';

class KeranjangSection extends StatelessWidget {
  final List<KeranjangModel> listKeranjang;
  const KeranjangSection({super.key, required this.listKeranjang});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listKeranjang.length,
      itemBuilder: (context, index) {
        final keranjang = listKeranjang[index];
        return KeranjangItem(keranjang: keranjang);
      },
    );
  }
}
