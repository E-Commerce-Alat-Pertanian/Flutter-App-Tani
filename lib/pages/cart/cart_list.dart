import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../models/keranjang_model.dart';
import '../../view_models/keranjang_view_model.dart';
import 'cart_card.dart'; // Import CartCard

class CartListView extends StatelessWidget {
  final Function(int index, int quantity) updateKeranjang;

  const CartListView({
    Key? key,
    required this.updateKeranjang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listKeranjang = context.watch<KeranjangViewModel>().listKeranjang;
    final keranjangViewModel =
        context.read<KeranjangViewModel>(); // Add this line

    return ListView.builder(
      itemCount: listKeranjang.length,
      itemBuilder: (context, index) {
        final keranjang = listKeranjang[index];
        return CartCard(
          keranjang: keranjang,
          index: index,
          updateKeranjang: updateKeranjang,
          keranjangViewModel: keranjangViewModel, // Add this line
        );
      },
    );
  }
}
