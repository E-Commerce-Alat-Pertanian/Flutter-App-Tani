import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/order_model.dart';
import '../../../models/keranjang_model.dart';

class OrderCard extends StatelessWidget {
  final List<KeranjangModel>? keranjang;
  final OrderModel? order;

  const OrderCard({
    Key? key,
    this.keranjang,
    this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = keranjang?.isNotEmpty ?? false ? keranjang![0] : null;

    // Calculate total payment including shipping
    final totalPayment = (order?.totalPembayaran ?? 0) + (order?.ongkir ?? 0);
    final totalFormatted = NumberFormat('###,###,###').format(totalPayment);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          "/DetailOrder",
          arguments: {
            'order': order,
            'keranjang': keranjang ?? [],
          },
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 60,
              child: AspectRatio(
                aspectRatio: 0.88,
                child: item != null
                    ? Image.network(item.produk.gambar)
                    : SizedBox(),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item?.produk.nama ?? 'Product Name Not Available',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Status: ${order?.status ?? ''}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Total Pembayaran: Rp $totalFormatted',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
