import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../models/keranjang_model.dart';
import '../../../models/order_model.dart';
import '../../../view_models/user_view_model.dart';
import '../../../widgets/my_button.dart';
import '../../berhasil/berhasil_page.dart';
import '../../details/components/top_rounded_container.dart';
import 'detail_image.dart';

class DetailOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final OrderModel order = args['order'] as OrderModel;
    final List<KeranjangModel> keranjang =
        args['keranjang'] as List<KeranjangModel>? ?? [];
    final productIds = keranjang.map((item) => item.produk.id).join('');
    final user = context.watch<UserViewModel>().currentUser;

    final subtotal = order.totalPembayaran;
    final ongkir = order.ongkir;
    final totalPayment = subtotal + ongkir;

    final subtotalFormatted = NumberFormat('###,###,###').format(subtotal);
    final ongkirFormatted = NumberFormat('###,###,###').format(ongkir);
    final totalFormatted = NumberFormat('###,###,###').format(totalPayment);

    Color _getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case 'pending':
          return Colors.red;
        case 'dikirim':
          return Colors.blue;
        case 'completed':
          return Colors.green;
        default:
          return Colors.black;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Order'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alamat Pengiriman',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text('${user?.username ?? ''} - ${user?.noHp}',
                    style: TextStyle(fontSize: 16)),
                Text('${user?.alamat ?? ''}'),
              ],
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: keranjang.length,
              itemBuilder: (context, index) {
                final item = keranjang[index];
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
          TopRoundedContainer(
            color: kPrimaryLightColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "No order: ${order.kodeUnik}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Status: ${order.status}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(order.status),
                    ),
                  ),
                  Text(
                    "Metode Pembayaran: ${order.metodeBayar.text}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  if (order.status.toLowerCase() == "pending")
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Column(
                        children: [
                          MyButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BerhasilPage(),
                                  settings: RouteSettings(
                                    arguments: {
                                      'total': totalPayment,
                                      'idOrder': order.id,
                                    },
                                  ),
                                ),
                              );
                            },
                            text: 'Lanjutkan Pembayaran',
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailImagePage(
                                  imageUrl: order.imagePembayaran),
                            ),
                          );
                        },
                        child: Text(
                          'Lihat Bukti Pembayaran',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      if (order.status.toLowerCase() == "completed")
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailImagePage(
                                      imageUrl: order.imageKurir),
                                ),
                              );
                            },
                            child: Text(
                              'Lihat Bukti Pengiriman',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Divider(),
                  Column(
                    children: [
                      const SizedBox(height: 5),
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
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            "Rp.$totalFormatted",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppConstants.secondary,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
