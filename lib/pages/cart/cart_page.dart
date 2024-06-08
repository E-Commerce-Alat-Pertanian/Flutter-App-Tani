import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../models/keranjang_model.dart';
import '../../view_models/keranjang_view_model.dart';
import '../checkout/checkout_page.dart';
import 'cart_list.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<KeranjangModel> get _listKeranjang =>
      context.read<KeranjangViewModel>().listKeranjang;

  dynamic get _total {
    double total = 0;
    for (var keranjang in _listKeranjang) {
      total += keranjang.produk.price * keranjang.quantity;
    }
    return total;
  }

  // List<KeranjangModel> get _listOrder {
  //   final List<KeranjangModel> listOrder = [];

  //   for (var keranjang in _listKeranjang) {
  //     listOrder.add(keranjang);
  //   }

  //   return listOrder;
  // }

  String get _totalString => NumberFormat('###,###,###').format(_total);
  // Fungsi untuk memperbarui keranjang
  void updateKeranjang(int index, int quantity) {
    _listKeranjang[index].quantity = quantity;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    context.read<KeranjangViewModel>().getKeranjang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Saya"),
      ),
      body: Column(
        children: [
          Expanded(
            child: CartListView(
              updateKeranjang: updateKeranjang,
            ),
          ),
          Container(
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Total ",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        "Rp$_totalString",
                        style: const TextStyle(
                          color: AppConstants.danger,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    color: AppConstants.secondary,
                    child: InkWell(
                      onTap: () {
                        if (_listKeranjang.isEmpty) return;
                        Navigator.pushNamed(
                          context,
                          "/checkout",
                          arguments: _listKeranjang,
                        ).then((_) {
                          context.read<KeranjangViewModel>().getKeranjang();
                        });
                      },
                      child: Center(
                        child: Text(
                          "Checkout (${_listKeranjang.length})",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
