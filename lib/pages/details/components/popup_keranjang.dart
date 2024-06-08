import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../models/keranjang_model.dart';
import '../../../models/produk_model.dart';
import '../../../models/stok_model.dart';
import '../../../view_models/keranjang_view_model.dart';
import '../../../widgets/my_button.dart';

class PopupKeranjang extends StatefulWidget {
  final ProdukModel produk;

  const PopupKeranjang({
    Key? key,
    required this.produk,
  }) : super(key: key);

  @override
  State<PopupKeranjang> createState() => _PopupKeranjangState();
}

class _PopupKeranjangState extends State<PopupKeranjang> {
  String get _hargaString =>
      NumberFormat("###,###,###").format(widget.produk.price);

  int _jumlah = 1;

  void submitKeranjang() {
    final int? productId = widget.produk.id;
    if (productId != null) {
      final keranjang = KeranjangModel(
        produk: widget.produk,
        stok: StokModel(
          id: widget.produk.id,
          idProduct: productId,
          stok: widget.produk.stok,
        ),
        quantity: _jumlah,
      );

      context
          .read<KeranjangViewModel>()
          .updateKeranjang(keranjang: keranjang)
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Produk berhasil dimasukkan ke dalam keranjang"),
          ),
        );
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Produk tidak valid")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Image.network(
                      widget.produk.gambar,
                      height: 80,
                      width: 100,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rp$_hargaString",
                            style: const TextStyle(
                              color: AppConstants.danger,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Stok: ${widget.produk.stok}",
                            style: const TextStyle(
                                color: Colors.black38, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Row(
                  children: [
                    const Text("Jumlah"),
                    const Expanded(child: SizedBox()),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                            child: InkWell(
                              onTap: () {
                                if (_jumlah > 1) {
                                  setState(() => _jumlah--);
                                }
                              },
                              child: const Icon(Icons.remove),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                              border: Border.symmetric(
                                vertical: BorderSide(color: Colors.black26),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                _jumlah.toString(),
                                style:
                                    const TextStyle(color: AppConstants.danger),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            child: InkWell(
                              onTap: () => setState(() => _jumlah++),
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              MyButton(
                onPressed: submitKeranjang,
                margin: const EdgeInsets.all(12),
                minWidth: double.infinity,
                text: "Masukkan Keranjang",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
