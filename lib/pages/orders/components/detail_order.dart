import 'package:app_tani_sejahtera/models/order_model.dart';
import 'package:app_tani_sejahtera/models/keranjang_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../view_models/user_view_model.dart';
import '../../berhasil/berhasil_page.dart';

class DetailOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final OrderModel order = args['order'] as OrderModel;
    final List<KeranjangModel> keranjang =
        args['keranjang'] as List<KeranjangModel>? ?? [];

    final user = context.watch<UserViewModel>().currentUser;

    // Menghitung total pembayaran termasuk ongkir
    final subtotal = order.totalPembayaran;
    final ongkir = order.ongkir;
    final totalPayment = subtotal + ongkir;

    final subtotalFormatted = NumberFormat('###,###,###').format(subtotal);
    final ongkirFormatted = NumberFormat('###,###,###').format(ongkir);
    final totalFormatted = NumberFormat('###,###,###').format(totalPayment);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alamat Pengiriman',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text('${user?.username ?? ''}', style: TextStyle(fontSize: 16)),
            Text('${user?.alamat ?? ''}'),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: keranjang.length,
                itemBuilder: (context, index) {
                  final item = keranjang[index];
                  // Menghitung total harga untuk setiap item
                  final itemTotalPrice = item.produk.price * item.quantity;
                  final itemTotalPriceFormatted =
                      NumberFormat('###,###,###').format(itemTotalPrice);

                  return ListTile(
                    leading: Image.network(item.produk.gambar),
                    title: Text(item.produk.nama),
                    subtitle: Text('Quantity: ${item.quantity}'),
                    trailing: Text('Rp. $itemTotalPriceFormatted'),
                  );
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Status: ${order.status}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Metode Pembayaran: ${order.metodeBayar.text}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            if (order.status.toLowerCase() == "pending")
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BerhasilPage(),
                        settings: RouteSettings(
                          arguments:
                              totalPayment, // Passing the total payment amount
                        ),
                      ),
                    );
                  },
                  child: Text('Lanjutkan Pembayaran'),
                ),
              ),
            Divider(),
            Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Subtotal untuk Produk",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      "Rp.$subtotalFormatted",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Ongkir",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      "Rp.$ongkirFormatted",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
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
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "Rp.$totalFormatted",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppConstants.primary,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
