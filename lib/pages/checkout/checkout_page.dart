import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/keranjang_model.dart';
import '../../models/order_model.dart';
import '../../models/pembayaran_model.dart';
import '../../view_models/daerah_view_model.dart';
import '../../view_models/order_view_model.dart';
import '../../view_models/user_view_model.dart';
import '../address/address_page.dart';
import 'components/keranjang_section.dart';
import 'components/metode_bayar_section.dart';
import 'components/pengiriman_section.dart';
import 'components/rincian_section.dart';
import 'components/submit_section.dart';
import 'components/total_pesanan.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _listPembayaran = [
    PembayaranModel(
      gambar: "assets/images/cash-on-delivery.png",
      text: "COD",
    ),
    PembayaranModel(
      gambar: "assets/images/payment.png",
      text: "Transfer Bank",
    ),
  ];

  int _indexPembayaran = 0;
  bool _loading = true;

  void submitPesanan(List<KeranjangModel> listKeranjang, int totalHarga) async {
    final ongkir = context.read<DaerahViewModel>().ongkir;
    if (ongkir == null) {
      // Handle case when ongkir is null
      print("Ongkir is null, cannot proceed with submission.");
      return;
    }
    setState(() => _loading = true);

    final pembayaran = _listPembayaran[_indexPembayaran];
    final user = context.read<UserViewModel>().currentUser;

    final keranjangIds =
        listKeranjang.map((keranjang) => keranjang.id).join('');

    final order = OrderModel(
      status: "Pending",
      metodeBayar: pembayaran,
      ongkir: ongkir,
      kodeUnik: "${user?.id}${user?.idKecamatan}${keranjangIds}UDTS",
      totalPembayaran: totalHarga,
    );

    // Create order and wait for the result
    final success =
        await context.read<OrderViewModel>().createOrder(order, listKeranjang);

    if (success) {
      // Fetch the latest order list
      await context.read<OrderViewModel>().getOrder();
      final newOrder = context.read<OrderViewModel>().listOrder.last;

      setState(() => _loading = false);
      if (pembayaran.text == "COD") {
        Navigator.pop(context);
      } else {
        // Navigate to BerhasilPage with necessary arguments
        Navigator.pushNamed(
          context,
          "/berhasil",
          arguments: {
            'total': totalHarga + ongkir,
            'idOrder': newOrder.id, // Use the id from the latest order
          },
        ).then((_) => Navigator.pop(context));
      }
    } else {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<DaerahViewModel>().getOngkir().then((value) {
      setState(() => _loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final listKeranjang =
        ModalRoute.of(context)!.settings.arguments as List<KeranjangModel>;

    int totalHarga = 0;
    for (var keranjang in listKeranjang) {
      totalHarga += (keranjang.produk.price * keranjang.quantity).toInt();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: Consumer<DaerahViewModel>(
        builder: (context, daerahViewModel, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Alamat Pengiriman",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  AddressWidget(),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: KeranjangSection(listKeranjang: listKeranjang),
                  ),
                  PengirimanSection(ongkir: daerahViewModel.ongkir),
                  TotalPesananSection(
                    totalProduk: listKeranjang.length,
                    totalHarga: totalHarga,
                  ),
                  MetodeBayarSection(
                    listPembayaran: _listPembayaran,
                    activeIndex: _indexPembayaran,
                    onChange: (index) =>
                        setState(() => _indexPembayaran = index),
                  ),
                  RincianSection(
                    totalHarga: totalHarga,
                    ongkir: daerahViewModel.ongkir,
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  SubmitSection(
                    totalHarga: totalHarga,
                    ongkir: daerahViewModel.ongkir,
                    loading: _loading,
                    onSubmit: () => submitPesanan(listKeranjang, totalHarga),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
